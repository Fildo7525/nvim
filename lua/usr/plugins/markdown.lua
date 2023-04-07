-- MARKDOWN PREVIEW
return {
	"iamcco/markdown-preview.nvim",
	build = "cd app && npm install",
	config = function()
		vim.g.mkdp_filetypes = { "markdown" }
	end,
	ft = { "markdown" },
}

