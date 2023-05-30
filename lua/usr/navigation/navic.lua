local ok, navic = pcall(require, "nvim-navic")
if not ok then
	vim.notify("Nvim navic is not installed")
	return
end

navic.setup {
	icons = {
		File = ' ',
		Module = ' ',
		Namespace = ' ',
		Package = ' ',
		Class = ' ',
		Method = ' ',
		Property = ' ',
		Field = ' ',
		Constructor = ' ',
		Enum = ' ',
		Interface = ' ',
		Function = ' ',
		Variable = ' ',
		Constant = ' ',
		String = ' ',
		Number = ' ',
		Boolean = ' ',
		Array = ' ',
		Object = ' ',
		Key = ' ',
		Null = ' ',
		Enummember = ' ',
		Struct = ' ',
		Event = ' ',
		Operator = ' ',
		Typeparameter = ' ',
	},
	lsp = {
		auto_attach = true,
		preference = nil,
	},
	highlight = true,
	separator = " > ",
	depth_limit = 10,
	depth_limit_indicator = "..",
	safe_output = true
}

