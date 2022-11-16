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

function ReloadConfig()
	for name,_ in pairs(package.loaded) do
		if name:match('^usr') then
			package.loaded[name] = nil
		end
	end

	dofile(vim.env.MYVIMRC)
	vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end

-- Reload init.lua
keymap("n", "<leader><cr>", ":lua ReloadConfig()<cr>", opts)

-- init.lua edditink
keymap("n", "<leader>sc", ":e ~/.config/nvim/init.lua<CR>", opts)

-- buildProject CUSTOMS --
keymap("n", "<F2>", ":term cmake -S . -B ./build && mv ./build/compile_commands.json .<CR>", opts)
keymap("n", "<F4>", ":set spell!<CR>", term_opts)
keymap("n", "<F5>", ":term ./compile.sh<CR>", term_opts)
keymap("n", "<F8>", ":term ./build.sh<CR>", term_opts)
keymap("n", "<C-F8>", ":split <bar> term ./build.sh<CR>", term_opts)

keymap("n", "<leader>vs", ":split<CR>", opts)
keymap("n", "<leader>hs", ":vsplit<CR>", opts)

-- open new file
keymap("n", "gf", ":e <cfile><CR>", opts)

-- substitute spaces for tabs
keymap("n", "<leader>4s", ":%s/    /<TAB>/g<CR>", opts)
keymap("n", "<leader>2s", ":%s/  /<TAB>/g<CR>", opts)

keymap("n", "<leader>lg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)
keymap("n", "<leader>py", "<cmd>lua _PYTHON_TOGGLE()<CR>", opts)
keymap("n", "<leader>ht", "<cmd>lua _HTOP_TOGGLE()<CR>", opts)
keymap("n", "<leader>nd", "<cmd>lua _NCDU_TOGGLE()<CR>", opts)

-- TELESCOPE --
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>re", "<cmd>Telescope resume<CR>", opts)
keymap("n", "<leader>of", "<cmd>Telescope oldfiles<CR>", opts)
--[[ keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts) ]]
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)
keymap("n", "<leader>pr", "<cmd>Telescope projects<CR>", opts)
keymap("n", "<leader>ss", "<cmd>lua require('usr.tscope.adjustments').source_search()<CR>", opts)
keymap("n", "<leader>ag", "<cmd>lua require('usr.tscope.adjustments').extend_live_grep()<CR>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>so", "<cmd>lua require('usr.tscope.adjustments').extend_live_grep(true)<CR>", opts)
keymap("n", "<leader>fs", "<cmd>lua require('usr.tscope.adjustments').extend_grep_string()<CR>", opts)

-- telescope git commands
keymap("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", opts)
keymap("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", opts)
keymap("n", "<leader>gs", "<cmd>Telescope git_status<CR>", opts)

-- GIT signs
keymap("n", "gpr", ":Gitsigns preview_hunk<CR>", opts)
keymap("n", "gbl", ":Gitsigns blame_line<CR>", opts)
keymap("n", "gsh", ":Gitsigns stage_hunk<CR>", opts)
keymap("n", "gsb", ":Gitsigns stage_buffer<CR>", opts)
keymap("n", "grh", ":Gitsigns reset_hunk<CR>", opts)
keymap("n", "grb", ":Gitsigns reset_buffer<CR>", opts)
keymap("n", "gtd", ":Gitsigns toggle_deleted<CR>", opts)
keymap("n", "gnh", ":Gitsigns next_hunk<CR>", opts)
keymap("n", "gph", ":Gitsigns prev_hunk<CR>", opts)
keymap("n", "guh", ":Gitsigns undo_stage_hunk<CR>", opts)

---@diagnostic disable-next-line: lowercase-global
function getCommitIndex()
	local commit = vim.fn.input("Enter commit: ", "HEAD~")
	require("gitsigns").diffthis(commit)
end
keymap("n", "<leader>gd", ":lua getCommitIndex()<CR>", opts)

-- SAVING --
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>wq", ":lua require('usr.core.buffReopener').SaveOpenedFiles()<CR> | :wq<CR>", opts)
keymap("n", "<leader>qq", ":q<CR>", opts)
keymap("n", "<leader>bw", ":w <bar> :Bdelete! %d <CR>", opts) -- buffer writing
keymap("n", "<leader>bd", ":bd<CR>", opts) -- buffer delete force
keymap("n", "<leader>lf", ":lua require('usr.core.buffReopener').OpenSavedFiles()<CR>", opts)

-- Resize with arrows
keymap("n", "<C-UP>", ":resize -2<CR>", opts)
keymap("n", "<C-DOWN>", ":resize +2<CR>", opts)
keymap("n", "<C-LEFT>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-RIGHT>", ":vertical resize +2<CR>", opts)

--	NAVIGATE WINDOWS	--
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- keymap("n", "<leader>e", ":Lex 15<CR>", opts)

-- MARKDOWN PREVIEW
keymap("n", "mpn", ":MarkdownPreview<CR>", opts)
keymap("n", "mpf", ":MarkdownPreviewStop<CR>", opts)

-- NAVIGATE BUFFERS --
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<leader>mh", ":BufferLineMovePrev<CR>", opts)
keymap("n", "<leader>ml", ":BufferLineMoveNext<CR>", opts)

-- MOVE TEXT UP & DOWN
-- keymap("n", "<A-S-k>", "<ESC>:m .+1<CR>==gi", opts)
-- keymap("n", "<A-S-j>", "<ESC>:m .-2<CR>==gi", opts)
keymap("n", "<C-S-j>", ":move '<-2<CR>", opts)
keymap("n", "<C-S-k>", ":move '>+1<CR>", opts)

-- NEOGEN
keymap("n", "<leader>nc", ":lua require('neogen').generate({ type = 'class'})<CR>", opts)
keymap("n", "<leader>nf", ":lua require('neogen').generate({ type = 'func'})<CR>", opts)
keymap("n", "<leader>nt", ":lua require('neogen').generate({ type = 'type'})<CR>", opts)
keymap("n", "<leader>ni", ":lua require('neogen').generate({ type = 'file'})<CR>", opts)

keymap("n", "<leader>tr", "<cmd>Trouble<cr>",opts)
keymap("n", "<leader>twd", "<cmd>Trouble workspace_diagnostics<cr>",opts)
keymap("n", "<leader>tdd", "<cmd>Trouble document_diagnostics<cr>",opts)
keymap("n", "<leader>tl", "<cmd>Trouble loclist<cr>",opts)
keymap("n", "<leader>tq", "<cmd>Trouble quickfix<cr>",opts)
keymap("n", "gR", "<cmd>Trouble lsp_references<cr>",opts)

-- fold methods
keymap("n", "<leader>fm", "v%zf",opts)


-- Press jk fast to enter
keymap("i", "jj", "<ESC>:w<CR>", opts)
keymap("i", "kk", "<ESC>", opts)

-- Visual --
local visual_opts = {noremap = true, silent = true, expr = false}
keymap("v", "<leader>y", '"+y', visual_opts)

-- REFACTORING --
keymap("v", "<leader>rr", "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", visual_opts)

-- -- Remaps for the refactoring operations currently offered by the plugin
-- keymap("v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], visual_opts)
-- keymap("v", "<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], visual_opts)
-- keymap("v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], visual_opts)
-- keymap("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], visual_opts)
--
-- -- Extract block doesn't need visual mode
-- keymap("n", "<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]], visual_opts)
-- keymap("n", "<leader>rbf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]], visual_opts)
--
-- -- Inline variable can also pick up the identifier currently under the cursor without visual mode
-- keymap("n", "<leader>ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], visual_opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
-- keymap("v", "<A-DOWN>", ":m .+1<CR>==", opts)
-- keymap("v", "<A-UP>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Nvimtree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
