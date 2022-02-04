local colorscheme = "tokyonight"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end

vim.cmd "let g:tokyonight_disable_italic_comment = 0"
vim.cmd "let g:tokyonight_style = 'night'"
