local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

local function trim(s)
  return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

local function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

function QtQuerryFinder()
	local address = "https://doc.qt.io/qt-5/" .. vim.fn.expand("<cword>"):lower() .. ".html"
	vim.cmd(":!kfmclient openURL " .. address)
end

--- NOTE: The function is not perfect. There are rules you have to obey:
-- 	1) The functino must be defined on one line.
--
---@param headerFile     string Is a header file name with a full path. The file can have extension
-- 						 either .h or .hpp.
---@param line           string Full line taken from the edditor. The line must end with a semicolon.
-- 						 The function must be defined in one line.
---@param promptForSourceFile    boolean Weather to prompt the user for source file.
---@param className?     string If the function is not in a class give there a nil.
function CreateDefinition(headerFile, line, promptForSourceFile, className)
	local functionName = vim.fn.expand("<cword>")

	local sourceFile = ""
	if string.sub(headerFile, -1) == "h" then
		sourceFile = string.gsub(headerFile, "[.]%w$","")
	else
		sourceFile = string.gsub(headerFile, "[.]%w%w%w$", "")
	end
	sourceFile = sourceFile .. ".cpp"

	if promptForSourceFile then
		sourceFile = vim.fn.input("Source File: ", sourceFile)
	end

	line = trim(line)
	line = string.sub(line, 1, -2)
	line = line .. "\n{\n\n}"
	if className ~= nil then
		line = string.gsub(line, " " .. functionName .. "[(]", " " .. className .. "::" .. functionName .."(", 1)
	end

	if not file_exists(sourceFile) then
		local out = io.open(sourceFile, "w")
		if out ~= nil then
			out:write("#include \"" .. headerFile .. "\"\n\n")
			out:flush()
			out:close()
		end
	end

	local out = io.open(sourceFile, 'a+')
	if out ~= nil then
		out:write(line, "\n\n")
		out:flush()
		out:close()
	end
end

function CreateClassMethodDefinition()
	local line = vim.fn.getline('.')
	local file = vim.api.nvim_buf_get_name(0)

	local indexOfLastSlashInName = string.find(file, "/[^/]*$")

	local className = string.sub(file, indexOfLastSlashInName)
	className = string.sub(className, 2)
	if string.sub(file, -1) == "h" then
		className = string.gsub(className, "[.]%w$","")
	else
		className = string.gsub(className, "[.]%w%w%w$", "")
	end

	CreateDefinition(file, line, false, className)
end

function CreateFunctionDefinition()
	local line = vim.fn.getline('.')
	local file = vim.api.nvim_buf_get_name(0)

	CreateDefinition(file, line, false)
end

keymap("n", "<leader>sh", ":ClangdSwitchSourceHeader<CR>", opts)
keymap("n", "<F2>", ":lua QtQuerryFinder()<CR>", opts)
keymap("n", "<F3>", ":lua CreateClassMethodDefinition()<CR>", opts)
keymap("n", "<F4>", ":lua CreateFunctionDefinition()<CR>", opts)

