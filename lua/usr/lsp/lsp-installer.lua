local M = {
}

local ok, mason = pcall(require, "mason-lspconfig")
if not ok then
	vim.notify("mason-lspconfig not found!", vim.log.levels.ERROR)
	return
end

local handlers = require("usr.lsp.handlers")

function M.setup()
	local servers = mason.get_installed_servers()
	for _, name in pairs(servers) do
		local opts = {
			on_attach = handlers.on_attach,
			capabilities = handlers.capabilities,
		}

		local ok, setting = pcall(require, "usr.lsp.settings." .. name)
		if not ok then
			setting = vim.lsp.config[name] or {}
			if setting ==  {} then
				vim.notify("No settings found for " .. name, vim.log.levels.WARN)
			end
		end

		-- vim.print("Setting up LSP for " .. name)
		opts = vim.tbl_deep_extend("force", opts, setting)
		vim.lsp.config(name, opts)
	end

	vim.lsp.enable(servers)
end

return M
