local toggleterm = require("toggleterm")

toggleterm.setup({
	size = 20,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

function _G.set_terminal_keymaps()
	local opts = {noremap = true}
	vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
local node = Terminal:new({ cmd = "node", hidden = true })
local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })
local htop = Terminal:new({ cmd = "htop", hidden = true })
local python = Terminal:new({ cmd = "python", hidden = true })
local r = Terminal:new({ cmd = "R", hidden = true })

local function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

local function _NODE_TOGGLE()
	node:toggle()
end

local function _NCDU_TOGGLE()
	ncdu:toggle()
end

local function _HTOP_TOGGLE()
	htop:toggle()
end

local function _PYTHON_TOGGLE()
	python:toggle()
end

local function _R_TOGGLE()
	r:toggle()
end

return {
	lazygit = _LAZYGIT_TOGGLE,
	node = _NODE_TOGGLE,
	ncdu = _NCDU_TOGGLE,
	htop = _HTOP_TOGGLE,
	python = _PYTHON_TOGGLE,
	r = _R_TOGGLE,
}
