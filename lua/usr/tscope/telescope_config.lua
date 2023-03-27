local telescope = require("telescope")
local trouble = require("trouble.providers.telescope")
local actions = require("telescope.actions")
local lga_actions = require("telescope-live-grep-args.actions")
local action_layout = require "telescope.actions.layout"

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
		-- horizontal (default)
		-- vertical
		-- cursor
		-- bottom_pane
		-- center

		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "truncate" },
		 -- path_display can be set to an array with a combination of:
			-- - "hidden"	hide file names
			-- - "tail"	  only display the file name, and not the path
			-- - "absolute"  display absolute paths
			-- - "smart"	 remove as much from the path as possible to only show
			--			   the difference between the displayed paths.
			--			   Warning: The nature of the algorithm might have a negative
			--			   performance impact!
			-- - "shorten"   only display the first character of each directory in
			--			   the path
			-- - "truncate"  truncates the start of the path when the whole path will
			--			   not fit. To increase the the gap between the path and the edge.
			--			   set truncate to number `truncate = 3`

		mappings = {
			i = {
				["<C-k>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.cycle_history_next,
				["<c-t>"] = trouble.open_with_trouble,
				["<C-p>"] = lga_actions.quote_prompt(),
				["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
				["<M-p>"] = action_layout.toggle_preview,
			},
			n = {
				["<c-t>"] = trouble.open_with_trouble,
				["<M-p>"] = action_layout.toggle_preview,
			}
		}
	}
}

-- telescope.load_extension('ros')
