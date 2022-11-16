local options = {
	fileencoding = "utf-8",
	hlsearch = true,
	mouse = "a",
	mousemodel="extend",
	termguicolors = true,
	splitright = true,
	splitbelow = true,
	shiftwidth = 4,
	tabstop = 4,
	expandtab = false,
	number = true,
	relativenumber = false,
	smartindent = true,
	conceallevel = 0,
	list = true,
	cursorline = true,
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

