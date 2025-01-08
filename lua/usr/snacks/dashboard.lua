---@class snacks.dashboard.Config
---@field enabled? boolean
---@field sections snacks.dashboard.Section
---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
return {
	enabled = true,
	sections = {
		{ section = "header" },
		{
			pane = 2,
			height = 5,
			padding = 1,
		},
		{ section = "keys", gap = 1, padding = 1 },
		{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
		{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
		{
			pane = 2,
			icon = " ",
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
