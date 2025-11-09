return {
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 500,
			treesitter_highlighting = true,
			draw = function(opts)
				if not opts.item or not opts.item.documentation or not opts.item.documentation.value then
					vim.print("Leaving blink docs emtpy")
					return
				end

				local out = require("pretty_hover.parser").parse(opts.item.documentation.value)
				opts.item.documentation.value = out:string()
				opts.default_implementation(opts)
			end,
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

	signature = {
		enabled = true,
		window = {
			border = "rounded",
		},
	},

	keymap = {
		preset = 'default',

		["<Tab>"] = { "select_next", "fallback"},
		["<S-Tab>"] = { "select_prev", "fallback"},

		["<C-p>"] = { "snippet_forward", "fallback"},
		["<C-n>"] = { "snippet_backward", "fallback"},
		["<CR>"] = { "accept", "fallback" },
	},
	sources = {
		priority = {
			'lsp',
			'snippets',
			'path',
			'buffer',
		},
	},
}
