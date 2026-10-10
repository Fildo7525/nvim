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

		for i=1, #v, 2 do
			if v[i] == M.opt.append then
				vim.opt[k]:append(v[i+1])

			elseif v[i] == M.opt.remove then
				vim.opt[k]:remove(v[i+1])

			elseif v[i] == M.opt.prepend then
				vim.opt[k]:prepend(v[i+1])

			else
				error("Invalid option")

			end
		end

		::continue::
	end
end

function M.get_string_under_cursor()
	local line = vim.api.nvim_get_current_line()
	local col = vim.fn.col('.') - 1	-- 0-indexed

	-- Search backwards from cursor for a quote character
	for i = col, 0, -1 do
		local c = line:sub(i + 1, i + 1)
		if c == '"' or c == "'" then
			-- Found a quote — now find the matching closing quote
			for j = i + 2, #line + 1 do
				if line:sub(j, j) == c then
					return line:sub(i + 2, j - 1)
				end
			end
			-- No closing quote found after this one — might be a closing
			-- quote, so keep searching backwards for the real opening quote
		end
	end

	return nil
end


return M
