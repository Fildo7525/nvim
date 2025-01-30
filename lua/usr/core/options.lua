local util = require("usr.core.util")

local options = {
	autoread = true,
	clipboard = "unnamedplus",
	conceallevel = 0, -- can create error on lazy installing plugins
	cursorline = true,
	expandtab = false,
	fileencoding = "utf-8",
	hlsearch = true,
	linebreak = true,
	list = true,
	listchars = "tab:-->,trail:~,space:·",
	mouse = "a",
	mousemodel = "extend",
	number = true,
	relativenumber = false,
	shiftwidth = 4,
	smartindent = true,
	splitbelow = true,
	splitright = true,
	tabstop = 4,
	termguicolors = true,
	textwidth = 125,
	iskeyword = {util.opt.append, "-"},
	shortmess = {util.opt.append, "c"},
	statusline = {util.opt.append, "%-{get(b:,'gitsigns_status','')}"},
	whichwrap = {util.opt.append, "<,>,[,],h,l"},
	formatoptions = {util.opt.append, "cn", util.opt.remove, "ro"},
}

util.register_options(options)
