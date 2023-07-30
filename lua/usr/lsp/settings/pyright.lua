return {
	settings = {
		cmd = { vim.fn.stdpath("data") .. "/mason/bin/pyright-langserver", "--stdio" },
		filetypes = { "python" },
		root_dir = function(fname)
			return require("lspconfig").util.find_git_ancestor(fname) or vim.fn.getcwd()
		end,
		python = {
			analysis = {
				typeCheckingMode = "off",
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true
			}
		},
		single_file_support = true,
	},
}
