require("usr.DAP.settings.dapcpp")
require("usr.DAP.settings.bashdap")
require("usr.DAP.settings.daplua")

local opts = { silent = true, }
local keymap = vim.api.nvim_set_keymap

-- require('dap')
vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='󰋇',  texthl='', linehl='', numhl=''})

keymap("n", "<leader>dc", ":lua require'dap'.continue()<CR>", opts)
keymap("n", "<F8>", ":lua require'dap'.step_over()<CR>", opts)
keymap("n", "<F9>", ":lua require'dap'.step_into()<CR>", opts)
keymap("n", "<S-F9>", ":lua require'dap'.step_out()<CR>", opts)
keymap("n", "<leader>de", ":lua require'dap'.close()<CR>", opts)
keymap("n", "<leader>br", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<leader>tb", ":lua require'dapui'.toggle()<CR>", opts)
keymap("n", "<leader>cb", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
keymap("n", "<leader>lb", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)

