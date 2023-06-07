local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require "telescope.config" .values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local lspconfig = require "lspconfig"

local directories = {
	".",
}

local options = {
	on_attach = require("usr.lsp.handlers").on_attach,
	capabilities = require("usr.lsp.handlers").capabilities,
}

local M = {}

local table_size = function (table)
	local size = 0

	for _ in pairs(table) do
		size = size + 1
	end

	return size
end

local merge_tables = function (lhs, rhs)
	local copy = lhs
	for _, value in ipairs(rhs) do
		if not vim.tbl_contains(copy, value) then
			table.insert(copy, value)
		end
	end
	return copy
end

--- Parses the inputed directory for build directories.
---@param directory string Directory to be parsed
---@return table Table of directories located in the directory
M.find_build_dirs = function (directory)
	local i, t, popen = 0, {}, io.popen

	local pfile = popen('find ' .. directory .. ' -maxdepth 1 -type d | grep build')
	if pfile == nil then
		return t
	end

	for filename in pfile:lines() do
		i = i + 1
		t[i] = filename:gsub("./", "")
	end
	pfile:close()

	return t
end

--- Terminates all clients that have no buffers attached to it.
M.terminate_detached_clients = function ()
	local clients = vim.lsp.get_active_clients()

	for _, value in ipairs(clients) do
		if table_size(value.attached_buffers) == 0 then
			value.rpc.terminate()
		end
	end
end

--- Telescope picker changing the compilationDatabasePath where compile_commands.json is located.
---@param directory? string? Directory to parse for build directories. If nil the cwd is parsed.
M.change_compilation_source = function(directory)
	local opts = require('telescope.themes').get_dropdown{}
	local parsed_dirs = { vim.lsp.get_active_clients({name="clangd"})[1].config.init_options.compilationDatabasePath }
	parsed_dirs = merge_tables(parsed_dirs, M.find_build_dirs(directory or "."))

	pickers.new(opts, {
		prompt_title = "compilationDatabasePath",
		finder = finders.new_table {
			results = merge_tables(parsed_dirs, directories),
		},
		sorter = conf.generic_sorter(opts),
		attach_mappings = function(prompt_bufnr)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				local client = vim.lsp.get_active_clients({name = "clangd"})
				if #client == 0 then
					vim.notify("The clangd server is not running.", vim.log.levels.ERROR)
					return
				end

				vim.lsp.stop_client(client, true)

				local clangConfig = require("usr.lsp.settings.clangd");
				clangConfig.init_options = {compilationDatabasePath = selection[1]}
				clangConfig = vim.tbl_deep_extend("force", clangConfig, options)
				lspconfig['clangd'].setup(clangConfig)

				vim.lsp.start_client(lspconfig['clangd'])
				-- Does not work in here. However, when you call it separately, it works.
				M.terminate_detached_clients()
			end)
			return true
		end,
	}):find()
end

return M

