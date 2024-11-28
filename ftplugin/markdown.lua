local http = require("socket.http")
local html = require("htmlEntities")

local keymap = vim.keymap.set

local function mdToPdf()
	vim.print("Converting " .. vim.fn.bufname() .. " to pdf")
	local data = io.popen("pandoc -f markdown -t pdf -o " .. vim.fn.expand("%:r") .. ".pdf " .. vim.fn.bufname())
	if data == nil then
		vim.notify("Error converting " .. vim.fn.bufname() .. " to pdf", vim.log.levels.ERROR, {
			title = "Markdown to PDF",
		})
		return
	end

	local output = data:read("*all")
	data:close()

	vim.notify(output, vim.log.levels.WARN, {
		title = "Markdown to PDF",
	})
end

local function scrape_and_find(url)
	-- Make the HTTP request.
	local body, code = http.request(url)

	if code ~= 200 then
		print("Failed to fetch URL: " .. tostring(code))
		return nil
	end

	-- Define a pattern to match UTF-8 characters in braces.
	local utf8_pattern = "</span>([^\\u0000-\\u007F]+)<span class=\"diskret\">"

	-- This is not efficient but otherwise we cannot detect the pronauntiation (udtale).
	body = html.decode(body)

	-- Search for the pattern.
	return body:match(utf8_pattern)
end

local function addDictionaryLine()
	local line = vim.fn.input("Enter words in format: 'danish,english': ")
	local input = {danish = "", english = ""}
	-- This is the way how to capture utf-8 characters. This is needed for æ,ø,å
	for d, e in string.gmatch(line, "([^\r\n]+),([^\r\n]+)") do
		input.danish = d
		input.english = e
	end

	local url = "https://ordnet.dk/ddo_en/dict?query=" .. input.danish
	local pronauntiation = scrape_and_find(url) or ""

	local data = "| [" .. input.danish .. "](" .. url .. ") | [" .. pronauntiation .. "] | " .. input.english .. " |  |"
	local lineNo = vim.fn.line('.')
	vim.fn.appendbufline(vim.fn.bufnr(), lineNo, data)
end

keymap("n", "<leader>mp", mdToPdf)
keymap("n", "<C-z>", addDictionaryLine)
