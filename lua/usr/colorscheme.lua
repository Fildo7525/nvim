-- local colorscheme = "tokyonight"

-- local tokyo_settings = {
-- 	tokyonight_style = "night",
-- 	tokyonight_terminal_colors = true,
-- 	tokyonight_italic_comments = true,
-- 	tokyonight_italic_keywords = true,
-- 	tokyonight_italic_functions = true,
-- 	tokyonight_italic_variables = false,
-- 	tokyonight_transparent = false,
-- 	tokyonight_hide_inactive_statusline = false,
-- 	tokyonight_sidebars = {"qf", "vista_kind", "terminal", "packer"},
-- 	tokyonight_transparent_sidebar = false,
-- 	tokyonight_dark_sidebar = true,
-- 	tokyonight_dark_float = false,
-- 	tokyonight_colors = {},
-- 	tokyonight_day_brightness = 0.3,
-- 	tokyonight_lualine_bold = false,
-- }
--
-- for k, v in pairs(tokyo_settings) do
-- 	vim.g[k] = v
-- end

local colorscheme = "catppuccin"

local status_ok_cat, scheme = pcall(require, "catppuccin")
if not status_ok_cat then
	vim.notify("catppuccin could not be loaded")
	return
end

scheme.setup({
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percentage = 0.15,
	},
	transparent_background = false,
	term_colors = true,
	compile = {
		enabled = false,
		path = vim.fn.stdpath "cache" .. "/catppuccin",
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
		treesitter = true,
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
				hints = { "underdot" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
		coc_nvim = false,
		lsp_trouble = true,
		cmp = true,
		lsp_saga = false,
		gitgutter = false,
		gitsigns = true,
		telescope = true,
		nvimtree = {
			enabled = true,
			show_root = true,
			transparent_panel = false,
		},
		neotree = {
			enabled = false,
			show_root = false,
			transparent_panel = false,
		},
		dap = {
			enabled = false,
			enable_ui = false,
		},
		which_key = false,
		indent_blankline = {
			enabled = true,
			colored_indent_levels = false,
		},
		dashboard = true,
		neogit = false,
		vim_sneak = false,
		fern = false,
		barbar = false,
		bufferline = true,
		markdown = true,
		lightspeed = false,
		ts_rainbow = false,
		hop = false,
		notify = true,
		telekasten = true,
		symbols_outline = true,
		mini = false,
		aerial = false,
		vimwiki = true,
		beacon = true,
	},
	color_overrides = {},
	highlight_overrides = {},
})

vim.g.catppuccin_flavour = "mocha"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end

