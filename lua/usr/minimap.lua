local status, map = pcall(require, "minimap")
if status then
	vim.notify("Minimap is not installed")
end

vim.cmd [[ 
	let g:minimap_width = 10
	let g:minimap_auto_start = 1
	let g:minimap_auto_start_win_enter = 1
]]

