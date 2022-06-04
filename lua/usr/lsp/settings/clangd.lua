local local_cap = vim.lsp.protocol.make_client_capabilities()
local_cap.offsetEncoding = { "utf-16" }

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
	single_file_support = true,
	init_options = {
		compilationDatabasePath="build",
	},
	capabilities = local_cap,
}
