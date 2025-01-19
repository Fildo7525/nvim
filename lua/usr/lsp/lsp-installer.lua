local lspconfig = require("lspconfig")

local M = {}

local function setup_lua_settings()
	local servers = require("mason-lspconfig").get_installed_servers()
	for _, name in pairs(servers) do
		local opts = {
			on_attach = require("usr.lsp.handlers").on_attach,
			capabilities = require("usr.lsp.handlers").capabilities,
		}

		local ok, setting = pcall(require, "usr.lsp.settings." .. name)
		if not ok then
			local conf_ok, tmp_setting = pcall(require, "lspconfig.configs." .. name)
			if conf_ok then
				setting = tmp_setting.default_config
			else
				vim.notify("No settings found for " .. name, vim.log.levels.WARN)
				setting = {}
			end

		end

		opts = vim.tbl_deep_extend("force", opts, setting)
		lspconfig[name].setup(opts)
	end
end

function M.setup()
	setup_lua_settings()
end

return M
