local lualine = require("lualine")
local icons = require("usr.core.icons")

local function hide_in_width()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = {
		error = icons.diagnostics.Error,
		warn = icons.diagnostics.Warning,
		info = icons.diagnostics.Info,
		hint = icons.diagnostics.Hint
	},
	colored = true,
	update_in_insert = false,
	always_visible = true,
}

local function add_space(icon)
	return " " .. icon
end

local diff = {
	"diff",
	colored = true,
	symbols = {
		added = add_space(icons.git.Add),
		modified = add_space(icons.git.Mod),
		removed = add_space(icons.git.Remove),
	}, -- changes diff symbols
	diff_color = { added = 'diffAdd', modified = 'diffChange', removed = 'diffDelete'},
	cond = hide_in_width,
}

local mode = {
	"mode",
	fmt = function(str)
		return " " .. str .. " "
	end,
}

local filetype = {
	"filetype",
	icons_enabled = true,
	icon = nil,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local location = {
	"location",
	padding = 0,
}

local filename = {
	"filename",
	file_status = true,
	path = 1,
	symbols = {
		readonly = icons.access.ReadOnly,
		unnamed = icons.kind.Unnamed,
		modified = icons.git.Mod,
	},
}

local fileformat = {
	"fileformat",
	symbols = {
		unix = icons.system.Linux,
		dos = icons.system.Windows,
		mac = icons.system.Apple,
	},
}

-- cool function for progress
local function progress()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = {
		icons.possition.Pos1,
		icons.possition.Pos2,
		icons.possition.Pos3,
		icons.possition.Pos4,
		icons.possition.Pos5,
		icons.possition.Pos6,
		icons.possition.Pos7,
		icons.possition.Pos8,
		icons.possition.Pos9,
	}
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

local function spaces()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "catppuccin",  --"catppuccin", -- "solarized_dark",
		component_separators = { left = "", right = "" },
		section_separators = { left = icons.ui.LeftSeparator, right = icons.ui.RightSeparator },
		disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { mode },
		lualine_b = { filename, branch, diff, diagnostics },
		lualine_c = {},
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = { spaces, "encoding", fileformat, filetype },
		lualine_y = { location, progress },
		lualine_z = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { filename },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
