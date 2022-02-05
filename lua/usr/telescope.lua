local status, telescope = pcall(require, "telescope")
if not status then
	return
end

local actions = require("telescope.actions")

telescope.setup {
	defaults = {

		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },

		mappings = {
			i = {
				["<C-h>"] = actions.cycle_history_prev,
				["<C-l>"] = actions.cycle_history_next,
			}
		}
	}
}
