local status, telescope = pcall(require, "telescope")
if not status then
	vim.notify("telescope error")
	return
end

require("usr.tscope.telescope_config")
require("usr.tscope.adjustments")
