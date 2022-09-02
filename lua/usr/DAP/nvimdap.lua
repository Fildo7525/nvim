require("usr.DAP.settings.dapcpp")

local opts = { silent = true, }
local keymap = vim.api.nvim_set_keymap

-- require('dap')
vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='',  texthl='', linehl='', numhl=''})

keymap("n", "<leader>dc", ":lua require'dap'.continue()<CR>", opts)
keymap("n", "<F10>", ":lua require'dap'.step_over()<CR>", opts)
keymap("n", "<F11>", ":lua require'dap'.step_into()<CR>", opts)
keymap("n", "<S-F11>", ":lua require'dap'.step_out()<CR>", opts)
keymap("n", "<leader>br", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<leader>tb", ":lua require'dapui'.toggle()<CR>", opts)
keymap("n", "<leader>cb", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
keymap("n", "<leader>lb", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)

