local clients = vim.lsp.get_clients({name = "lua_ls"})

for _, client in pairs(clients) do
	local contains_filetypes = vim.tbl_contains(client.config.filetypes or {}, "lua")
	local root_dir = client.config.root_dir or "nil"
	vim.print("Lua LS root_dir: " .. root_dir)
	if contains_filetypes then
		vim.print("Lua LS is attached to buffer " .. vim.api.nvim_get_current_buf())
	else
		vim.print("Lua LS is NOT attached to buffer " .. vim.api.nvim_get_current_buf())
	end
end
