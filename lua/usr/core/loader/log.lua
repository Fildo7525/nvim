-- log.lua
--
-- A file with basic logger for loading of plugin configs.

local M = {}
local Logger = { was_error = false }

local function date_time()
	local date_table = os.date("*t")
	local ms = string.match(tostring(os.clock()), "%d%.(%d+)")
	local hour, minute, second = date_table.hour, date_table.min, date_table.sec
	local year, month, day = date_table.year, date_table.month, date_table.day -- date_table.wday to date_table.day
	local result = string.format("%d-%d-%d_%d:%d:%d:%s", year, month, day, hour, minute, second, ms)

	return result
end

---init creates a new Logger which will (if needed) create logs in logs_dir
---directory
---
---@param logs_dir string a path to dir, where logs will be saved
---@return table Logger object
function M.init(logs_dir)
	local log_path = logs_dir
	os.execute("mkdir -p " .. log_path)
	local file_name = log_path .. date_time() .. ".log"
	Logger.file_name = file_name
	Logger.file = io.open(file_name, "a")

	return Logger
end

---error saves details about an error which occured in origin
---
---@param origin string an origin of the error
---@param err string an error message which occured
function Logger:error(origin, err)
	self.file:write(origin .. ":\n\t" .. err .. "\n")
	self.was_error = true
end

---cleanup cleans resources used during logging
function Logger:cleanup()
	self.file:close()
	if self.wasError then
		vim.notify("An error occured, see " .. self.file_name .." for details", vim.log.levels.ERROR)
	else
		os.remove(self.file_name)
	end
end

return M
