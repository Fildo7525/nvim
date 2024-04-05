local comment = require("Comment")

comment.setup {
	---Add a space b/w comment and the line
	padding = true,

	---Whether the cursor should stay at its position
	sticky = true,

	---Lines to be ignored while (un)comment
	ignore = nil,

	---LHS of toggle mappings in NORMAL mode
	toggler = {
		---Line-comment toggle keymap
		line = 'gcc',
		---Block-comment toggle keymap
		block = 'gbc',
	},

	---LHS of operator-pending mappings in NORMAL and VISUAL mode
	opleader = {
		line = 'gc',	---Line-comment keymap
		block = 'gb',	---Block-comment keymap
	},

	---LHS of extra mappings
	extra = {
		above = 'gcO',	---Add comment on the line above
		below = 'gco',	---Add comment on the line below
		eol = 'gcA',	---Add comment at the end of line
	},

	---Enable keybindings
	---NOTE: If given `false` then the plugin won't create any mappings
	mappings = {
		basic = true,	---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
		extra = true,	---Extra mapping; `gco`, `gcO`, `gcA`
	},

	---Function to call before (un)comment
	pre_hook = function(ctx)
		local U = require("Comment.utils")

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

	---Function to call after (un)comment
	post_hook = nil,
}
