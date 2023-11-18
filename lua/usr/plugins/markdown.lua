-- MARKDOWN PREVIEW
return {
	"iamcco/markdown-preview.nvim",
	build = "cd app && npm install",
	config = function(opts)
		vim.g.mkdp_filetypes = { "markdown" }
		return opts
	end,
	ft = { "markdown" },
}

