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

colorscheme = "catppuccin"

local status_ok_cat, scheme = pcall(require, "catppuccin")
if not status_ok_cat then
	vim.notify("catppuccin could not be loaded")
	return
end

scheme.setup({
	transparent_background = false,
	term_colors = true,
	styles = {
		comments = "italic",
		conditionals = "italic",
		loops = "NONE",
		functions = "NONE",
		keywords = "NONE",
		strings = "NONE",
		variables = "NONE",
		numbers = "NONE",
		booleans = "NONE",
		properties = "NONE",
		types = "NONE",
		operators = "NONE",
	},
	integrations = {
		treesitter = true,
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = "italic",
				hints = "italic",
				warnings = "italic",
				information = "italic",
			},
			underlines = {
				errors = "underline",
				hints = "underline",
				warnings = "underline",
				information = "underline",
			},
		},
		lsp_trouble = false,
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
	}
})

vim.g.catppuccin_flavour = "mocha"
-- vim.cmd[[colorscheme catppuccin]]

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end

