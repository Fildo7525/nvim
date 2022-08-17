local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

--- Trims string.
---@param s string String to be trimmed.
---@return string Trimmed string.
local function trim(s)
  return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

--- Checks if the file with name 'name' exists.
---@param name string File name.
---@return boolean Wether the file exists.
local function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

--- Open qt-5 documentation about the word under cursor.
function QtQuerryFinder()
	local address = "https://doc.qt.io/qt-5/" .. vim.fn.expand("<cword>"):lower() .. ".html"
	-- ERROR: open / xdg-open doesn't work for me
	vim.cmd(":!kfmclient openURL " .. address)
end

--- NOTE: The function is not perfect. There are rules you have to obey:
-- 	1) The function must be defined on one line.
--
-- 	NOTE: Default arguments are not deleted.
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

	-- trim the line, remove semicolon and add curly braces
	line = trim(line)
	line = string.sub(line, 1, -2)
	line = line .. "\n{\n\n}"

	-- remove static and explicit keywords
	if line:find("static") == 1 then
		line = line:gsub("static ", "")
	elseif line:find("explicit") == 1 then
		line = line:gsub("explicit", "")
	elseif line:find(functionName) == 1 then
		line = line:gsub(functionName, " " .. functionName)
	end

	-- This doesn't work properly
	if line:find(" = (%w+)[:]?[:]?(%w+)?,") then
		print("comma present")
		line = line:gsub(" = (%w+)[:]?[:]?(%w+)?,", ",")
	elseif line:find(" = (%w+)[:]?[:]?(%w+)?[)]") then
		print("paranthese present")
		line = line:gsub(" = (%w+)[:]?[:]?(%w+)?[)]", ")")
	end

	if className ~= nil then
		if string.find(line, " [*]" .. functionName) then
			line = string.gsub(line, " [*]" .. functionName .. "[(]", " *" .. className .. "::" .. functionName .."(", 1)
		elseif string.find(line, " &" .. functionName) then
			line = string.gsub(line, " &" .. functionName .. "[(]", " &" .. className .. "::" .. functionName .."(", 1)
		else
			line = string.gsub(line, " " .. functionName .. "[(]", " " .. className .. "::" .. functionName .."(", 1)
		end
	end
	-- trim the line because of the constructor edge case
	line = trim(line)

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

--- Create Method declaration in source file. Class Name is either deduced from the header file,
-- or the user is prompted to input the class name.
---@param classNamePrompt? boolean Wether to ask for a class name.
---@param sourceFilePrompt boolean Wether to ask for a source file name.
function CreateClassMethodDefinition(sourceFilePrompt, classNamePrompt)
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

	if classNamePrompt then
		className = vim.fn.input("Enter the class name: ", className)
	end

	CreateDefinition(file, line, sourceFilePrompt, className)
end

--- Create function definition in source file.
---@param sourceFilePrompt boolean Wether to prompt the user for source file name.
function CreateFunctionDefinition(sourceFilePrompt)
	local line = vim.fn.getline('.')
	local file = vim.api.nvim_buf_get_name(0)

	CreateDefinition(file, line, sourceFilePrompt)
end

keymap("n", "<leader>sh", ":ClangdSwitchSourceHeader<CR>", opts)
keymap("n", "<F2>", ":lua QtQuerryFinder()<CR>", opts)
keymap("n", "<F3>", ":lua CreateClassMethodDefinition()<CR>", opts)
keymap("n", "<F4>", ":lua CreateFunctionDefinition()<CR>", opts)

