local append = "a"
local remove = "r"
local prepend = "p"

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
	iskeyword = {append, "-"},
	shortmess = {append, "c"},
	statusline = {append, "%-{get(b:,'gitsigns_status','')}"},
	whichwrap = {append, "<,>,[,],h,l"},
	formatoptions = {append, "cn", remove, "ro"},
}

for k, v in pairs(options) do
	if type(v) ~= "table" then
		vim.opt[k] = v
		goto continue
	end

	if #v % 2 == 1 then
		vim.notify("Table must have an even number of elements. Option " .. k, vim.log.levels.ERROR)
		goto continue
	end

	for i=1, #v/2 do
		if v[i*2-1] == append then
			vim.opt[k]:append(v[i*2])

		elseif v[i*2-1] == remove then
			vim.opt[k]:remove(v[i*2])

		elseif v[i*2-1] == prepend then
			vim.opt[k]:prepend(v[i*2])

		else
			error("Invalid option")

		end
	end

	::continue::
end

