
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
