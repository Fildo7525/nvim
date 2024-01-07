local util = require 'lspconfig.util'

--[[ local root_files = { ]]
--[[ 	'.venv', ]]
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

local function getPipenvPath()
	local env = os.getenv('VIRTUAL_ENV')
	if env == nil or #env == 0 then
		return '/usr/bin/python'
	end
	return env .. '/bin/python'
end

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
			},
			pythonPath = getPipenvPath(),
			venvPath = os.getenv('VIRTUAL_ENV') or '',
		},
		single_file_support = true,
	},
}
