local util = require 'lspconfig.util'

--[[ local root_files = { ]]
--[[ 	'main.py', ]]
--[[ 	'pyproject.toml', ]]
--[[ 	'setup.py', ]]
--[[ 	'setup.cfg', ]]
--[[ 	'requirements.txt', ]]
--[[ 	'Pipfile', ]]
--[[ 	'pyrightconfig.json', ]]
--[[ 	'run', ]]
--[[ 	'compile', ]]
--[[ } ]]

return {
	settings = {
		cmd = { vim.fn.stdpath("data") .. "/mason/bin/pyright-langserver", "--stdio" },
		filetypes = { "python" },
		--[[ root_dir = function(fname) ]]
		--[[ 	return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname) ]]
		--[[ end, ]]
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
