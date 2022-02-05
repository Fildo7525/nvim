local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

keymap("", "<SPACE>", "<NOP>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- MODES
--			normal - n
--			insert - i
--			visual - v
--			visual_block - x
--			terminal - t
--			command - c

--	NORMAL	--
-- init.lua edditink
keymap("n", "<leader>es", ":e ~/.config/nvim/init.lua<CR>", opts)

-- buildProject CUSTOMS --
keymap("n", "<F5>", ":term ./compile.sh<CR>", term_opts)
keymap("n", "<F8>", ":term ./build.sh<CR>", term_opts)

-- open new file
keymap("n", "gf", ":e <cfile><CR>", opts)

-- GIT signs
keymap("n", "gp", ":Gitsigns preview_hunk<CR>", opts)
keymap("n", "gbl", ":Gitsigns blame_line<CR>", opts)
keymap("n", "<leader>lg", "<CMD>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- TELESCOPE --
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)

-- telescope git commands
keymap("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", opts)
keymap("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", opts)
keymap("n", "<leader>gs", "<cmd>Telescope git_status<CR>", opts)

-- SAVING --
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>qq", ":wq<CR>", opts)
keymap("n", "<leader>bw", ":bw<CR>", opts) -- buffer writing
keymap("n", "<leader>bd", ":bd!<CR>", opts) -- buffer delete force

-- Resize with arrows
keymap("n", "<C-K>", ":resize -2<CR>", opts)
keymap("n", "<C-J>", ":resize +2<CR>", opts)
keymap("n", "<C-L>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-H>", ":vertical resize +2<CR>", opts)

--	NAVIGATE WINDOWS	--
keymap("n", "<C-UP>", "<C-w>k", opts)
keymap("n", "<C-DOWN>", "<C-w>j", opts)
keymap("n", "<C-LEFT>", "<C-w>h", opts)
keymap("n", "<C-RIGHT>", "<C-w>l", opts)

-- keymap("n", "<leader>e", ":Lex 15<CR>", opts)

-- NAVIGATE BUFFERS --
keymap("n", "<A-LEFT>", ":bprevious<CR>", opts)
keymap("n", "<A-RIGHT>", ":bnext<CR>", opts)

-- MOVE TEXT UP & DOWN
keymap("n", "<A-S-DOWN>", "<ESC>:m .+1<CR>==gi", opts)
keymap("n", "<A-S-DOWN>", "<ESC>:m .-2<CR>==gi", opts)

-- Insert --

-- BRACES, PARANTHESES
keymap("i", "[", "[]<LEFT>", opts)
keymap("i", "{", "{}<LEFT>", opts)
keymap("i", "'", "''<LEFT>", opts)
keymap("i", "\"", "\"\"<LEFT>", opts)

-- Press jk fast to enter
keymap("i", "jj", "<ESC>:w<CR>", opts)

-- Visual --

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-DOWN>", ":m .+1<CR>==", opts)
keymap("v", "<A-UP>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-S-DOWN>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-S-UP>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --

-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Nvimtree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
