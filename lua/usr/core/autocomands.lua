local opts = { clear = true }
local util = require("usr.core.util")
local api = vim.api
---------------------------------
--           GROUPS            --
---------------------------------

local filetype_id = api.nvim_create_augroup("FileTypeSetting", opts)

local at_save = api.nvim_create_augroup("Save", opts)

local at_exit = api.nvim_create_augroup("Exit", opts)

local at_enter = api.nvim_create_augroup("Enter", opts)

---------------------------------
--        AUTOCOMMANDS         --
---------------------------------

-- Matlab file was always categorized as octave file.
-- This autocommand will force neovim to recognize it as a matlab file.
api.nvim_create_autocmd({ "BufRead", "BufWritePost", "BufNewFile" }, {
	pattern = { "*.m" },
	callback = function()
		vim.bo.filetype = "matlab"
	end,
	group = filetype_id,
})

-- Detect Office scripts as a typescript filetype. Which it actually is but trimmed down version.
api.nvim_create_autocmd({ "BufRead", "BufWritePost", "BufNewFile" }, {
	pattern = { "*.osts" },
	callback = function()
		vim.bo.filetype = "typescript"
	end,
	group = filetype_id,
})

-- Detect Office scripts as a typescript filetype. Which it actually is but trimmed down version.
api.nvim_create_autocmd({ "BufRead", "BufEnter", "BufWritePost", "BufNewFile" }, {
	pattern = { "*.py" },
	callback = function()
		vim.opt.expandtab = true
		vim.opt.shiftwidth = 4
	end,
	group = filetype_id,
})

api.nvim_create_autocmd({ "BufLeave" }, {
	pattern = { "*.py" },
	callback = function()
		vim.opt.expandtab = false
		vim.opt.shiftwidth = 4
	end,
	group = filetype_id,
})

api.nvim_create_autocmd({ "BufRead", "BufEnter", "BufWritePost", "BufNewFile" }, {
	pattern = { "*.sdf" },
	callback = function()
		vim.opt.filetype = "xml"
	end,
	group = filetype_id,
})

-- Trim trailing whitespace on save
api.nvim_create_autocmd({ "BufWrite" }, {
	pattern = { "*" },
	callback = util.remove_trailing_whitespaces,
	group = at_save,
})

-- Save opened files
api.nvim_create_autocmd({ "ExitPre" }, {
	pattern = { "*" },
	callback = require('revolver').SaveOpenedFiles,
	group = at_exit,
})

