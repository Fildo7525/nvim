local telescope = require("telescope.builtin")

local M = {}

function M.source_search ()
	telescope.git_files {
		cwd = "./src/",
		use_git_root = false,
		show_untracked = false,
		recurse_submodules = false,
		git_command = {"git","ls-files","--exclude-standard","--cached"},
	}
end

function M.extend_live_grep(search_opened)
	telescope.live_grep {
		grep_open_files = search_opened or false,
		type_filter = "cpp",
		additional_args = {
			"--pretty",
			"--sort path",
		},
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
