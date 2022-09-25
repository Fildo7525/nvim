-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	vim.notify("nvim_tree error")
	return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
	vim.notify("nvim_tree.config error")
	return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup {
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = false,
	ignore_ft_on_setup = {
		"startify",
		"dashboard",
		"alpha",
	},
	root_dirs = {},
	prefer_startup_root = true,
	sync_root_with_cwd = false,
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = true,
	-- update_to_buf_dir = {
	-- 	enable = true,
	-- 	auto_open = true,
	-- },
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	view = {
		width = 30,
		hide_root_folder = false,
		side = "left",
		-- auto_resize = true,
		mappings = {
			custom_only = false,
			list = {
				{ key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
				{ key = "h", cb = tree_cb "close_node" },
				{ key = "v", cb = tree_cb "vsplit" },
			},
		},
		number = false,
		relativenumber = false,
	},
	renderer = {
		icons = {
			glyphs = {
				default = "",
				symlink = "",
				git = {
					unstaged = "",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					deleted = "",
					untracked = "U",
					ignored = "◌",
				},
				folder = {
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
				},
			}
		},
	},
	-- quit_on_open = 0,
	-- git_hl = 1,
	-- disable_window_picker = 0,
	-- root_folder_modifier = ":t",
	-- show_icons = {
	-- 	git = 1,
	-- 	folders = 1,
	-- 	files = 1,
	-- 	folder_arrows = 1,
	-- 	tree_width = 30,
	-- },
}

--[[ { -- BEGIN_DEFAULT_OPTS ]]
--[[ 	auto_reload_on_write = true, ]]
--[[ 	create_in_closed_folder = false, ]]
--[[ 	disable_netrw = false, ]]
--[[ 	hijack_cursor = false, ]]
--[[ 	hijack_netrw = true, ]]
--[[ 	hijack_unnamed_buffer_when_opening = false, ]]
--[[ 	ignore_buffer_on_setup = false, ]]
--[[ 	open_on_setup = false, ]]
--[[ 	open_on_setup_file = false, ]]
--[[ 	open_on_tab = false, ]]
--[[ 	ignore_buf_on_tab_change = {}, ]]
--[[ 	sort_by = "name", ]]
--[[ 	root_dirs = {}, ]]
--[[ 	prefer_startup_root = false, ]]
--[[ 	sync_root_with_cwd = false, ]]
--[[ 	reload_on_bufenter = false, ]]
--[[ 	respect_buf_cwd = false, ]]
--[[ 	on_attach = "disable", -- function(bufnr). If nil, will use the deprecated mapping strategy ]]
--[[ 	remove_keymaps = false, -- boolean (disable totally or not) or list of key (lhs) ]]
--[[ 	view = { ]]
--[[ 		adaptive_size = false, ]]
--[[ 		centralize_selection = false, ]]
--[[ 		width = 30, ]]
--[[ 		height = 30, ]]
--[[ 		hide_root_folder = false, ]]
--[[ 		side = "left", ]]
--[[ 		preserve_window_proportions = false, ]]
--[[ 		number = false, ]]
--[[ 		relativenumber = false, ]]
--[[ 		signcolumn = "yes", ]]
--[[ 		float = { ]]
--[[ 			enable = false, ]]
--[[ 			open_win_config = { ]]
--[[ 				relative = "editor", ]]
--[[ 				border = "rounded", ]]
--[[ 				width = 30, ]]
--[[ 				height = 30, ]]
--[[ 				row = 1, ]]
--[[ 				col = 1, ]]
--[[ 			}, ]]
--[[ 		}, ]]
--[[ 	}, ]]
--[[ 	renderer = { ]]
--[[ 		add_trailing = false, ]]
--[[ 		group_empty = false, ]]
--[[ 		highlight_git = false, ]]
--[[ 		full_name = false, ]]
--[[ 		highlight_opened_files = "none", ]]
--[[ 		root_folder_modifier = ":~", ]]
--[[ 		indent_markers = { ]]
--[[ 			enable = false, ]]
--[[ 			inline_arrows = true, ]]
--[[ 			icons = { ]]
--[[ 				corner = "└", ]]
--[[ 				edge = "│", ]]
--[[ 				item = "│", ]]
--[[ 				none = " ", ]]
--[[ 			}, ]]
--[[ 		}, ]]
--[[ 		icons = { ]]
--[[ 			webdev_colors = true, ]]
--[[ 			git_placement = "before", ]]
--[[ 			padding = " ", ]]
--[[ 			symlink_arrow = " ➛ ", ]]
--[[ 			show = { ]]
--[[ 				file = true, ]]
--[[ 				folder = true, ]]
--[[ 				folder_arrow = true, ]]
--[[ 				git = true, ]]
--[[ 			}, ]]
--[[ 			glyphs = { ]]
--[[ 				default = "", ]]
--[[ 				symlink = "", ]]
--[[ 				bookmark = "", ]]
--[[ 				folder = { ]]
--[[ 					arrow_closed = "", ]]
--[[ 					arrow_open = "", ]]
--[[ 					default = "", ]]
--[[ 					open = "", ]]
--[[ 					empty = "", ]]
--[[ 					empty_open = "", ]]
--[[ 					symlink = "", ]]
--[[ 					symlink_open = "", ]]
--[[ 				}, ]]
--[[ 				git = { ]]
--[[ 					unstaged = "✗", ]]
--[[ 					staged = "✓", ]]
--[[ 					unmerged = "", ]]
--[[ 					renamed = "➜", ]]
--[[ 					untracked = "★", ]]
--[[ 					deleted = "", ]]
--[[ 					ignored = "◌", ]]
--[[ 				}, ]]
--[[ 			}, ]]
--[[ 		}, ]]
--[[ 		special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" }, ]]
--[[ 		symlink_destination = true, ]]
--[[ 	}, ]]
--[[ 	hijack_directories = { ]]
--[[ 		enable = true, ]]
--[[ 		auto_open = true, ]]
--[[ 	}, ]]
--[[ 	update_focused_file = { ]]
--[[ 		enable = false, ]]
--[[ 		update_root = false, ]]
--[[ 		ignore_list = {}, ]]
--[[ 	}, ]]
--[[ 	ignore_ft_on_setup = {}, ]]
--[[ 	system_open = { ]]
--[[ 		cmd = "", ]]
--[[ 		args = {}, ]]
--[[ 	}, ]]
--[[ 	diagnostics = { ]]
--[[ 		enable = false, ]]
--[[ 		show_on_dirs = false, ]]
--[[ 		debounce_delay = 50, ]]
--[[ 		icons = { ]]
--[[ 			hint = "", ]]
--[[ 			info = "", ]]
--[[ 			warning = "", ]]
--[[ 			error = "", ]]
--[[ 		}, ]]
--[[ 	}, ]]
--[[ 	filters = { ]]
--[[ 		dotfiles = false, ]]
--[[ 		custom = {}, ]]
--[[ 		exclude = {}, ]]
--[[ 	}, ]]
--[[ 	 filesystem_watchers = { ]]
--[[ 		enable = true, ]]
--[[ 		debounce_delay = 50, ]]
--[[ 	}, ]]
--[[ 	git = { ]]
--[[ 		enable = true, ]]
--[[ 		ignore = true, ]]
--[[ 		show_on_dirs = true, ]]
--[[ 		timeout = 400, ]]
--[[ 	}, ]]
--[[ 	actions = { ]]
--[[ 		use_system_clipboard = true, ]]
--[[ 		change_dir = { ]]
--[[ 			enable = true, ]]
--[[ 			global = false, ]]
--[[ 			restrict_above_cwd = false, ]]
--[[ 		}, ]]
--[[ 		expand_all = { ]]
--[[ 			max_folder_discovery = 300, ]]
--[[ 			exclude = {}, ]]
--[[ 		}, ]]
--[[ 		file_popup = { ]]
--[[ 			open_win_config = { ]]
--[[ 				col = 1, ]]
--[[ 				row = 1, ]]
--[[ 				relative = "cursor", ]]
--[[ 				border = "shadow", ]]
--[[ 				style = "minimal", ]]
--[[ 			}, ]]
--[[ 		}, ]]
--[[ 		open_file = { ]]
--[[ 			quit_on_open = false, ]]
--[[ 			resize_window = true, ]]
--[[ 			window_picker = { ]]
--[[ 				enable = true, ]]
--[[ 				chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890", ]]
--[[ 				exclude = { ]]
--[[ 					filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" }, ]]
--[[ 					buftype = { "nofile", "terminal", "help" }, ]]
--[[ 				}, ]]
--[[ 			}, ]]
--[[ 		}, ]]
--[[ 		remove_file = { ]]
--[[ 			close_window = true, ]]
--[[ 		}, ]]
--[[ 	}, ]]
--[[ 	trash = { ]]
--[[ 		cmd = "gio trash", ]]
--[[ 		require_confirm = true, ]]
--[[ 	}, ]]
--[[ 	live_filter = { ]]
--[[ 		prefix = "[FILTER]: ", ]]
--[[ 		always_show_folders = true, ]]
--[[ 	}, ]]
--[[ 	log = { ]]
--[[ 		enable = false, ]]
--[[ 		truncate = false, ]]
--[[ 		types = { ]]
--[[ 			all = false, ]]
--[[ 			config = false, ]]
--[[ 			copy_paste = false, ]]
--[[ 			dev = false, ]]
--[[ 			diagnostics = false, ]]
--[[ 			git = false, ]]
--[[ 			profile = false, ]]
--[[ 			watcher = false, ]]
--[[ 		}, ]]
--[[ 	}, ]]
--[[ } ]]
