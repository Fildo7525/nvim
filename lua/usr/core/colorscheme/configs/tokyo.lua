local colorscheme = "tokyonight"

local tokyo_settings = {
	tokyonight_style = "night",
	tokyonight_terminal_colors = true,
	tokyonight_italic_comments = true,
	tokyonight_italic_keywords = true,
	tokyonight_italic_functions = true,
	tokyonight_italic_variables = false,
	tokyonight_transparent = false,
	tokyonight_hide_inactive_statusline = false,
	tokyonight_sidebars = {"qf", "vista_kind", "terminal", "packer"},
	tokyonight_transparent_sidebar = false,
	tokyonight_dark_sidebar = true,
	tokyonight_dark_float = false,
	tokyonight_colors = {},
	tokyonight_day_brightness = 0.3,
	tokyonight_lualine_bold = false,
}

for k, v in pairs(tokyo_settings) do
	vim.g[k] = v
end

return colorscheme

