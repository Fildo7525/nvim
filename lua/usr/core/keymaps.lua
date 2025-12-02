local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

local keymap = vim.keymap.set

-- MODES
--			normal - n
--			insert - i
--			visual - v
--			visual_block - x
--			terminal - t
--			command - c

--	NORMAL	--

-- Reload init.lua
vim.keymap.set("n", "<leader><cr>", function ()
	for name,_ in pairs(package.loaded) do
		if name:match('^usr') then
			package.loaded[name] = nil
		end
	end

	dofile(vim.env.MYVIMRC)
	vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end)

local function run_searchable_command()
	vim.ui.input({prompt = "Command: "}, function(input)
		if input then
			local cmd = "enew|pu=execute('" .. input .. "')"
			vim.print(cmd)
			vim.cmd(cmd)
		end
	end)
end

-- init.lua edditink
keymap("n", "<leader>sc", ":e ~/.config/nvim/init.lua<CR>", opts)
keymap("n", "<leader>m", ":new<CR>:put =execute('messages')<CR>", opts)
keymap("n", "<leader>mc", run_searchable_command, opts)

-- buildProject CUSTOMS --
keymap("n", "<F2>", ":term cmake -S . -B ./build && mv ./build/compile_commands.json .<CR>", opts)
keymap("n", "<leader>s", ":set spell!<CR>", term_opts)
keymap("n", "<F5>", ":term ./compile<CR>", term_opts)
keymap("n", "<F6>", ":term ./run<CR>", term_opts)
keymap("n", "<C-F8>", ":split <bar> term ./build.sh<CR>", term_opts)

keymap("n", "<leader>vs", ":split<CR>", opts)
keymap("n", "<leader>hs", ":vsplit<CR>", opts)

-- open new file
keymap("n", "gf", ":e <cfile><CR>", opts)

-- substitute spaces for tabs
keymap("n", "<leader>4s", ":%s/    /<TAB>/g<CR>:set shiftwidth=4<CR>:set tabstop=4<CR>:set noexpandtab<CR>/asdfsaf<CR>/<CR>", opts)
keymap("n", "<leader>2s", ":%s/  /<TAB>/g<CR>:set shiftwidth=4<CR>:set tabstop=4<CR>:set noexpandtab<CR>/asdfsaf<CR>/<CR>", opts)

keymap("n", "<leader>lg", require("usr.toggleterm").lazygit, opts)
keymap({"n", "t"}, "<C-p>", require("usr.toggleterm").python, opts)
keymap({"n", "t"}, "<C-M-h>", require("usr.toggleterm").htop, opts)

-- TELESCOPE --
keymap("n", "<leader>fb", require("telescope.builtin").buffers, opts)
keymap("n", "<leader>fc", require("telescope.builtin").current_buffer_fuzzy_find, opts)
keymap("n", "<leader>fd", require("telescope.builtin").diagnostics, opts)
keymap("n", "<leader>ff", require("telescope.builtin").find_files, opts)
keymap("n", "<leader>fg", require("telescope.builtin").live_grep, opts)
keymap("n", "<leader>fh", require("telescope.builtin").help_tags, opts)
keymap("n", "<leader>fr", require("telescope.builtin").lsp_references, opts)
keymap("n", "<leader>fs", require("telescope.builtin").grep_string, opts)
keymap("n", "<leader>of", require("telescope.builtin").oldfiles, opts)
keymap("n", "<leader>re", require("telescope.builtin").resume, opts)
keymap("n", "<leader>pr", require("telescope").extensions.projects.projects, opts)

-- telescope git commands
keymap("n", "<leader>gb", require("telescope.builtin").git_branches, opts)
keymap("n", "<leader>gc", require("telescope.builtin").git_commits, opts)
keymap("n", "<leader>gs", require("telescope.builtin").git_status, opts)

-- SAVING --
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>wq", ":wq<CR>", opts)
keymap("n", "<leader>qq", ":q<CR>", opts)
keymap("n", "<leader>bw", ":w <bar> :Bdelete! %d <CR>", opts) -- buffer writing
keymap("n", "<leader>bd", ":bd<CR>", opts) -- buffer delete force
keymap("n", "<leader>bD", ":Bdelete!<CR>", opts) -- buffer delete force
keymap("n", "<leader>lf", require('revolver').OpenSavedFiles, opts)

-- Resize with arrows
keymap("n", "<M-UP>", ":resize -2<CR>", opts)
keymap("n", "<M-DOWN>", ":resize +2<CR>", opts)
keymap("n", "<M-LEFT>", ":vertical resize -2<CR>", opts)
keymap("n", "<M-RIGHT>", ":vertical resize +2<CR>", opts)

--	NAVIGATE WINDOWS	--
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<leader>db", require('dropbar.api').pick, opts)

-- MARKDOWN PREVIEW
keymap("n", "mpn", ":MarkdownPreview<CR>", opts)
keymap("n", "mpf", ":MarkdownPreviewStop<CR>", opts)

-- NAVIGATE BUFFERS --
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<C-[>", ":BufferLineMovePrev<CR>", opts)
keymap("n", "<C-]>", ":BufferLineMoveNext<CR>", opts)

-- MOVE TEXT UP & DOWN
keymap("n", "<C-S-j>", ":move '<-2<CR>", opts)
keymap("n", "<C-S-k>", ":move '>+1<CR>", opts)

-- NEOGEN
keymap("n", "<leader>nc", function () require('neogen').generate({ type = 'class'}) end, opts)
keymap("n", "<leader>nf", function () require('neogen').generate({ type = 'func'}) end, opts)
keymap("n", "<leader>nt", function () require('neogen').generate({ type = 'type'}) end, opts)
keymap("n", "<leader>ni", function () require('neogen').generate({ type = 'file'}) end, opts)

keymap("n", "<leader>tr", "<cmd>Trouble<cr>", opts)
keymap("n", "<leader>twd", "<cmd>Trouble workspace_diagnostics<cr>", opts)
keymap("n", "<leader>tdd", "<cmd>Trouble document_diagnostics<cr>", opts)
keymap("n", "<leader>tl", "<cmd>Trouble loclist<cr>", opts)
keymap("n", "<leader>tq", "<cmd>Trouble quickfix<cr>", opts)
keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", opts)

-- fold methods
keymap("n", "<leader>fm", "v%zf", opts)

-- Press jk fast to enter
keymap("i", "jj", "<ESC>:w<CR>", opts)
keymap("i", "jk", "<ESC>", opts)

-- Visual --
local visual_opts = {noremap = true, silent = true, expr = false}
keymap("v", "<leader>y", '"+y', visual_opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Visual Block --
keymap("v", "p", '"_dP', opts)
keymap("v", "P", '"_dp', opts)

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- NeoTree
keymap("n", "<leader>e", ":Neotree position=left filesystem reveal toggle<cr>", opts)
-- keymap("n", "<leader>e", ":Lex 15<CR>", opts)

keymap({"n", "v"}, "<leader>co", ":CopilotChat<CR>", opts)
keymap("n", "<leader>cp", ":CccPick<CR>", opts)

vim.cmd[[
	augroup twig_ft
		au!
		autocmd BufNewFile,BufRead *.bbappend   set syntax=bitbake
		autocmd BufNewFile,BufRead *.bb   set syntax=bitbake
	augroup END
]]

keymap("n", "<ESC>", "", opts)
