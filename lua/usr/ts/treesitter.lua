local treesitter = require("nvim-treesitter.configs")

require("ts_context_commentstring").setup {}
--[[ vim.g.skip_ts_context_commentstring_module = true ]]

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
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end

			if vim.bo.filetype == "tex" then
				return true
			end

			return false
		end,

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
