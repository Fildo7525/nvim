-- MARKDOWN PREVIEW
return {
	"iamcco/markdown-preview.nvim",
	build = "cd app && npm install",
	config = function(opts)
		vim.g.mkdp_filetypes = { "markdown" }
		vim.g.mkdp_theme = 'light'
		vim.g.mkdp_page_title = 'Filip Lobpreis: ${name}'
		return opts
	end,
	ft = { "markdown" },
}

