local status, dap = pcall(require, 'dap')
if not status then
	vim.notify("Dap is not installed")
	return
end

dap.adapters.cppdbg = {
	id = 'cppdbg',
	type = 'executable',
	command = '/home/fildo7525/.vscode-server/extensions/ms-vscode.cpptools-1.9.0/debugAdapters/bin/OpenDebugAD7',
}

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "cppdbg",
		request = "launch",
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = true,
		setupCommands = {
			{
				text = '-enable-pretty-printing',
				description =  'enable pretty printing',
				ignoreFailures = false,
			},
		},
	},
	{
		name = 'Attach to gdbserver :1234',
		type = 'cppdbg',
		request = 'launch',
		MIMode = 'gdb',
		miDebuggerServerAddress = 'localhost:1234',
		miDebuggerPath = '/usr/bin/gdb',
		cwd = '${workspaceFolder}',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		setupCommands = {
			{
				text = '-enable-pretty-printing',
				description =  'enable pretty printing',
				ignoreFailures = false,
			},
		},
	},
}



-- If you want to use this for rust and c, add something like this:

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- require('dap')
vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='',  texthl='', linehl='', numhl=''})
local opts = { silent = true, }
local keymap = vim.api.nvim_set_keymap
keymap('n', '<F5>', ':lua require\'dap\'.continue()<CR>', opts)
keymap('n', '<F10>', ':lua require\'dap\'.step_over()<CR>', opts)
keymap('n', '<F11>', ':lua require\'dap\'.step_into()<CR>', opts)
keymap('n', '<F12>', ':lua require\'dap\'.step_out()<CR>', opts)
keymap('n', '<leader>b', ':lua require\'dap\'.toggle_breakpoint()<CR>', opts)
keymap('n', '<leader>dt', ':lua require\'dapui\'.toggle()<CR>', opts)
keymap('n', '<leader>cb', ':lua require\'dap\'.set_breakpoint(vim.fn.input(\'Breakpoint condition: \'))<CR>', opts)
keymap('n', '<leader>lp', ':lua require\'dap\'.set_breakpoint(nil, nil, vim.fn.input(\'Log point message: \'))<CR>', opts)
keymap('n', '<leader>dr', ':lua require\'dap\'.repl.open()<CR>', opts)
keymap('n', '<leader>dl', ':lua require\'dap\'.run_last()<CR>', opts)
keymap('n', '<leader>di', ':lua require\'dap.ui.widgets\'.hower(function () return vim.fn.expand("<cexpr>"))<CR>', opts)
keymap('n', '<leader>di', ':lua require\'dap.ui.widgets\'.visual_hower()<CR>', opts)
local showScopes = function ()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end
keymap('n', '<leader>d?', ':lua showScopes()<CR>', opts)
keymap('n', '<leader>dk', ':lua require\'dap\'.up()<CR>', opts)
keymap('n', '<leader>dj', ':lua require\'dap\'.down()<CR>', opts)

