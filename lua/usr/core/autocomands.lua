
-- Matlab file was always categorized as octave file.
-- This autocommand will force neovim to recognize it as a matlab file.
local matlab_ft_id = vim.api.nvim_create_augroup("FileTypeSetting", {
	clear = true,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost", "BufNewFile" }, {
	pattern = { "*.m" },
	callback = function()
		vim.bo.filetype = "matlab"
	end,
	group = matlab_ft_id,
})

local at_save = vim.api.nvim_create_augroup("Save", {
	clear = true,
})

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWrite" }, {
	pattern = { "*" },
	callback = function()
		-- Trim trailing whitespace
		if vim.bo.modifiable then
			vim.cmd("%s/\\s\\+$//e")
			vim.cmd.write()
		end
	end,
	group = at_save,
})

-- Save opened files
local at_exit = vim.api.nvim_create_augroup("Exit", {
	clear = true,
})

vim.api.nvim_create_autocmd({ "ExitPre" }, {
	pattern = { "*" },
	callback = function()
		-- Trim trailing whitespace
		require('revolver').SaveOpenedFiles()
	end,
	group = at_exit,
})
