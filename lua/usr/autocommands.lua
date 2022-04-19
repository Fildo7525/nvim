
vim.cmd [[
	augroup reload_cmake
		autocmd!
		autocmd BufWritePost CMakeLists.txt :! cmake -S . -B ./build && mv ./build/compile_commands.json .
	augroup end
]]
