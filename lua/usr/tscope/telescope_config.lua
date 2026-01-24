local telescope = require("telescope")
local actions = require("telescope.actions")
local action_layout = require "telescope.actions.layout"
local icons = require("usr.core.icons")

telescope.setup {
	defaults = {
		layout_config = {
			horizontal = {
				preview_cutoff = 0,
			},
			vertical = {
				preview_cutoff = 0,
			},
		},
		layout_strategy = 'vertical',

		prompt_prefix = icons.telescope.Prompt,
		selection_caret = icons.telescope.Selection,
		path_display = { "truncate" },

		mappings = {
			i = {
				["<C-k>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.cycle_history_next,
				["<M-p>"] = action_layout.toggle_preview,
				["<C-o>"] = function(p_bufnr)
					require("telescope.actions").send_selected_to_qflist(p_bufnr)
					vim.cmd.cfdo("edit")
				end,
			},
			n = {
				["<M-p>"] = action_layout.toggle_preview,
			}
		}
	},
}

-- telescope.load_extension('ros')
