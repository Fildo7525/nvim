require("usr.lsp.lspMason")
local _ = require("lspconfig")

require("usr.lsp.lsp-installer")
require("usr.lsp.handlers").setup()
require("usr.lsp.signature")
require("usr.lsp.null_ls")

vim.cmd('source ./settings/vimlatex.vim')

