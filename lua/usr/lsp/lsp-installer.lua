local lspconfig = require("lspconfig")
local settings = require("usr.lsp.settings")

local M = {}

local function setup_lua_settings()
	local servers = require("mason-lspconfig").get_installed_servers()
	for _, name in pairs(servers) do
		local opts = {
			on_attach = require("usr.lsp.handlers").on_attach,
			capabilities = require("usr.lsp.handlers").capabilities,
		}

		local setting = settings.lua[name]
		if not setting then
			setting = require("lspconfig.server_configurations." .. name)
		end

		opts = vim.tbl_deep_extend("force", opts, setting)
		lspconfig[name].setup(opts)
	end
end

local function setup_vim_settings()
	for name, _ in pairs(settings.vim) do
		vim.cmd("source " .. os.getenv("HOME") .. "/.config/nvim/lua/usr/lsp/settings/" .. name .. ".vim")
	end
end

function M.setup()
	setup_lua_settings()
	setup_vim_settings()
end

return M
