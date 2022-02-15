local status, comment = pcall(require, "Comment")
if not status then
	vim.notify("comment error")
	return
end

comment.setup {
	pre_hook = function(ctx)
		local U_ok, U = pcall(require, "Comment.utils")
		if not U_ok then
			vim.notify("U_ok comment.lua error")
			return
		end

		local location = nil
		if ctx.ctype == U.ctype.block then
			location = require("ts_context_commentstring.utils").get_cursor_location()
		elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
			location = require("ts_context_commentstring.utils").get_visual_start_location()
		end

		return require("ts_context_commentstring.internal").calculate_commentstring {
			key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
			location = location,
		}
	end,
}
