local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")

local servers = {
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
}

local settings = {
	ensure_installed = {},
	-- automatic_installation = false,
	ui = {
		icons = {
			-- server_installed = "◍",
			-- server_pending = "◍",
			-- server_uninstalled = "◍",
			-- server_installed = "✓",
			-- server_pending = "➜",
			-- server_uninstalled = "✗",
		},
		keymaps = {
			toggle_server_expand = "<CR>",
			install_server = "i",
			update_server = "u",
			check_server_version = "c",
			update_all_servers = "U",
			check_outdated_servers = "C",
			uninstall_server = "X",
		},
	},

	log_level = vim.log.levels.INFO,
}

lsp_installer.setup(settings)

local opts = {}

for _, server in pairs(servers) do
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
		--[[ opts.on_attach = function(client, bufnr) ]]
		--[[ 	require("usr.lsp.handlers").on_attach(client, bufnr) ]]
		--[[]]
		--[[ 	local caps = client.server_capabilities ]]
		--[[ 	if caps.semanticTokensProvider and caps.semanticTokensProvider.full then ]]
		--[[ 		local augroup = vim.api.nvim_create_augroup("SemanticTokens", {}) ]]
		--[[ 		vim.api.nvim_create_autocmd("TextChanged", { ]]
		--[[ 			group = augroup, ]]
		--[[ 			buffer = bufnr, ]]
		--[[ 			callback = function() ]]
		--[[ 				vim.lsp.buf.semantic_tokens_full() ]]
		--[[ 			end, ]]
		--[[ 		}) ]]
		--[[ 		-- fire it first time on load as well ]]
		--[[ 		vim.lsp.buf.semantic_tokens_full() ]]
		--[[ 	end ]]
		--[[ end ]]
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

	lspconfig[server].setup(opts)
end

