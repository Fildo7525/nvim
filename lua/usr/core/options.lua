local options = {
	autoread = true,
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
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- APPEND OPTIONS
vim.opt.clipboard:append("unnamedplus")
vim.opt.iskeyword:append("-")
vim.opt.shortmess:append("c")
vim.opt.statusline:append("%-{get(b:,'gitsigns_status','')}")
vim.opt.whichwrap:append("<,>,[,],h,l")

-- REMOVE OPTIONS
vim.opt.formatoptions:append("cn")
vim.opt.formatoptions:remove("ro")

