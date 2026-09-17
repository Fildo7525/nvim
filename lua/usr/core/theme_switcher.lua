
local M = {}

-- Map your theme names → catppuccin flavors
M.map = { light = 'catppuccin-latte', dark = 'catppuccin-mocha' }

function M.apply(name)

	local flavor = ""
	if not string.find(name, "catppuccin-") then
		flavor = M.map[name]

		if not flavor then
			return
		end

	else
		flavor = name
	end

	vim.cmd('colorscheme ' .. flavor)

end

function M.read_state()
	-- local f = io.open(vim.fn.stdpath('cache') .. '/current-theme', 'r')
	-- if f then local t = f:read('*l'); f:close(); return t or 'dark' end
	return vim.cmd.colorscheme()
end

-- Auto-start an RPC server for THIS instance so it can be addressed
local server_file = vim.fn.stdpath('cache') .. '/nvim-' .. vim.fn.getpid()
vim.fn.serverstart(server_file)

local opts = { clear = true }
local filetype_id = vim.api.nvim_create_augroup("colorscheme-server-setting", opts)
vim.api.nvim_create_autocmd({ "ExitPre" }, {
	callback = function()
		vim.fn.serverstop(server_file)
	end,
	group = filetype_id,
})

return M
