local current_path = vim.fn.expand("%")

-- Find file in a input direcotory supplied into a function
local function find_file_in_dir(dir, file)
	local file_path = dir .. "/" .. file
	local f = io.open(file_path, "r")
	if f ~= nil then
		io.close(f)
		return file_path
	end
	return nil
end

local M = {
	vim = {
		vimlatex = find_file_in_dir(current_path, "vimlatex.vim"),
	}
}

return M
