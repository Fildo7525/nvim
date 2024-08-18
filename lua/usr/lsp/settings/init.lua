local current_path = vim.fn.expand("%")

-- Find file in a input direcotory supplied into a function
local function find_file_in_dir(dir, file)
	local file_path = dir .. "/" .. file
	local f = io.open(file_path, "r")
	if f ~= nil then
		io.close(f)
		return file_path
	end
	return nil
end

local M = {
	installed = require("mason-lspconfig").get_installed_servers(),
	lua = {
		-- WARN: The conde in current for requires that the name in the table must be the name of the lsp.
		-- At the same time the setting file does not need to have the same name as the lsp.
		bashls = require("usr.lsp.settings.bash"),
		clangd = require("usr.lsp.settings.clangd"),
		cmake = require("usr.lsp.settings.cmake"),
		gopls = require("usr.lsp.settings.go"),
		jsonls = require("usr.lsp.settings.jsonls"),
		lemminx = require("usr.lsp.settings.lemminx"),
		lua_ls = require("usr.lsp.settings.lua_ls"),
		pyright = require("usr.lsp.settings.pyright"),
		texlab = require("usr.lsp.settings.texlab"),
		yamlls = require("lspconfig.server_configurations.yamlls"),
	},
	vim = {
		vimlatex = find_file_in_dir(current_path, "vimlatex.vim"),
	}
}

return M
