local status, telescope = pcall(require, "telescope")
if not status then
	vim.notify("telescope error")
	return
end

local trouble = require("trouble.providers.telescope")

local actions = require("telescope.actions")

telescope.setup {
	defaults = {

		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },

		mappings = {
			i = {
				["<C-k>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.cycle_history_next,
				["<c-t>"] = trouble.open_with_trouble,
			},
			n = {
				["<c-t>"] = trouble.open_with_trouble,
			}
		}
	}
}
