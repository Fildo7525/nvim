local ok, ccc = pcall(require,"ccc.pick")
if not ok then
	print("Error loading ccc")
	return
end


ccc.setup({
	disable_default_mappings = true,
	highlighter = {
		auto_enable = true,
		lsp = true,
	},
	inputs = {
		ccc.input.rgb,
		ccc.input.hsl,
		ccc.input.hsv,
		ccc.input.oklab,
	},
	outputs = {
		ccc.output.css_rgb,
		ccc.output.ccc_hsl,
		ccc.output.ccc_oklab,
		ccc.output.hex,
	}
})
