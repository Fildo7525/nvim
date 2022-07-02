local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

function QtQuerryFinder()
	address = "https://doc.qt.io/qt-5/" .. vim.fn.expand("<cword>"):lower() .. ".html"
	vim.cmd(":!xdg-open " .. address)
end

keymap("n", "<leader>sh", ":ClangdSwitchSourceHeader<CR>", opts)
keymap("n", "<F2>", ":lua QtQuerryFinder()<CR>", opts)
