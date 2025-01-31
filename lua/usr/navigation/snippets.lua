local status, luasnip = pcall(require, "luasnip")
if not status then
	vim.notify("Lusnip cannot be required", vim.log.levels.ERROR)
	return
end

require("luasnip/loaders/from_vscode").lazy_load()

luasnip.config.set_config({
	-- This tells LuaSnip to remember to keep around the last snippet.
	-- You can jump back into it even if you move outside of the selection
	history = false,

	-- This one is cool cause if you have dynamic snippets, it updates as you type!
	updateevents = "TextChanged,TextChangedI",

	-- Autosnippets:
	enable_autosnippets = false,

	--[[ ext_opts = { ]]
	--[[ 	[types.choiceNode] = { ]]
	--[[ 		active = { ]]
	--[[ 			virt_text = { { " « ", "NonTest" } }, ]]
	--[[ 		}, ]]
	--[[ 	}, ]]
	--[[ }, ]]
})

