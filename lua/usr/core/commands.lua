local M = {}

function M.open_lsp_log_file()
	vim.cmd.edit(vim.lsp.log.get_filename())
end

vim.api.nvim_create_user_command("LspLog", M.open_lsp_log_file)



return M
