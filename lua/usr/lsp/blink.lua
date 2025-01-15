--- @module 'blink.cmp'
--- @type blink.cmp.Config
return {
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 500,
			treesitter_highlighting = true,
			window = {
				border = "rounded",
			},
		},
		list = {
			selection = {
				preselect = false,
				auto_insert = true,
			},
		},
		menu = {
			draw = {
				treesitter = { 'lsp' },
			},
		},
	},

	keymap = {
		preset = 'default',

		["<Tab>"] = { "select_next", "fallback"},
		["<S-Tab>"] = { "select_prev", "fallback"},

		["<C-p>"] = { "snippet_forward", "fallback"},
		["<C-n>"] = { "snippet_backward", "fallback"},
		["<CR>"] = { "accept", "fallback" },
	}
}
