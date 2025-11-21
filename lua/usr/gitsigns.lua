local gitsigns = require("gitsigns")
local icons = require("usr.core.icons")

gitsigns.setup {
	signs = {
		add = { text = icons.git.BoldBar },
		change = { text = icons.git.BoldBar },
		delete = { text = icons.git.Deleted },
		topdelete = { text = icons.git.TopDeleted },
		changedelete = { text = icons.git.ChagneDeleted },
		untracked = { text = icons.git.Untracked },
	},
	signs_staged = {
		add					= { text = icons.git.BoldBar },
		change			 = { text = icons.git.BoldBar },
		delete			 = { text = icons.git.Deleted },
		topdelete		= { text = icons.git.TopDeleted },
		changedelete = { text = icons.git.ChagneDeleted },
		untracked		= { text = icons.git.Untracked },
	},
	signs_staged_enable = true,
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = {
		follow_files = true,
	},
	auto_attach = true,
	attach_to_untracked = false,
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
		virt_text_priority = 100,
		use_focus = true,
	},
	current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000, -- Disable if file is longer than this (in lines)
	preview_config = {
		-- Options passed to nvim_open_win
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
	on_attach = function(bufnr)
		local function map(mode, l, r, opts)
			opts = opts or { noremap = true, silent = true }
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map('n', 'gnh', function()
			if vim.wo.diff then
				vim.cmd.normal({']c', bang = true})
			else
				gitsigns.nav_hunk('next')
			end
		end)

		map('n', 'gph', function()
			if vim.wo.diff then
				vim.cmd.normal({'[c', bang = true})
			else
				gitsigns.nav_hunk('prev')
			end
		end)

		-- Actions
		map('n', '<leader>lb', gitsigns.toggle_current_line_blame)
		map('n', 'gfb', function() gitsigns.blame_line{full=true} end)
		map("n", "<leader>gd", function ()
				local commit = vim.fn.input("Enter commit: ", "HEAD~")
				require("gitsigns").diffthis(commit)
			end)
		map('n', 'gbl', gitsigns.blame_line)
		map('n', 'gpr', gitsigns.preview_hunk)
		map('n', 'grb', gitsigns.reset_buffer)
		map('n', 'grh', gitsigns.reset_hunk)
		map('n', 'gsb', gitsigns.stage_buffer)
		map('n', 'gsh', gitsigns.stage_hunk)
		map('n', 'gtd', gitsigns.toggle_deleted)
		map('n', 'guh', gitsigns.undo_stage_hunk)
		map('v', 'grl', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
		map('v', 'gsh', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)

		-- Text object
		map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
	end
}
