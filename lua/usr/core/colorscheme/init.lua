--[[ COLORSCHEME = require("usr.core.colorscheme.configs.tokyo") ]]
COLORSCHEME = require("usr.core.colorscheme.configs.cattpucin")

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. COLORSCHEME)
if not status_ok then
	vim.notify("colorscheme " .. COLORSCHEME .. " not found!", vim.log.levels.ERROR)
	return
end

