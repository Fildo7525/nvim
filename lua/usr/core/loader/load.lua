--- config_loader.lua
---
--- A object for loading plugin configs.

local M = {}

local log_path = vim.fn.stdpath("cache") .. "/plugin_log/"
local logger = require("usr.core.loader.log").init(log_path)

---load_configs loads a plugin configurations from an array.
---
---@param configs table an array of relative paths from root dir to the plugin configs
function M:load_configs(configs)
	for _, conf in ipairs(configs) do
		local ok, err = pcall(require, conf)
		if not ok then
			logger:error(conf, err)
		end
	end

	logger:cleanup()
end

return M
