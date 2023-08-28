return {
	settings = {
		cmd = { vim.fn.stdpath("data") .. "/mason/bin/pyright-langserver", "--stdio" },
		filetypes = { "python" },
		root_dir = function(fname)
			return require("lspconfig").util.find_git_ancestor(fname) or vim.fn.getcwd()
		end,
		python = {
			disableLanguageServices = false,
			disableOrganizeImports = false,
			openFilesOnly = false,
			analysis = {
				autoImportCompletions = true,
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				typeCheckingMode = "basic", -- off, basic, strict
				useLibraryCodeForTypes = true,
			}
		},
		single_file_support = true,
	},
}
