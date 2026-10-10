local autopairs = require("nvim-autopairs")

autopairs.setup {
	check_ts = true,
	enabled = function(bufnr) return true end, -- control if auto-pairs should be enabled when attaching to a buffer
	disable_filetype = { "TelescopePrompt", "spectre_panel" },
	disable_in_macro = true,  -- disable when recording or executing a macro
	disable_in_visualblock = false ,-- disable when insert after visual block mode
	disable_in_replace_mode = true,
	ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
	enable_moveright = true,
	enable_afterquote = true,  -- add bracket pairs after quote
	enable_check_bracket_line = true,  --- check bracket in same line
	enable_bracket_in_quote = true, --
	enable_abbr = false, -- trigger abbreviation
	break_undo = true, -- switch for basic rule break undo sequence
	map_cr = true,
	map_bs = true,  -- map the <BS> key
	map_c_h = false,  -- Map the <C-h> key to delete a pair
	map_c_w = false, -- map <c-w> to delete a pair if possible
}

