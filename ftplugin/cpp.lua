local status_ok, ts = pcall(require, "nvim-treesitter")
if not status_ok then
	return
end

----------------------
-- HELPER FUNCTIONS --
----------------------

--- Trims string.
---@param s string String to be trimmed.
---@return string Trimmed string.
local function trim(s)
  return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

--- Checks if the file with name 'name' exists.
---@param name string File name.
---@return boolean Wether the file exists.
local function fileExists(name)
	local f=io.open(name,"r")
	if f~=nil then io.close(f) return true else return false end
end

--- Splits string on delimiter.
---@param s string To split.
---@param delimiter string On what to split on.
---@return table Splitted string.
local function split(s, delimiter)
	local result = {};
	for match in (s..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match);
	end
	return result;
end

--- Returns class name using treesitter.
---@return string Class name of the functino.
local function getClassName()
	local classLine = ts.statusline({type_patterns = {'class'}})
	if classLine == "" then
		return ""
	end

	local class = split(classLine, " ")[2]
	if class:sub(-1) == ":" then
		class = class:sub(0, -2)
	end

	return class
end

local function getFunctionName()
	local lineNumber = unpack(vim.api.nvim_win_get_cursor(0))
	local functionName = vim.fn.getline(lineNumber)

	while functionName:sub(-1) ~= ";" do
		lineNumber = lineNumber + 1
		functionName = functionName .. "\n" .. vim.fn.getline(lineNumber)
	end

	return functionName
end









-----------------------------------
-- CORE FUNCTION FOR DEFINITIONS --
-----------------------------------

-- Creates definition in the source file. Takes care of class scope (if it is a function no scope),
-- default parameters and catches the method / function on multiple lines.
--
---@param promptForSourceFile	boolean Wether to prompt the user for source file.
local function createDefinition(promptForSourceFile)
	local headerFile = vim.api.nvim_buf_get_name(0)
	local functionName = vim.fn.expand("<cword>")
	local sourceFile = ""
	local className = getClassName()
	local line = getFunctionName()

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

	if line:find(" = (.+),") then
		line = line:gsub(" = (.+),", ",")
	end

	if line:find(" = (.+)[)]") then
		line = line:gsub(" = (.+)[)]", ")")
	end

	if className ~= "" then
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

	if not fileExists(sourceFile) then
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







----------------------
-- MAPPED FUNCTIONS --
----------------------

--- Open qt-5 documentation about the word under cursor.
function QtQuerryFinder()
	local address = "https://doc.qt.io/qt-5/" .. vim.fn.expand("<cword>"):lower() .. ".html"
	-- ERROR: open / xdg-open doesn't work for me
	vim.cmd(":!kfmclient openURL " .. address)
end

--- Create Method declaration in source file. Class name is deduced from treesitter.
-- The method or function can be declared on multiple lines.
-- Default parameters are removed.
--
---@param sourceFilePrompt boolean Wether to ask for a source file name.
function CreateClassMethodDefinition(sourceFilePrompt)
	createDefinition(sourceFilePrompt)
end


------------------------------
-- OPTIONS FOR KEY MAPPINGS --
------------------------------

local opts = { noremap = true, silent = true }
-- local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>sh", ":ClangdSwitchSourceHeader<CR>", opts)
keymap("n", "<F2>", ":lua QtQuerryFinder()<CR>", opts)
keymap("n", "<F3>", ":lua CreateClassMethodDefinition()<CR>", opts)

