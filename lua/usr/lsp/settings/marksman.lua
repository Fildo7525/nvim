local util = require 'lspconfig.util'

local bin_name = 'marksman'
local cmd = { bin_name, 'server' }

local root_files = {
	'.marksman.toml',
	'.marksman.yaml',
	'.git',
	'.gitignore',
	'.gitmodules',
}

return {
	default_config = {
		cmd = cmd,
		filetypes = { 'markdown', 'markdown.mdx' },
		root_dir = function(fname)
			return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
		end,
		single_file_support = true,
	},
	docs = {
		description = [[
https://github.com/artempyanykh/marksman

Marksman is a Markdown LSP server providing completion, cross-references, diagnostics, and more.

Marksman works on MacOS, Linux, and Windows and is distributed as a self-contained binary for each OS.

Pre-built binaries can be downloaded from https://github.com/artempyanykh/marksman/releases
]],
	},
}
