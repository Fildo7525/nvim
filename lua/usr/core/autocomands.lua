local opts = { clear = true }
---------------------------------
--           GROUPS            --
---------------------------------

local filetype_id = vim.api.nvim_create_augroup("FileTypeSetting", opts)

local at_save = vim.api.nvim_create_augroup("Save", opts)

local at_exit = vim.api.nvim_create_augroup("Exit", opts)

---------------------------------
--        AUTOCOMMANDS         --
---------------------------------

-- Matlab file was always categorized as octave file.
-- This autocommand will force neovim to recognize it as a matlab file.
vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost", "BufNewFile" }, {
	pattern = { "*.m" },
	callback = function()
		vim.bo.filetype = "matlab"
	end,
	group = filetype_id,
})

-- Detect Office scripts as a typescript filetype. Which it actually is but trimmed down version.
vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost", "BufNewFile" }, {
	pattern = { "*.osts" },
	callback = function()
		vim.bo.filetype = "typescript"
	end,
	group = filetype_id,
})

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWrite" }, {
	pattern = { "*" },
	callback = function()
		local cursor_pos = vim.api.nvim_win_get_cursor(0)

		-- Trim trailing whitespace
		if not vim.bo.modifiable then
			return
		end

		vim.cmd("%s/\\s\\+$//e")
		vim.cmd.write()
		vim.api.nvim_win_set_cursor(0, cursor_pos)
	end,
	group = at_save,
})

-- Save opened files
vim.api.nvim_create_autocmd({ "ExitPre" }, {
	pattern = { "*" },
	callback = function()
		-- Trim trailing whitespace
		require('revolver').SaveOpenedFiles()
	end,
	group = at_exit,
})

