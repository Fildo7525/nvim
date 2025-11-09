---@class ConfigCoreUtil
---@field opt table<string, string>
---@field remove_trailing_whitespaces fun()
---@field register_options fun(options:table<string, any>)
local M = {
	opt = {
		append = "a",
		remove = "r",
		prepend = "p",
	},
}

function M.remove_trailing_whitespaces()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)

	-- Trim trailing whitespace
	if not vim.bo.modifiable then
		return
	end

	vim.cmd("%s/\\s\\+$//e")
	local filename = vim.api.nvim_buf_get_name(0)
	vim.cmd.save(filename)
	vim.api.nvim_win_set_cursor(0, cursor_pos)
end


function M.register_options(options)
	for k, v in pairs(options) do
		if type(v) ~= "table" then
			vim.opt[k] = v
			goto continue
		end

		if #v % 2 == 1 then
			vim.notify("Table must have an even number of elements. Option " .. k, vim.log.levels.ERROR)
			goto continue
		end

		for i=1, #v/2 do
			if v[i*2-1] == M.opt.append then
				vim.opt[k]:append(v[i*2])

			elseif v[i*2-1] == M.opt.remove then
				vim.opt[k]:remove(v[i*2])

			elseif v[i*2-1] == M.opt.prepend then
				vim.opt[k]:prepend(v[i*2])

			else
				error("Invalid option")

			end
		end

		::continue::
	end
end

return M
