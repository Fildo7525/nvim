local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
	-- One of "all", "maintained" (parsers with maintainers), or a list of languages
	-- ensure_installed = "maintained",
	ensure_installed = { "bash", "bibtex", "c", "c_sharp", "cmake", "comment", "cpp", "desktop", "diff", "dockerfile", "doxygen", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "javascript", "json", "lua", "luadoc", "markdown", "markdown_inline", "python", "ssh_config", "vim", "vimdoc", "yaml", "thrift", "toml", "yaml"},

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

			return false
		end,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},

	indent = { enable = true, disable = { "yaml" } },
})
