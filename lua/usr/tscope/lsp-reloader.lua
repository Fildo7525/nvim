local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require "telescope.config" .values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local lspconfig = require "lspconfig"

local directories = {
	".",
}

local M = {}

local function table_size(table)
	local size = 0

	for _ in pairs(table) do
		size = size + 1
	end

	return size
end

local function merge_tables(lhs, rhs)
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
function M.find_build_dirs(directory)
	local i, t, popen = 0, {}, io.popen

	local pfile = popen('find ' .. directory .. ' -maxdepth 2 -type f -name "compile_commands.json"')
	if pfile == nil then
		return t
	end

	for filename in pfile:lines() do
		i = i + 1
		local start = filename:find("./") + 2 or 1
		local stop = filename:find("/compile_commands.json") - 1 or string.len(filename)
		local tmp = filename:sub(start, stop)

		if string.len(tmp) > 1 then
			t[i] = tmp
		end
	end
	pfile:close()

	return t
end

--- Terminates all clients that have no buffers attached to it.
function M.terminate_detached_clients()
	local clients = vim.lsp.get_active_clients()

	for _, client in ipairs(clients) do
		if table_size(client.attached_buffers) == 0 then
			client.rpc.terminate()
		end
	end
end

--- Telescope picker changing the compilationDatabasePath where compile_commands.json is located.
---@param directory? string? Directory to parse for build directories. If nil the cwd is parsed.
function M.change_compilation_source(directory)
	local opts = require('telescope.themes').get_dropdown{}
	if not opts then
		vim.notify("You cannot start a telescope picker with null options")
		return
	end

	-- This needs to change in nvim 0.10 to vim.lsp.get_clients
	local current_client = vim.lsp.get_active_clients({name="clangd"})
	if not current_client then
		vim.notify("The clangd server is not running.", vim.log.levels.ERROR)
		return
	end

	local used_dir = current_client[1].config.init_options.compilationDatabasePath
	local options = {
		on_attach = current_client[1].config.on_attach,
		capabilities = current_client[1].config.capabilities,
	}

	local parsed_dirs = { used_dir }

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

				-- Set the new clangd client with the selected path
				local selection = action_state.get_selected_entry()
				local clangd_opts = require("usr.lsp.settings.clangd");
				clangd_opts.init_options = {compilationDatabasePath = selection[1]}
				clangd_opts = vim.tbl_deep_extend("force", clangd_opts, options)
				print("Starting clangd client " .. clangd_opts.init_options.compilationDatabasePath)
				lspconfig['clangd'].setup(clangd_opts)

				-- Close current clangd client
				print("Closing current clangd client " .. used_dir)
				--[[ vim.lsp.stop_client(current_client[1], true) ]]
				current_client[1].rpc.terminate()

				-- Start the new client
				vim.lsp.start_client(lspconfig['clangd'])
				M.terminate_detached_clients()
			end)
			return true
		end,
	}):find()

	M.terminate_detached_clients()
end

return M

