local status_ok, sat = pcall(require, "satellite")
if not status_ok then
	return;
end

sat.setup {
	current_only = false,
	winblend = 50,
	zindex = 40,
	excluded_filetypes = {},
	width = 2,
	handlers = {
		search = {
			enable = true,
		},
		diagnostic = {
			enable = true,
		},
		gitsigns = {
			enable = true,
		},
		marks = {
			enable = true,
			show_builtins = false, -- shows the builtin marks like [ ] < >
		},
	},
}