local icons = require("usr.core.icons")
local ok, neotree = pcall(require, "neo-tree")
if not ok then
	print("Neotree not found")
	return
end

neotree.setup({
	popup_border_style = "rounded",
	source_selector = {
		winbar = false, -- toggle to show selector on winbar
		statusline = false, -- toggle to show selector on statusline
		show_scrolled_off_parent_node = false,
		sources = {
			{
				source = "filesystem",
				display_name = " 󰉓 Files ",
			},
			{
				source = "buffers",
				display_name = " 󰈚 Buffers ",
			},
			{
				source = "git_status",
				display_name = " 󰊢 Git ",
			},
		},
		content_layout = "start",
		tabs_layout = "equal",
		truncation_character = "…",
		tabs_min_width = nil,
		tabs_max_width = nil,
		padding = 0, -- int | { left: int, right: int }
		separator = { left = "▏", right= "▕" }, -- string | { left: string, right: string, override: string | nil }
		separator_active = nil, -- string | { left: string, right: string, override: string | nil } | nil
		show_separator_on_edge = false,
		highlight_tab = "NeoTreeTabInactive",
		highlight_tab_active = "NeoTreeTabActive",
		highlight_background = "NeoTreeTabInactive",
		highlight_separator = "NeoTreeTabSeparatorInactive",
		highlight_separator_active = "NeoTreeTabSeparatorActive",
	},
	commands = {
		system_open = function(state)
			local node = state.tree:get_node()
			local path = node:get_id()
			vim.fn.jobstart({"xdg-open", path}, {detach = true})
		end,
		set_to_middle = function(state)
			-- Redraw, line [count] at center of window (default
			-- cursor line). Leave the cursor in the same column.
			vim.cmd("normal! zz")
		end,
		execute = function(state)
			local node = state.tree:get_node()
			local path = node:get_id()
			vim.cmd("! " .. path)
		end,
		copy_name = function(state)
			-- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
			-- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
			local node = state.tree:get_node()
			local filepath = node:get_id()
			local filename = node.name
			local modify = vim.fn.fnamemodify

			local results = {
				filepath,
				modify(filepath, ':.'),
				modify(filepath, ':~'),
				filename,
				modify(filename, ':r'),
				modify(filename, ':e'),
			}

			-- absolute path to clipboard
			local i = vim.fn.inputlist({
				'Choose to copy to clipboard:',
				'1. Absolute path: ' .. results[1],
				'2. Path relative to CWD: ' .. results[2],
				'3. Path relative to HOME: ' .. results[3],
				'4. Filename: ' .. results[4],
				'5. Filename without extension: ' .. results[5],
				'6. Extension of the filename: ' .. results[6],
			})

			if i > 0 then
				local result = results[i]
				if not result then return print('Invalid choice: ' .. i) end
				vim.fn.setreg('+', result)
			end
		end,
	},
	filesystem ={
		hijack_netrw_behavior = "open_current",
		group_empty_dirs = true,
		window = {
			mappings = {
				["l"] = "open",
				["h"] = "close_node",
				["s"] = "system_open",
				["z"] = "set_to_middle",
				["E"] = "execute",
				["Y"] = "copy_name",
			},
			fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
				["<C-j>"] = "move_cursor_down",
				["<C-k>"] = "move_cursor_up",
			}
		},
	},
	default_component_configs = {
		diagnostics = {
			simbols = {
				hint = icons.diagnostics.Hint,
				info = icons.diagnostics.Information,
				warn = icons.diagnostics.Warning,
				error = icons.diagnostics.Error,
			},
		},
		icon = {
			folder_closed = icons.documents.FullFolder,
			folder_open = icons.documents.OpenFolder,
			folder_empty = icons.documents.EmptyFolder,
			folder_empty_open = icons.documents.OpenFullFolder,
		},
		modified = {
			symbol = icons.ui.BigCircle
		},
		git_status = {
			symbols = {
				added = icons.git.Add,
				deleted = icons.git.Deleted,
				modified = icons.git.Mod,
				renamed = icons.git.Renamed,
				untracked = icons.git.Untracked,
				ignored = icons.git.Ignored,
				unstaged = icons.git.Unstaged,
				conflict = icons.git.Diff,
			},
			align = "left",
		},
	},
	window = {
		popup = {
			popup_border_style = "rounded",
		}
	},
})

