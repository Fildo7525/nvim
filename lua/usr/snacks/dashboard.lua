local icons = require("usr.core.icons")

---@class snacks.dashboard.Config
---@field enabled? boolean
---@field sections snacks.dashboard.Section
---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
return {
	preset = {
		-- Used by the `keys` section to show keymaps.
		-- Set your custom keymaps here.
		-- When using a function, the `items` argument are the default keymaps.
		---@type snacks.dashboard.Item[]
		keys = {
			{ icon = icons.ui.Search, key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
			{ icon = icons.documents.File, key = "n", desc = "New File", action = ":ene | startinsert" },
			{ icon = icons.telescope.Prompt, key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
			{ icon = icons.documents.RecentFile, key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
			{ icon = icons.kind.Settings, key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
			{ icon = icons.git.Restore, key = "s", desc = "Restore Session", section = "session" },
			{ icon = icons.kind.Sleep, key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
			{ icon = icons.diagnostics.Lsp, key = "M", desc = "Mason", action = ":Mason", enabled = package.loaded.lazy ~= nil },
			{ icon = icons.kind.Quit, key = "q", desc = "Quit", action = ":qa" },
		},
	},
	-- item field formatters
	sections = {
		{ section = "header" },
		{
			pane = 2,
			padding = 5,
		},
		{ section = "keys", gap = 1, padding = 1 },
		{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
		{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
		{
			pane = 2,
			icon = icons.git.Branch,
			title = "Git Status",
			section = "terminal",
			enabled = function()
				return Snacks.git.get_root() ~= nil
			end,
			cmd = "git status --short --branch --renames",
			height = 5,
			padding = 1,
			ttl = 5 * 60,
			indent = 3,
		},
		{ section = "startup" },
	},
}
