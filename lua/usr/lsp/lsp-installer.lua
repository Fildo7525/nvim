local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	vim.notify("nvim-lsp-installer error")
	return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("usr.lsp.handlers").on_attach,
		capabilities = require("usr.lsp.handlers").capabilities,
	}

	if server.name == "jsonls" then
		local jsonls_opts = require("usr.lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end

	if server.name == "sumneko_lua" then
		local sumneko_opts = require("usr.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server.name == "pyright" then
		local pyright_opts = require("usr.lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end

	if server.name == "ccls" then
		 local ccls_opts = require("usr.lsp.settings.ccls")
		 opts = vim.tbl_deep_extend("force", ccls_opts, opts)
	end

	if server.name == "jdtls" then
		local jdtls_opts = require("usr.lsp.settings.jdtls")
		return jdtls_opts
	end

	if server.name == "clangd" then
		local clang_opts = require("usr.lsp.settings.clangd")
		opts = vim.tbl_deep_extend("force", clang_opts, opts)
	end

	if server.name == "cmake" then
		local cmake_opts = require("usr.lsp.settings.cmake")
		opts = vim.tbl_deep_extend("force", cmake_opts, opts)
	end

	if server.name == "lemminx" then
		local xml_opts = require("usr.lsp.settings.lemminx")
		opts = vim.tbl_deep_extend("force", xml_opts, opts)
	end

	if server.name == "vimls" then
		opts = opts
	end
	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)

