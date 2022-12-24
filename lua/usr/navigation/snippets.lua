local status, luasnip = pcall(require, "luasnip")
if not status then
	vim.notify("Lusnip cannot be required", vim.log.levels.ERROR)
	return
end

local status, types = pcall(require, "luasnip.util.types")
if not status then
	vim.notify("Lusnip.util.types cannot be required", vim.log.levels.ERROR)
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

vim.keymap.set({ "i", "s" }, "<C-j>", function()
	if luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	end
end)

vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	end
end)

vim.keymap.set({ "i", "s" }, "<C-s>", function()
	if luasnip.choice_active() then
		luasnip.change_choice(1)
	end
end)

