local dap = require('dap')

dap.adapters.cppdbg = {
	id = 'cppdbg',
	type = 'executable',
	-- Must be from vscode cannot be cloned DUNNO why
	command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
}

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "cppdbg",
		request = "launch",
		program = function()
			local cwd = vim.fn['getcwd']()
			local bin = vim.api.nvim_call_function('fnamemodify', {cwd, ":t"})

			vim.notify(vim.fn.getcwd() .. '/build/' .. bin)
			return vim.fn.getcwd() .. '/build/' .. bin

			--[[ return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/', 'file') ]]
		end,
		cwd = '${workspaceFolder}/build',
		stopOnEntry = true,
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
