---@class lsp.ClientCapabilities
local local_cap = vim.lsp.protocol.make_client_capabilities()
local util = require 'lspconfig.util'
local_cap.offsetEncoding = { "utf-16" }

local root_files = {
	'.clangd',
	'.clang-tidy',
	'.clang-format',
	'compile_commands.json',
	'compile_flags.txt',
	'build.sh', -- buildProject
	'configure.ac', -- AutoTools
	'run',
	'compile',
}

-- TODO: add clang-tidy to on_atach with clangd
return {
	cmd = { "clangd",
		"--all-scopes-completion",
		"--background-index",
		"--clang-tidy",
		"--compile_args_from=filesystem", -- lsp-> does not come from compie_commands.json
		"--completion-parse=always",
		"--completion-style=bundled",
		"--cross-file-rename",
		"--debug-origin",
		"--enable-config", -- clangd 11+ supports reading from .clangd configuration file
		"--fallback-style=Qt",
		"--folding-ranges",
		"--function-arg-placeholders",
		"--header-insertion=iwyu",
		"--pch-storage=memory", -- could also be disk
		"--suggest-missing-includes",
		"-j=4",		-- number of workers
		-- "--resource-dir="
		"--log=error",
		--[[ "--query-driver=/usr/bin/g++", ]]
	},
	filetypes = { "c", "cpp", "objc", "objcpp" },
	root_dir = function(fname)
			return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
		end,
	single_file_support = true,
	init_options = {
		compilationDatabasePath = vim.fn.getcwd() .. "/build",
	},
	capabilities = local_cap,
	commands = {

	},
}
