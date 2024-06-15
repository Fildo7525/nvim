local options = {
	autoread = true,
	conceallevel = 0, -- can create error on lazy installing plugins
	cursorline = true,
	expandtab = false,
	fileencoding = "utf-8",
	hlsearch = true,
	linebreak = true,
	list = true,
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
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.opt.shortmess:append "c"

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd "set listchars=tab:-->,trail:~,space:·"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]]
vim.cmd [[set statusline+=%-{get(b:,'gitsigns_status','')}]]
vim.cmd [[set clipboard+=unnamedplus]]
-- vim.cmd [[set spell spelllang=en_us]]

