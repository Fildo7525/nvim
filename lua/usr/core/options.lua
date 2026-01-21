local util = require("usr.core.util")

local options = {
	autoread = true,
	clipboard = "unnamedplus",
	conceallevel = 0, -- can create error on lazy installing plugins
	cursorline = true,
	expandtab = false,
	fileencoding = "utf-8",
	fillchars  = { util.opt.append, {fold = " "} },
	foldcolumn = "0",
	foldenable = true,
	foldexpr = 'v:lua.vim.lsp.foldexpr()',
	foldlevel = 99,
	foldtext = "",
	formatoptions = {util.opt.append, "cn", util.opt.remove, "ro"},
	hlsearch = true,
	iskeyword = {util.opt.append, "-"},
	linebreak = true,
	list = true,
	listchars = "tab:-->,trail:~,space:·",
	mouse = "a",
	mousemodel = "popup_setpos",
	number = true,
	relativenumber = false,
	shiftwidth = 4,
	shortmess = {util.opt.append, "c"},
	smartindent = true,
	splitbelow = true,
	splitright = true,
	statusline = {util.opt.append, "%-{get(b:,'gitsigns_status','')}"},
	tabstop = 4,
	termguicolors = true,
	textwidth = 125,
	whichwrap = {util.opt.append, "<,>,[,],h,l"},
	winborder = "rounded",
}

vim.g.clipboard = "osc52"

util.register_options(options)
