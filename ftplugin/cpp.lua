----------------------
-- HELPER FUNCTIONS --
----------------------

--- Checks if the file with name 'name' exists.
---@param name string File name.
---@return boolean Wether the file exists.
local function fileExists(name)
	local f = io.open(name,"r")

	if f ~= nil then
		io.close(f)
		return true
	end

	return false
end

local function findCandidates(headerDir, baseName, extensions)
	local candidates = {}
	local rootMarkers = { ".git", "CMakeLists.txt", "Makefile", ".build", "build" }
	local rootDir = vim.fs.root(0, rootMarkers)
	local searchRoot = (rootDir and rootDir ~= "") and rootDir or "/"

	for _, ext in ipairs(extensions) do
		local target = baseName .. ext
		-- Use 'fd' if available, otherwise find
		local cmd
		if vim.fn.executable("fd") == 1 then
			cmd = string.format("fd --type=f -g '%s' '%s' 2>/dev/null", target, searchRoot)
		else
			cmd = string.format("find '%s' -type f -name '%s' 2>/dev/null", searchRoot, target)
		end

		local results = vim.fn.systemlist(cmd)
		for _, path in ipairs(results) do
			if path ~= "" then
				table.insert(candidates, path)
			end
		end
	end

	vim.list.unique(candidates)
	return candidates
end


local function getSourceFile(headerFile)
	local baseName = vim.fn.fnamemodify(headerFile, ":t:r") -- filename without extension
	local headerDir = vim.fn.fnamemodify(headerFile, ":h")	-- directory of header
	local extensions = { ".cpp", ".c" }
	local candidates = findCandidates(headerDir, baseName, extensions)

	for i = #candidates, 1, -1 do
		if not fileExists(candidates[i]) then
			vim.fn.remove(candidates, i)
		end
	end

	if #candidates == 0 then
		return nil
	end
	return candidates[1]
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
	local sourceFile

	if promptForSourceFile then
		sourceFile = vim.fn.input("Source file", headerFile)
	else
		sourceFile = getSourceFile(headerFile)
		if not sourceFile then
			return vim.notify("Could not find source file for header " .. headerFile, vim.log.levels.ERROR)
		end
	end

	local currentNode = vim.treesitter.get_node()
	if currentNode == nil then
		vim.treesitter.get_parser(0):parse()
		currentNode = vim.treesitter.get_node()
		vim.notify("Current node is NIL", vim.log.levels.ERROR)
	end

	local functionInfo = nil
	local parts = {}

	while currentNode ~= nil do
		local type = currentNode:type()
		if (type == 'field_declaration' or type == 'function_definition' or type == 'declaration') and not functionInfo then
			functionInfo = { return_type = '', declaration = nil }
			for node, name in currentNode:iter_children() do
				if node:named() then
					if name == 'type' then
						functionInfo.return_type = vim.treesitter.get_node_text(node, 0)
					elseif name == 'declarator' then
						functionInfo.declaration = vim.treesitter.get_node_text(node, 0)
					end
				end
			end
		elseif type == 'struct_specifier' or type == 'class_specifier' or type == 'namespace_definition' then
			if not functionInfo then
				-- no function found
				return ''
			end
			for node, name in currentNode:iter_children() do
				if node:named() then
					if name == 'name' then
						table.insert(parts, 1, vim.treesitter.get_node_text(node, 0))
					end
				end
			end
		end
		currentNode = currentNode:parent()
	end

	if not functionInfo then
		return ''
	end
	-- is not the destructor and the return type is a pointer of a reference
	local found, _, prefix, name = functionInfo.declaration:find('^(%W+)%s*(%w.*)')
	if found and prefix ~= '~' then
		functionInfo.return_type = functionInfo.return_type .. prefix
		functionInfo.declaration = name
	end

	local specifier = table.concat(parts, '::')

	if specifier:len() > 0 then
		specifier = specifier .. '::' .. functionInfo.declaration
	else
		specifier = functionInfo.declaration
	end

	if functionInfo.return_type:len() > 0 then
		functionInfo.return_type = functionInfo.return_type .. ' '
	end

	local def = string.format("%s%s", functionInfo.return_type, specifier)

	if def:find(" = (.+),") then
		def = def:gsub(" = (.+),", ",")
	end

	if def:find(" = (.+)[)]") then
		def = def:gsub(" = (.+)[)]", ")")
	end

	-- remove override and multiple spaces
	def = def:gsub("^(.+)%)(.*)override(.*)", "%1)%2 %3"):gsub("%s+", " ")

	local definition = { "", def, "{", "", "}" }
	local sourceBufNr = vim.fn.bufnr(sourceFile)
	if sourceBufNr == -1 then
		vim.cmd("edit " .. sourceFile)
		sourceBufNr = vim.fn.bufnr(sourceFile)
	end

	vim.fn.bufload(sourceBufNr)
	vim.fn.appendbufline(sourceBufNr, "$", definition)

	local source_lines = vim.api.nvim_buf_get_lines(sourceBufNr, 0, -1, true)
	local line = #source_lines - 1
	local character = string.len(source_lines[line])

	vim.api.nvim_win_set_buf(0, sourceBufNr)
	vim.api.nvim_win_set_cursor(0, {line, character})
end







----------------------
-- MAPPED FUNCTIONS --
----------------------

--- Open qt-5 documentation about the word under cursor.
function QtQuerryFinder()
	local address = "https://doc.qt.io/qt-5/" .. vim.fn.expand("<cword>"):lower() .. ".html"
	vim.cmd(":!open " .. address .. " 2> /dev/null &")
end

local function switch_source_header(bufnr)
	local method_name = 'textDocument/switchSourceHeader'
	local client = vim.lsp.get_clients({ bufnr = bufnr, name = 'clangd' })[1]
	if not client then
		return vim.notify(('method %s is not supported by any servers active on the current buffer'):format(method_name))
	end
	local params = vim.lsp.util.make_text_document_params(bufnr)
	client:request(method_name, params, function(err, result)
		if err then
			error(tostring(err))
		end
		if not result then
			vim.notify('corresponding file cannot be determined')
			return
		end
		vim.cmd.edit(vim.uri_to_fname(result))
	end, bufnr)
end

vim.api.nvim_buf_create_user_command(0, 'LspClangdSwitchSourceHeader', function()
	switch_source_header(0)
end, { desc = 'Switch between source/header' })

------------------------------
-- OPTIONS FOR KEY MAPPINGS --
------------------------------

local opts = { noremap = true, silent = true }
-- local term_opts = { silent = true }

local keymap = vim.keymap.set

keymap("n", "<leader>sh", "<cmd>LspClangdSwitchSourceHeader<CR>", opts)
keymap("n", "<F2>", QtQuerryFinder, opts)
keymap("n", "<leader>md", createDefinition, opts)
keymap("n", "<leader>fo", ":! clang-format -i --style=file:.clang-format %<CR>", opts)
keymap('n', "<leader>cc", require("clang_reloader").reload, opts)

