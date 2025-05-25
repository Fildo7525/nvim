local M = {
	configs = {},
}

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

		-- vim.print("Setting up LSP for " .. name)
		opts = vim.tbl_deep_extend("force", opts, setting)
		vim.lsp.config(name, opts)
		M.configs[name] = opts
	end

	vim.lsp.enable(servers)
end

function M.setup()
	setup_lua_settings()

	-- Autocmd to start LSPs manually per buffer
	vim.api.nvim_create_autocmd("FileType", {
		callback = function(args)
			local ft = args.match

			for name, config in pairs(M.configs) do
				if vim.tbl_contains(config.filetypes or {}, ft) then
					local bufnr = args.buf
					-- Avoid double attaching
					local clients = vim.lsp.get_clients({ bufnr = bufnr })
					local already_attached, id = vim.iter(clients):any(function(c) return c.name == name, c.id end)

					if not already_attached then
						--[[ vim.print("Starting LSP for " .. name .. " on buffer " .. bufnr) ]]
						config.name = name
						config.buffers = { bufnr }
						vim.lsp.start(config)

					else
						--[[ vim.print("LSP for " .. name .. " already attached to buffer " .. bufnr) ]]
						vim.lsp.buf_attach_client(bufnr, id)
					end
				end
			end
		end
	})

end

return M
