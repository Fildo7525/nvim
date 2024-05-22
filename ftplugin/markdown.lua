
vim.keymap.set("n", "<leader>mp", function ()
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
end)
