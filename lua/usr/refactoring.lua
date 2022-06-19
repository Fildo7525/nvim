local status_ok, refactor = pcall(require, "refactoring")
if not status_ok then
	return;
end

refactor.setup({
	 -- overriding printf statement for cpp
	printf_statements = {
		-- add a custom printf statement for cpp
		cpp = {
			'std::cout << "%s" << std::endl;'
		}
	},
	-- prompt for return type
	prompt_func_return_type = {
		go = true,
		cpp = true,
		c = true,
		java = true,
	},
	-- prompt for function parameters
	prompt_func_param_type = {
		go = true,
		cpp = true,
		c = true,
		java = true,
	},
})

