
vim.cmd [[
	augroup reload_cmake
		autocmd!
		autocmd BufWritePost CMakeLists.txt :! cmake -S . -B ./build && cp ./build/compile_commands.json .
	augroup end
]]
