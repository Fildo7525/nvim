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
			"--fallback-style=~/.config/nvim/.clang-format",
			"--completion-style=bundled",
	},
	filetypes = { "c", "cpp", "objc", "objcpp" },
	single_file_support = true,
	init_options = {
		compilationDatabasePath="build",
	},
	on_attach = require("usr.lsp.handlers").on_attach,
	capabilities = require("usr.lsp.handlers").capabilities,
}
