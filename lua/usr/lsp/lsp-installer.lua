local lspconfig = require("lspconfig")

local M = {}

M.servers = {
	"bashls",
	"clangd",
	"cmake",
	"jsonls",
	"lemminx",
	"marksman",
	"pyright",
	"lua_ls",
	"texlab",
	"tsserver",
	"vimls",
	"yamlls",
	"matlab_ls",
	"gopls",
}

function M.setup()
	for _, server in pairs(M.servers) do
		opts = {
			on_attach = require("usr.lsp.handlers").on_attach,
			capabilities = require("usr.lsp.handlers").capabilities,
		}

		if server == "bashls" then
			local bash_opts = require("usr.lsp.settings.bash")
			opts = vim.tbl_deep_extend("force", bash_opts, opts)
		end

		if server == "clangd" then
			local clangd_opts = require("usr.lsp.settings.clangd")
			opts = vim.tbl_deep_extend("force", clangd_opts, opts)
		end

		if server == "cmake" then
			local cmake_opts = require("usr.lsp.settings.cmake")
			opts = vim.tbl_deep_extend("force", cmake_opts, opts)
		end

		if server == "jsonls" then
			local jsonls_opts = require("usr.lsp.settings.jsonls")
			opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
		end

		if server == "lua_ls" then
			local lua_opts = require("usr.lsp.settings.lua_ls")
			opts = vim.tbl_deep_extend("force", lua_opts, opts)
		end

		if server == "pyright" then
			local pyright_opts = require("usr.lsp.settings.pyright")
			opts = vim.tbl_deep_extend("force", pyright_opts, opts)
		end

		if server == "lemminx" then
			local xml_opts = require("usr.lsp.settings.lemminx")
			opts = vim.tbl_deep_extend("force", xml_opts, opts)
		end

		if server == "texlab" then
			local latex_opts = require("usr.lsp.settings.texlab")
			opts = vim.tbl_deep_extend("force", latex_opts, opts)
		end

		if server == "yamlls" then
			local yaml_opts = {} -- require("usr.lsp.serrings.yamlls")
			opts = vim.tbl_deep_extend("force", yaml_opts, opts)
		end

		if server == "matlab_ls" then
			local matlab_opts = require("usr.lsp.settings.matlabls")
			opts = vim.tbl_deep_extend("force", matlab_opts, opts)
		end

		if server == "gopls" then
			local go_opts = require("usr.lsp.settings.go")
			opts = vim.tbl_deep_extend("force", go_opts, opts)
		end

		lspconfig[server].setup(opts)
	end
end

return M
