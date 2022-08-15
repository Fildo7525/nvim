local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

function QtQuerryFinder()
	local address = "https://doc.qt.io/qt-5/" .. vim.fn.expand("<cword>"):lower() .. ".html"
	vim.cmd(":!kfmclient openURL " .. address)
end

--- NOTE: The function is not perfect. There are rules you have to obey:
-- 	1) Have the source file in the same dir as the header file.
-- 	2) There must not be any space before the space in the function name:
-- 		e.g.: WRONG: QMap<QString, QString> functinoName();
-- 								  ^
-- 		The space is the problem.
-- 	3) The function must be in a class.
-- 	4) The class must have the same name as the class.
function CreateFunctionDefinition()
	local line = vim.fn.getline('.')
	local file = vim.api.nvim_buf_get_name(0)

	local indexOfLastSlashInName = string.find(file, "/[^/]*$")

	local className = string.sub(file, indexOfLastSlashInName)
	className = string.sub(className, 2)

	if string.sub(file, -1) == "h" then
		file = string.gsub(file, "[.]%w$","")
		className = string.gsub(className, "[.]%w$","")
	else
		file = string.gsub(file, "[.]%w%w%w$", "")
		className = string.gsub(className, "[.]%w%w%w$", "")
	end

	line = string.sub(line, 2, -2)
	line = line .. "\n{\n\n}"
	line = string.gsub(line, " ", " " .. className .. "::", 1)

	file = file .. ".cpp"

	local out = io.open(file, 'a+')

	if out ~= nil then
		out:write(line, "\n\n")
		out:flush()
		out:close()
	end
end

keymap("n", "<leader>sh", ":ClangdSwitchSourceHeader<CR>", opts)
keymap("n", "<F2>", ":lua QtQuerryFinder()<CR>", opts)
keymap("n", "<F3>", ":lua CreateFunctionDefinition()<CR>", opts)

