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

return {
	cmd = {
		"texlab",
	},
	filetypes = { "tex", "plaintex", "bib" },
	root_dir = function(bufnr)
		return vim.fs.root(bufnr, root_files)
	end,
	single_file_support = true,
	flags = {
		allow_incremental_sync = false,
	},
	settings = {
		texlab = {
			rootDirectory = rDir(fname),
			build = {
				args = { "-src", "-silent", "-output-directory=build", "-interaction=nonstopmode", "-synctex=1", "%f" },
				executable = "latexmk",
				forwardSearchAfter = true,
				onSave = false
			},
			auxDirectory = "build",
			--[[ forwardSearch = { ]]
			--[[ 	executable = "pdflatex", ]]
			--[[ 	args = { ]]
			--[[ 		" -synctex=1", ]]
			--[[ 		"-interaction=nonstopmode", ]]
			--[[ 		"-output-directory=.build", ]]
			--[[ 		"%f", ]]
			--[[ 	} ]]
			--[[ }, ]]
			forwardSearch = {
				args = { "--synctex-forward", "%l:1:%f", "%p" },
				executable = "zathura",
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
			formatterLineLength = 125,
			bibtexFormatter = "texlab",
			latexFormatter = "latexindent",
			latexindent = {
				modifyLineBreaks = true,
			}
		}
	},
}

