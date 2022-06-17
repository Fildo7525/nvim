local local_cap = vim.lsp.protocol.make_client_capabilities()
local util = require 'lspconfig.util'
local_cap.offsetEncoding = { "utf-16" }

local root_files = {
	'.clangd',
	'.clang-tidy',
	'.clang-format',
	'compile_commands.json',
	'compile_flags.txt',
	'configure.ac', -- AutoTools
}

-- TODO: add clang-tidy to on_atach with clangd
return {
	cmd = { "clangd",
			"--background-index",
			"--suggest-missing-includes",
			"--all-scopes-completion",
			"--clang-tidy",
			"--cross-file-rename",
			"-j=2",		-- number of workers
			"--header-insertion=iwyu",
			"--compile_args_from=filesystem", -- lsp-> does not come from compie_commands.json
			"--completion-style=bundled",
	},
	filetypes = { "c", "cpp", "objc", "objcpp" },
	root_dir = function(fname)
			return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
		end,
	single_file_support = true,
	init_options = {
		compilationDatabasePath="build",
	},
	capabilities = local_cap,
	commands = {

	},
}
