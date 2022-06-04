local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	vim.notify("lspconfig error")
	return
end

require("usr.lsp.lsp-installer")
require("usr.lsp.handlers").setup()
require("usr.lsp.signature")
require("usr.lsp.null_ls")

