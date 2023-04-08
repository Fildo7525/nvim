local M = {}

M.winnr = 0
M.bufnr = 0

local npcall = vim.F.npcall
local api = vim.api

--- Splits a string into a table of strings.
---@param toSplit string String to be split.
---@param separator string|nil The separator. If not defined, the separator is set to "%S+".
---@return table Table of strings split by the separator.
local split = function(toSplit, separator)
	if separator == nil then
		separator = "%S+"
	end

	local chunks = {}
	for substring in toSplit:gmatch(separator) do
		table.insert(chunks, substring)
	end
	return chunks
end

--- Join the elemnets of a table into a string with a delimiter.
---@param tbl table Table to be joined.
---@param delim string Delimiter to be used.
---@return string Joined string.
local jointTable = function(tbl, delim)
	local result = ""
	for idx, chunk in pairs(tbl) do
		result = result .. chunk
		if idx ~= #tbl then
			result = result .. delim
		end
	end
	return result
end

--- Converts a string returned by response.result.contents.value from vim.lsp[textDocument/hover] to markdown.
---@param toConvert string Documentation of the string to be converted.
---@param opts table Table of options to be used for the conversion to the markdown language.
---@return table Converted table of strings from doxygen to markdown.
local convert_to_markdown = function(toConvert, opts)
	local chunks = split(toConvert, "([^\n]*)\n?")
	local result = {}
	local firstParam = true

	for _, chunk in pairs(chunks) do
		if chunk:find("@brief") then
			local tbl = split(chunk)
			table.remove(tbl, 1)
			chunk = jointTable(tbl, " ")
			table.insert(result, opts.brief .. chunk .. opts.brief)
			table.insert(result, "")

		elseif chunk:find("@param") or chunk:find("@see") or chunk:find("@tparam") then
			local tbl = split(chunk)
			tbl[2] = opts.brief .. tbl[2] .. opts.brief
			table.remove(tbl, 1)
			chunk = jointTable(tbl, " ")

			if firstParam and chunk:find("@param") then
				firstParam = false
				table.insert(result, "---")
			end

			table.insert(result, chunk)

		elseif chunk:find("@class") then
			local tbl = split(chunk)
			table.remove(tbl, 1)
			chunk = jointTable(tbl, " ")
			table.insert(result, opts.class .. chunk)

		else
			table.insert(result, chunk)
		end
	end
	return result
end

--- Parses the response from the server and displays the hover information converted to markdown.
---@param opts table|nil Options to be used for the conversion to the markdown language.
M.display_hover = function(opts)
	local util = require('vim.lsp.util')
	local params = util.make_position_params()

	local cbuf = api.nvim_get_current_buf()
	opts = opts or require("usr.lsp.hover.options")

	-- check if this popup is focusable and we need to focus
	if M.winnr ~= 0 then
		if not api.nvim_win_is_valid(M.winnr) then
			M.winnr = 0
			M.bufnr = 0
		else
			api.nvim_set_current_win(M.winnr)
			return
		end
	end

	vim.lsp.buf_request_all(0, 'textDocument/hover', params, function(responses)
		for _, response in pairs(responses) do
			if response.result and response.result.contents then

				local hover_text = response.result.contents.value
				-- Convert Doxygen comments to Markdown format
				local tbl = convert_to_markdown(hover_text, opts)

				local bufnr, winnr = vim.lsp.util.open_floating_preview(tbl, 'markdown', {border = opts.border, focusable = true, focut = true})
				M.bufnr = bufnr
				M.winnr = winnr

				vim.keymap.set('n', 'q', function ()
					api.nvim_win_close(winnr, true)
					M.winnr = 0
					M.bufnr = 0
				end, { buffer = bufnr, silent = true, nowait = true })
			end
		end
	end)
end

return M
