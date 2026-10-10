local util = require("usr.core.util")
local M = {}

function M.open_lsp_log_file()
	vim.cmd.edit(vim.lsp.log.get_filename())
end

function M.file_under_cursor_exists()
	local file_path = util.get_string_under_cursor()
	vim.print("Checking file: " .. file_path)
	local file_exists = false

	if file_path ~= '' then
		local f = io.open(file_path, "r")
		if f then
			f:close()
			vim.print("File was opened")
			file_exists = true
		end
	end

	if file_exists then
		print("File exists")
	else
		print("File does not exist")
	end
end

vim.api.nvim_create_user_command("LspLog", M.open_lsp_log_file)
vim.api.nvim_create_user_command("CursorFileExists", M.file_under_cursor_exists)

return M
