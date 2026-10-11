local telescope = require("telescope.builtin")

local M = {}

function M.get_neotree_root()
	local ok, manager = pcall(require, "neo-tree.sources.manager")
	if not package.loaded["neo-tree"] or not ok then
		return vim.fn.getcwd()
	end

	local state = manager.get_state("filesystem")
	if state and state.path then
		local rok, renderer = pcall(require, "neo-tree.ui.renderer")
		if rok and renderer.window_exists(state) then
			return state.path
		end
	end

	return vim.fn.getcwd()
end

function M.find_files(opts)
	opts = opts or {}
	if not opts.cwd then
		opts.cwd = M.get_neotree_root()
	end
	if not opts.prompt_title then
		opts.prompt_title = "Find Files: " .. vim.fn.fnamemodify(opts.cwd, ":~")
	end
	return telescope.find_files(opts)
end


function M.source_search()
	telescope.git_files {
		cwd = "./src/",
		use_git_root = false,
		show_untracked = false,
		recurse_submodules = false,
		git_command = { "git", "ls-files", "--exclude-standard", "--cached" },
	}
end

function M.extend_live_grep(search_opened)
	local cwd = vim.fn.getcwd()
	local dirs = { cwd, cwd .. "/src" }

	telescope.live_grep {
		grep_open_files = search_opened or false,
		search_dirs = dirs,
		disable_coordinates = false,
	}
end

function M.extend_grep_string(search_opened, dir)
	telescope.grep_string {
		cwd = dir or "./src/",
		grep_open_files = search_opened or false,
	}
end

return M
