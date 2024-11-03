local opts = { noremap = true, silent = true }
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

local function addDictionaryLine()
	local line = vim.fn.input("Enter words in format: 'danish english': ")
	local input = {danish = "", english = ""}
	for d, e in string.gmatch(line, "(%w+) (%w+)") do
		input.danish = d
		input.english = e
	end

	local data = "| [" .. input.danish .. "](https://ordnet.dk/ddo_en/dict?query=" .. input.danish .. ") |  | " .. input.english .. " |  |"
	local lineNo = vim.fn.line('.')
	vim.fn.appendbufline(vim.fn.bufnr(), lineNo, data)
end

keymap("n", "<leader>mp", mdToPdf, opts)
keymap("n", "<C-a>", addDictionaryLine, opts)
