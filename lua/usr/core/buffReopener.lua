local M = {}
local saveFile = vim.fn.stdpath("cache") .. "/reopener/"

--- Check if a file or directory exists in this path
--- 
---@param file string File to check
---@return true if the file exists, false/nil otherwise
local function exists(file)
	local ok, err, code = os.rename(file, file)
	if not ok then
		if code == 13 then
			-- Permission denied, but it exists
			return true
		end
	end
	return ok, err
end

--- Check if a directory exists in this path
--- 
---@param path string Path to check
---@return true if the directory exists, false/nil otherwise
local function isdir(path)
	-- "/" works on both Unix and Windows
	return exists(path.."/")
end

local function ignoreLetters( c )
  return (c:gsub("['/.']+", ""))
end

--- Get the project name
--- 
---@return string The project name
M.project = function()
	return ignoreLetters(vim.fn.getcwd()) .. ".list"
end

--- Creates file and the required directories.
--- 
---@param mode string In which the file should be opened.
---@return file*? Opened file
local function createFile(mode)
	if not isdir(saveFile) then
		os.execute("mkdir -p " .. saveFile)
	end
	vim.notify("Creating file " .. saveFile .. M.project(), vim.log.levels.INFO)
	return io.open(saveFile .. M.project(), mode)
end

--- Writes data to a file only if the file exists.
--- 
---@param file file*? Where to write.
---@param data string What to write.
local function writeFile(file, data)
	if file then
		file:write(data .. "\n")
	else
		vim.notify("Could not write \"" .. data .. "\" to a file\n", vim.log.levels.ERROR)
	end
end

-- Read a line from the file. Only if exists.
--- 
---@param file file*? from where to write
local function readLine(file)
	if file then
		return file:read("l")
	else
		vim.notify("Could not read from the file", vim.log.levels.ERROR)
		return nil
	end
end

--- Saves opened files to a file. Files are representations of projects.
-- If two projects have the same name of the last directory. The newer save overwrites the older one.
---@return table string Table of strings of opened files
M.SaveOpenedFiles = function ()
	local blist = vim.fn.getbufinfo({ buflisted = 1, bufloaded = 1 })
	local file = createFile("w")
	if not file then
		vim.notify("Could not create file " .. saveFile .. M.project(),vim.log.levels.ERROR)
	else
		vim.notify("File created " .. saveFile .. M.project(), vim.log.levels.INFO)
	end
	local result = {}

	writeFile(file, vim.fn.getcwd())

	for k,item in ipairs(blist) do
		if item.name then
			writeFile(file, item.name)
			result[k] = item.name
		end
	end
	if file ~= nil then
		file:close()
	end
	return result
end

--- Opens the files from the saved file.
---@return boolean true on success
M.OpenSavedFiles = function ()
	local file = io.open(saveFile .. M.project(), "r")
	if not file then
		vim.notify("Could not open file " .. saveFile .. M.project(), vim.log.levels.ERROR)
		return false
	end
	-- workspace location. Currently unused
---@diagnostic disable-next-line: unused-local
	local wd = readLine(file)
	local files = 0
	while true do
		local line = readLine(file)
		if not line then
			break
		end
		vim.cmd("e " .. line)
		files = files + 1
	end
	file:close()
	vim.fn.delete(saveFile .. M.project())
	return true
end

return M

