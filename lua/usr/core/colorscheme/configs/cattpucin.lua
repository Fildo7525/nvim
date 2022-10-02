local colorscheme = "catppuccin"
local colors = require("catppuccin.palettes").get_palette()

local status_ok_cat, scheme = pcall(require, colorscheme)
if not status_ok_cat then
	vim.notify("catppuccin could not be loaded")
	return
end

scheme.setup({
	transparent_background = false,
	term_colors = false,
	compile = {
		enabled = false,
		path = vim.fn.stdpath("cache") .. "/catppuccin",
	},
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percentage = 0.15,
	},
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
	integrations = {
		aerial = false,
		barbar = false,
		beacon = false,
		cmp = true,
		coc_nvim = false,
		dashboard = true,
		fern = false,
		fidget = false,
		gitgutter = false,
		gitsigns = true,
		hop = false,
		illuminate = false,
		leap = false,
		lightspeed = false,
		lsp_saga = false,
		lsp_trouble = false,
		markdown = true,
		mini = false,
		neogit = false,
		neotest = false,
		neotree = false,
		notify = true,
		nvimtree = true,
		overseer = false,
		pounce = false,
		symbols_outline = false,
		telekasten = false,
		telescope = true,
		treesitter = true,
		treesitter_context = true,
		ts_rainbow = false,
		vim_sneak = false,
		vimwiki = false,
		which_key = false,

		-- Special integrations, see https://github.com/catppuccin/nvim#special-integrations
		dap = {
			enabled = false,
			enable_ui = false,
		},
		indent_blankline = {
			enabled = true,
			colored_indent_levels = false,
		},
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
		navic = {
			enabled = false,
			custom_bg = "NONE",
		},
	},
	color_overrides = {},
	highlight_overrides = {
		mocha = {
			Comment = { fg = "#ADADAD" },
		},
	},
})

vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato 

return colorscheme

