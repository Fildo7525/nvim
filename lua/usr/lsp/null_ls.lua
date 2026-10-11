local null_ls = require("null-ls")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/completion
local completion = null_ls.builtins.completion

null_ls.setup({
	debug = false,
	sources = {
		-- LUA
		formatting.stylua,

		-- C / C++ / Obj. C
		formatting.clang_format.with({
			extra_args = {
				"--sort-includes",
			},
		}),
		diagnostics.cppcheck.with({
			extra_args = {
				"--language=c++",
			},
		}),

		-- CMAKE
		formatting.cmake_format.with({
			extra_args = {
				"--tab-size 4",
				"--use-tabchars true",
				"--enable-sort true",
			},
		}),

		-- SPELL
		completion.spell,

		-- Python
		-- diagnostics.mypy,

		-- MARKDOWN

		-- SNIPPETS
		-- completion.luasnip,
	},
})
