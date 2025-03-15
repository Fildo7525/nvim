
local M = {}

function M.config()
	local ok, ccc = pcall(require,"ccc")
	if not ok then
		print("Error loading ccc")
		return
	end

	return {
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
			ccc.output.css_hsl,
			ccc.output.css_oklab,
			ccc.output.hex,
		}
	}
end

return M
