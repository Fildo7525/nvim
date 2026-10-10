local library = {
	vim.fn.expand("$VIMRUNTIME/lua"),
	vim.fn.stdpath("config") .. "/lua",
}

library = vim.tbl_deep_extend(
	"force",
	library,
	vim.tbl_map(function(p) return p.name end, require("lazy").plugins())
)

return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".git", "stylua.toml" },
	settings = {
		Lua = {
			hint = { enable = true, },
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = library,
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
