local status_ok, ts_utils = pcall(require, "nvim-treesitter.ts_utils")
if not status_ok then
	return
end
----------------------
-- HELPER FUNCTIONS --
----------------------

--- Checks if the file with name 'name' exists.
---@param name string File name.
---@return boolean Wether the file exists.
local function fileExists(name)
	local f=io.open(name,"r")
	if f~=nil then io.close(f) return true else return false end
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
	local sourceFile = ""

	if string.sub(headerFile, -1) == "h" then
		sourceFile = string.gsub(headerFile, "[.]%w$","")
	else
		sourceFile = string.gsub(headerFile, "[.]%w%w%w$", "")
	end
	sourceFile = sourceFile .. ".cpp"

	if promptForSourceFile then
		sourceFile = vim.fn.input("Source file", headerFile)
	end

	local current_node = ts_utils.get_node_at_cursor()

	local function_info = nil
	local parts = {}

	while current_node ~= nil do
		local type = current_node:type()
		if (type == 'field_declaration' or type == 'function_definition' or type == 'declaration') and not function_info then
			function_info = { return_type = '', declaration = nil }
			for node, name in current_node:iter_children() do
				if node:named() then
					if name == 'type' then
						function_info.return_type = vim.treesitter.query.get_node_text(node, 0)
					elseif name == 'declarator' then
						function_info.declaration = vim.treesitter.query.get_node_text(node, 0)
					end
				end
			end
		elseif type == 'struct_specifier' or type == 'class_specifier' or type == 'namespace_definition' then
			if not function_info then
				-- no function found
				return ''
			end
			for node, name in current_node:iter_children() do
				if node:named() then
					if name == 'name' then
						table.insert(parts, 1, vim.treesitter.query.get_node_text(node, 0))
					end
				end
			end
		end
		current_node = current_node:parent()
	end

	if not function_info then
		return ''
	end
	-- is not the destructor and the return type is a pointer of a reference
	local found, _, prefix, name = function_info.declaration:find('^(%W+)%s*(%w.*)')
	if found and prefix ~= '~' then
		function_info.return_type = function_info.return_type .. prefix
		function_info.declaration = name
	end

	local specifier = table.concat(parts, '::')

	if specifier:len() > 0 then
		specifier = specifier .. '::' .. function_info.declaration
	else
		specifier = function_info.declaration
	end

	if function_info.return_type:len() > 0 then
		function_info.return_type = function_info.return_type .. ' '
	end

	local definition = string.format("%s%s", function_info.return_type, specifier)

	if definition:find(" = (.+),") then
		definition = definition:gsub(" = (.+),", ",")
	end

	if definition:find(" = (.+)[)]") then
		definition = definition:gsub(" = (.+)[)]", ")")
	end

	-- remove override and multiple spaces
	definition = definition:gsub("^(.+)%)(.*)override(.*)", "%1)%2 %3"):gsub("%s+", " ") .. "\n{\n\n}\n"

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
		out:write(definition, "\n")
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
	vim.cmd(":!brave-browser " .. address)
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
keymap("n", "<F4>", ":lua print(cpp_generate_body())<CR>", opts)

