local colorscheme = "catppuccin"
local scheme = require(colorscheme)

scheme.setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	background = { -- :h background
		light = "latte",
		dark = "mocha",
	},
	transparent_background = false,
	term_colors = true,
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percentage = 0.15,
	},
	no_italic = false, -- Force no italic
	no_bold = false, -- Force no bold
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		loops = {},
		functions = { "bold" },
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	color_overrides = {},
	custom_highlights = {},
	highlight_overrides = {
		mocha = {
			Comment = { fg = "#ADADAD" },
		},
	},
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		telescope = true,
		treesitter = true,
		integration = {
			dap = {
				enabled = true,
				enable_ui = true, -- enable nvim-dap-ui
			},
		}
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	},
})
return colorscheme

