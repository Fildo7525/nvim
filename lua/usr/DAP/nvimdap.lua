require("usr.DAP.dapcpp")
require("usr.DAP.dapjava")

-- require('dap')
vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='',  texthl='', linehl='', numhl=''})
local opts = { silent = true, }
local keymap = vim.api.nvim_set_keymap
keymap('n', '<leader>dd', ':lua require\'dap\'.continue()<CR>', opts)
keymap('n', '<leader>dn', ':lua require\'dap\'.step_over()<CR>', opts)
keymap('n', '<leader>di', ':lua require\'dap\'.step_into()<CR>', opts)
keymap('n', '<leader>do', ':lua require\'dap\'.step_out()<CR>', opts)
keymap('n', '<leader>b', ':lua require\'dap\'.toggle_breakpoint()<CR>', opts)
keymap('n', '<leader>dt', ':lua require\'dapui\'.toggle()<CR>', opts)
keymap('n', '<leader>cb', ':lua require\'dap\'.set_breakpoint(vim.fn.input(\'Breakpoint condition: \'))<CR>', opts)
keymap('n', '<leader>lp', ':lua require\'dap\'.set_breakpoint(nil, nil, vim.fn.input(\'Log point message: \'))<CR>', opts)
keymap('n', '<leader>dr', ':lua require\'dap\'.repl.open()<CR>', opts)
keymap('n', '<leader>dl', ':lua require\'dap\'.run_last()<CR>', opts)
keymap('n', '<leader>dw', ':lua require\'dap.ui.widgets\'.hover(function () return vim.fn.expand("<cexpr>"))<CR>', opts)
keymap('n', '<leader>dw', ':lua require\'dap.ui.widgets\'.visual_hover()<CR>', opts)
showScopes = function ()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end
keymap('n', '<leader>d?', ':lua showScopes()<CR>', opts)
keymap('n', '<leader>dk', ':lua require\'dap\'.up()<CR>', opts)
keymap('n', '<leader>dj', ':lua require\'dap\'.down()<CR>', opts)

