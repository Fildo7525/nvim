local treesitter = require("nvim-treesitter.configs")

require("ts_context_commentstring").setup({
	enable = true,
	enable_autocmd = false,
})
vim.g.skip_ts_context_commentstring_module = true

treesitter.setup({
	-- One of "all", "maintained" (parsers with maintainers), or a list of languages
	-- ensure_installed = "maintained",
	ensure_installed = "all",

	-- Install languages synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	-- List of parsers to ignore installing
	ignore_install = { "" },

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- list of language that will be disabled
		disable = { "" },

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},

	rainbow = {
		enable = true,
	},

	indent = { enable = true, disable = { "yaml" } },
})
