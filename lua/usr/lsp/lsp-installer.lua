local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	vim.notify("nvim-lsp-installer error")
	return
end

local status_lsp, lspconfig = pcall(require, "lspconfig")
if not status_lsp then
	vim.notify("lspconfig not present")
	return
end

local servers = {
	"jsonls",
	"sumneko_lua",
	"pyright",
	"cmake",
	"lemminx",
	"vimls",
	"yamlls",
	"clangd",
	"jdtls",
}

local settings = {
  ensure_installed = servers,
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
  -- max_concurrent_installers = 4,
  -- install_root_dir = path.concat { vim.fn.stdpath "data", "lsp_servers" },
}

lsp_installer.setup(settings)

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
-- lsp_installer.on_server_ready(function(server)

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("usr.lsp.handlers").on_attach,
		capabilities = require("usr.lsp.handlers").capabilities,
	}

	if server == "clangd" then
		local clang_opts = require("usr.lsp.settings.clangd")
		opts = vim.tbl_deep_extend("force", clang_opts, opts)
		-- opts = require("usr.lsp.settings.clangdExt")
		-- require("clangd_extensions").setup(opts)
		-- require("usr.keymaps").SetupClangKeymaps()
	end

	if server == "jsonls" then
		local jsonls_opts = require("usr.lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end

	if server == "sumneko_lua" then
		local sumneko_opts = require("usr.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server == "pyright" then
		local pyright_opts = require("usr.lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end

	if server == "jdtls" then
		local jdtls_opts = require("usr.lsp.settings.jdtls")
		opts = vim.tbl_deep_extend("force", jdtls_opts, opts)
	end

	if server == "cmake" then
		local cmake_opts = require("usr.lsp.settings.cmake")
		opts = vim.tbl_deep_extend("force", cmake_opts, opts)
	end

	if server == "lemminx" then
		local xml_opts = require("usr.lsp.settings.lemminx")
		opts = vim.tbl_deep_extend("force", xml_opts, opts)
	end

	if server == "vimls" then
		opts = opts
	end

	if server == "yamlls" then
		local yaml_opts = {} -- require("usr.lsp.serrings.yamlls")
		opts = vim.tbl_deep_extend("force", yaml_opts, opts)
	end
	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	-- if server ~= "clangd" then
		lspconfig[server].setup(opts)
	-- end
end

