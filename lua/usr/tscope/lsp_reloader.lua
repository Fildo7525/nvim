local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require "telescope.config" .values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local lspconfig = require "lspconfig"

local directories = {
}

local options = {
	on_attach = require("usr.lsp.handlers").on_attach,
	capabilities = require("usr.lsp.handlers").capabilities,
}

local M = {}

local get_client_buffers = function (clientName)
	local clients = vim.lsp.get_active_clients()
	local numbers = {}
	for _, value in ipairs(clients) do
		if value.name == clientName then
			 table.insert(numbers, value)
		end
	end
	return numbers
end

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
		table.insert(copy, value)
	end
	return copy
end

--- Parses the inputed directory for build directories.
---@param directory string Directory to be parsed
---@return table of directories located in the directory
M.find_build_dirs = function (directory)
	local i, t, popen = 0, {}, io.popen

	local pfile = popen('find ' .. directory .. ' -maxdepth 1 -type d | grep build')
	if pfile == nil then
		return {}
	end

	for filename in pfile:lines() do
		i = i + 1
		t[i] = filename
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
---@param directory string Directory to parse for build directories. If nil the cwd is parsed.
M.change_compilation_source = function(directory)
	local opts = require('telescope.themes').get_dropdown{}
	local parsed_dirs = M.find_build_dirs(directory or ".")

	pickers.new(opts, {
		prompt_title = "compilationDatabasePath",
		finder = finders.new_table {
			results = merge_tables(parsed_dirs, directories),
		},
		sorter = conf.generic_sorter(opts),
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				vim.lsp.stop_client(get_client_buffers("clangd"), true)

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

