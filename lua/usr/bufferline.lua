local bufferline = require("bufferline")
local icons = require("usr.core.icons")

bufferline.setup {
	options = {
		mode = "buffers", -- set to "tabs" to only show tabpages instead
		numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
		close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
		right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
		left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
		middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
		style_preset = bufferline.style_preset.minimal, -- or bufferline.style_preset.minimal,
		themable = true, -- | false, -- allows highlight groups to be overriden i.e. sets highlights as default
		indicator = {
			icon = icons.git.BoldBar, -- this should be omitted if indicator style is not 'icon'
			style = 'icon', -- | 'underline' | 'none',
		},
		buffer_close_icon = icons.ui.Close,
		modified_icon = icons.git.Mod,
		close_icon = icons.ui.Close,
		left_trunc_marker = icons.ui.LeftMarker,
		right_trunc_marker = icons.ui.RightMarker,
		--- name_formatter can be used to change the buffer's label in the bufferline.
		--- Please note some names can/will break the
		--- bufferline so use this at your discretion knowing that it has
		--- some limitations that will *NOT* be fixed.
		-- name_formatter = function(buf)  -- buf contains:
			  -- name                | str        | the basename of the active file
			  -- path                | str        | the full path of the active file
			  -- bufnr (buffer only) | int        | the number of the active buffer
			  -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
			  -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
		--[[ end, ]]
		max_name_length = 30,
		max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
		truncate_names = true, -- whether or not tab names should be truncated
		tab_size = 21,
		diagnostics = "nvim_lsp", -- "nvim_lsp" | "coc" | false ,
		diagnostics_update_in_insert = false,
		-- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
		diagnostics_indicator = function(count, level) --, diagnostics_dict, context)
			local icon = level:match("error") and icons.diagnostics.Error or icons.diagnostics.Warning
			return " " .. icon .. count
		end,
		offsets = {
			{
				filetype = "NvimTree",
				text = "",
				text_align = "left",
				separator = true
			}
		},
		color_icons = true, -- | false, -- whether or not to add the filetype icon highlights
	}
}

