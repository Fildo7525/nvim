local icons = require("usr.core.icons")

require('winbar').setup({
	enabled = true,

	show_file_path = false,
	show_symbols = true,

	colors = {
		path = '', -- You can customize colors like #c946fd
		file_name = '',
		symbols = '',
	},

	icons = {
		file_icon_default = icons.kind.File,
		seperator = icons.ui.ArrowClosed,
		editor_state = icons.ui.BigCircle,
		lock_icon = icons.ui.Lock,
	},

	exclude_filetype = {
		'help',
		'startify',
		'dashboard',
		'packer',
		'neogitstatus',
		'NvimTree',
		'Trouble',
		'alpha',
		'lir',
		'Outline',
		'spectre_panel',
		'toggleterm',
		'qf',
	}
})

