-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
local nvim_tree = require("nvim-tree")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local config = {
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	renderer = {
		icons = {
			glyphs = {
				default = "",
				symlink = "",
				git = {
					unstaged = "",
					staged = "",
					unmerged = "",
					renamed = "➜",
					untracked = "",
					deleted = "",
					ignored = "◌",
				},
				folder = {
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
				},
			},
		},
	},
}

-- open_on_setup
local function open_nvim_tree(data)

	-- buffer is a [No Name]
	local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

	-- buffer is a directory
	local directory = vim.fn.isdirectory(data.file) == 1

	if not no_name and not directory then
		return
	end

	-- change to the directory
	if directory then
		vim.cmd.cd(data.file)
	end

	-- open the tree
	require("nvim-tree.api").tree.open()
end

local function set_keymaps(bufnr)
	local api = require('nvim-tree.api')
	local opts = function(desc)
	 return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end


	-- Default mappings. Feel free to modify or remove as you wish.
	--
	-- BEGIN_DEFAULT_ON_ATTACH
	local keyset = vim.keymap.set
	keyset('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
	keyset('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
	keyset('n', '<C-k>', api.node.show_info_popup, opts('Info'))
	keyset('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
	keyset('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
	keyset('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
	keyset('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
	keyset('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
	keyset('n', '<CR>', api.node.open.edit, opts('Open'))
	keyset('n', 'l', api.node.open.edit, opts('Open'))
	keyset('n', 'o', api.node.open.edit, opts('Open'))
	keyset('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
	keyset('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
	keyset('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
	keyset('n', '.', api.node.run.cmd, opts('Run Command'))
	keyset('n', '-', api.tree.change_root_to_parent, opts('Up'))
	keyset('n', 'a', api.fs.create, opts('Create'))
	keyset('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
	keyset('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle No Buffer'))
	keyset('n', 'c', api.fs.copy.node, opts('Copy'))
	keyset('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Git Clean'))
	keyset('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
	keyset('n', ']c', api.node.navigate.git.next, opts('Next Git'))
	keyset('n', 'd', api.fs.remove, opts('Delete'))
	keyset('n', 'D', api.fs.trash, opts('Trash'))
	keyset('n', 'E', api.tree.expand_all, opts('Expand All'))
	keyset('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
	keyset('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
	keyset('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
	keyset('n', 'F', api.live_filter.clear, opts('Clean Filter'))
	keyset('n', 'f', api.live_filter.start, opts('Filter'))
	keyset('n', 'g?', api.tree.toggle_help, opts('Help'))
	keyset('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
	keyset('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
	keyset('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
	keyset('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
	keyset('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
	keyset('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
	keyset('n', 'o', api.node.open.edit, opts('Open'))
	keyset('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
	keyset('n', 'p', api.fs.paste, opts('Paste'))
	keyset('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
	keyset('n', 'q', api.tree.close, opts('Close'))
	keyset('n', 'r', api.fs.rename, opts('Rename'))
	keyset('n', 'R', api.tree.reload, opts('Refresh'))
	keyset('n', 's', api.node.run.system, opts('Run System'))
	keyset('n', 'S', api.tree.search_node, opts('Search'))
	keyset('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
	keyset('n', 'W', api.tree.collapse_all, opts('Collapse'))
	keyset('n', 'x', api.fs.cut, opts('Cut'))
	keyset('n', 'y', api.fs.copy.filename, opts('Copy Name'))
	keyset('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
	keyset('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
	keyset('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
	-- END_DEFAULT_ON_ATTACH


	-- Mappings removed via:
	-- remove_keymaps
	-- OR
	-- view.mappings.list..action = ""
	--
	-- The dummy set before del is done for safety, in case a default mapping does not exist.
	--
	-- You might tidy things by removing these along with their default mapping.
	vim.keymap.set('n', 'O', '', { buffer = bufnr })
	vim.keymap.del('n', 'O', { buffer = bufnr })
	vim.keymap.set('n', '<2-RightMouse>', '', { buffer = bufnr })
	vim.keymap.del('n', '<2-RightMouse>', { buffer = bufnr })
	vim.keymap.set('n', 'D', '', { buffer = bufnr })
	vim.keymap.del('n', 'D', { buffer = bufnr })
	vim.keymap.set('n', 'E', '', { buffer = bufnr })
	vim.keymap.del('n', 'E', { buffer = bufnr })


	-- Mappings migrated from view.mappings.list
	--
	-- You will need to insert "your code goes here" for any mappings with a custom action_cb
	keyset('n', 'A', api.tree.expand_all, opts('Expand All'))
	keyset('n', '?', api.tree.toggle_help, opts('Help'))
	keyset('n', 'C', api.tree.change_root_to_node, opts('CD'))
	keyset('n', 'l', api.node.open.edit, opts('Open'))
	keyset('n', 'P', function()
		local node = api.tree.get_node_under_cursor()
		print(node.absolute_path)
	end, opts('Print Node Path'))

	vim.keymap.set('n', 'Z', api.node.run.system, opts('Run System'))
end

local function on_attach(bufnr)
	set_keymaps(bufnr)
end


vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

config.on_attach = on_attach
nvim_tree.setup(config)
