return {
	cmd = { "clangd",
			"--background-index",
			"--suggest-missing-includes",
	},
	filetypes = { "c", "cpp", "objc", "objcpp" },
	single_file_support = true,
	init_options = {
		compilationDatabasePath="build",
	},
}
