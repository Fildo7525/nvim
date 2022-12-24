local util = require 'lspconfig.util'

local root_files = {
	'.clangd',
	'.clang-tidy',
	'.clang-format',
	'compile_commands.json',
	'compile_flags.txt',
	'build.sh', -- buildProject
	'configure.ac', -- AutoTools
	'.gitignore',
}

local function rDir(fname)
	return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
end

return {
	cmd = {
		"texlab",
	},
	filetypes = { "tex", "plaintex", "bib" },
	root_dir = rDir(fname),
	single_file_support = true,
	settings = {
		texlab = {
			rootDirectory = rDir(fname),
			build = {
				args = { "-src", "-silent", "-output-directory=.build", "-interaction=nonstopmode", "-synctex=1", "%f" },
				executable = "latexmk",
				forwardSearchAfter = true,
				onSave = false
			},
			auxDirectory = ".build",
			forwardSearch = {
				executable = "pdflatex",
				args = {
					" -synctex=1",
					"-interaction=nonstopmode",
					"-output-directory=.build",
					"%f",
					--[[ "%p", ]]
					--[[ "%l", ]]
				}
			},
			chktex = {
				onOpenAndSave = true,
				onEdit = false,
			},
			diagnosticsDelay = 300,
			diagnostic = {
				allowedPatterns = {},
				ignoredPatterns = {},
			},
			formatterLineLength = 80,
			bibtexFormatter = "texlab",
			latexFormatter = "latexindent",
			latexindent = {
				modifyLineBreaks = true,
			}
		}
	},
}

