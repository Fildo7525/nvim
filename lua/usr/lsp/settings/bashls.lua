local util = require 'lspconfig.util'

local root_files = {
	'.clangd',
	'.clang-tidy',
	'.clang-format',
	'compile_commands.json',
	'compile_flags.txt',
	'compile', -- buildProject
	'configure.ac', -- AutoTools
	'run'
}


return {
	cmd = {
		"bash-language-server",
		"start",
	},
	cmd_env = {
		GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)"
	},
	filetypes = {
		"sh",
		"zsh",
		"bash",
	},
	root_dir = function(bufnr)
		return vim.fs.root(bufnr, root_files)
	end,
	single_file_support = true,
}

