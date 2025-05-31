---@class lsp.ClientCapabilities
local local_cap = vim.lsp.protocol.make_client_capabilities()
local util = require 'lspconfig.util'
local_cap.offsetEncoding = { "utf-16" }

local root_files = {
	'.clangd',
	'.clang-tidy',
	'.clang-format',
	'.git',
	'compile_commands.json',
	'compile_flags.txt',
	'build.sh', -- buildProject
	'configure.ac', -- AutoTools
	'run',
	'compile',
}

local function get_clangd_path()
	local current_dir = vim.fn.getcwd()
	if current_dir:find("/esp") then
		return vim.fn.getenv("HOME") .. "/Documents/STU/LS/TP/esp-clang/bin/clangd"
	else
		return "clangd"
	end
end

-- TODO: add clang-tidy to on_atach with clangd
return {
	cmd = { get_clangd_path(),
		"--all-scopes-completion",
		"--background-index",
		"--clang-tidy",
		"--compile_args_from=filesystem", -- lsp-> does not come from compie_commands.json
		"--completion-parse=always",
		"--completion-style=bundled",
		"--debug-origin",
		"--enable-config", -- clangd 11+ supports reading from .clangd configuration file
		"--fallback-style=Qt",
		"--header-insertion=iwyu",
		"--pch-storage=memory", -- could also be disk
		"-j=4",		-- number of workers
		-- "--resource-dir="
		"--log=error",
		--[[ "--query-driver=/usr/bin/g++", ]]
	},
	filetypes = { "c", "cpp", "objc", "objcpp" },
	root_dir = function(bufnr)
			return vim.fs.root(bufnr, root_files)
		end,
	single_file_support = true,
	init_options = {
		compilationDatabasePath = vim.fn.getcwd() .. "/build",
	},
	capabilities = local_cap,
	commands = {

	},
}
