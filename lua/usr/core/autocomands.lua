local opts = { clear = true }
local util = require("usr.core.util")
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

-- Detect Office scripts as a typescript filetype. Which it actually is but trimmed down version.
vim.api.nvim_create_autocmd({ "BufRead", "BufEnter", "BufWritePost", "BufNewFile" }, {
	pattern = { "*.py" },
	callback = function()
		vim.opt.expandtab = true
		vim.opt.shiftwidth = 4
	end,
	group = filetype_id,
})

vim.api.nvim_create_autocmd({ "BufLeave" }, {
	pattern = { "*.py" },
	callback = function()
		vim.opt.expandtab = false
		vim.opt.shiftwidth = 4
	end,
	group = filetype_id,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufEnter", "BufWritePost", "BufNewFile" }, {
	pattern = { "*.sdf" },
	callback = function()
		vim.opt.filetype = "xml"
	end,
	group = filetype_id,
})

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWrite" }, {
	pattern = { "*" },
	callback = util.remove_trailing_whitespaces,
	group = at_save,
})

-- Save opened files
vim.api.nvim_create_autocmd({ "ExitPre" }, {
	pattern = { "*" },
	callback = require('revolver').SaveOpenedFiles,
	group = at_exit,
})

