require("usr.dap.settings.dapcpp")
require("usr.dap.settings.bashdap")
require("usr.dap.settings.daplua")
require("usr.dap.settings.dappy")

local dap = require("dap")

local opts = { silent = true, }
local keymap = vim.keymap.set

-- require('dap')
vim.fn.sign_define('DapBreakpoint', {text='', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='󰋇',  texthl='', linehl='', numhl=''})

keymap("n", "<leader>dc", dap.continue, opts)
keymap("n", "<F8>", dap.step_over, opts)
keymap("n", "<F9>", dap.step_into, opts)
keymap("n", "<S-F9>", dap.step_out, opts)
keymap("n", "<leader>de", dap.close, opts)
keymap("n", "<leader>br", dap.toggle_breakpoint, opts)
keymap("n", "<leader>tb", require'dapui'.toggle, opts)
keymap("n", "<leader>cb", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, opts)
keymap("n", "<leader>lb", function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, opts)

