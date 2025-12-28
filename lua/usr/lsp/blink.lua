return {
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 500,
			treesitter_highlighting = true,
			draw = function(opts)
				if opts.item and opts.item.documentation and opts.item.documentation.value then
					local out = require("pretty_hover.parser").parse(opts.item.documentation.value)
					opts.item.documentation.value = out:string()
				end

				opts.default_implementation(opts)
			end,
			window = {
				border = "rounded",
			},
		},
		list = {
			selection = {
				preselect = true,
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
