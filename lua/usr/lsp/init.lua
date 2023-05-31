require("usr.lsp.lspMason")
local _ = require("lspconfig")

require("usr.lsp.lsp-installer")
require("usr.lsp.handlers").setup()
require("usr.lsp.semantic")
require("usr.lsp.signature")
require("usr.lsp.null_ls")
require("usr.lsp.codelens")
vim.cmd("source " .. os.getenv("HOME") .. "/.config/nvim/lua/usr/lsp/settings/vimlatex.vim")

