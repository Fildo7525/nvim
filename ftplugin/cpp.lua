local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>sh", ":ClangdSwitchSourceHeader<CR>", opts)
keymap("n", "mu", ":ClangdMemoryUsage<CR>", opts)
keymap("n", "<leader>si", ":ClangdSymbolInfo<CR>", opts)
keymap("v", "cat", ":ClangdAST<CR>", opts)
