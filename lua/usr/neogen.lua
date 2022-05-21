local status, neogen = pcall(require, 'neogen')
if not status then
	return
end

neogen.setup {
	enabled = true,
	input_after_comment = true,
	snippet_engine = "luasnip",
}

