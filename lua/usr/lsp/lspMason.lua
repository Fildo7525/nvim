-- mason.lua
--
-- Configuration for mason plugin, which is a improved replacement for
-- Lsp-installer.

require("mason").setup()

local servers = {
	"jsonls",
	"sumneko_lua",
	"pyright",
	"cmake",
	"lemminx",
	"texlab",
	"vimls",
	"yamlls",
	"clangd",
	"marksman",
	"tsserver",
	"rust_analyzer",
	"jdtls",
}

require("mason-lspconfig").setup({
	ensure_installed = servers,
})

