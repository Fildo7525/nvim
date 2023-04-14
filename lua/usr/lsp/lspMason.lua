-- mason.lua
--
-- Configuration for mason plugin, which is a improved replacement for
-- Lsp-installer.

require("mason").setup()

local servers = {
	"jsonls",
	"lua_ls",
	"pyright",
	"cmake",
	"lemminx",
	"texlab",
	"vimls",
	"yamlls",
	"clangd",
	"marksman",
	"tsserver",
}

require("mason-lspconfig").setup({
	ensure_installed = servers,
})

