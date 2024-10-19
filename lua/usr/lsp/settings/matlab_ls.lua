return {
	cmd = { "matlab-language-server", "--stdio" },
	filetypes = { "matlab" },
	{
		MATLAB = {
			indexWorkspace = false,
			installPath = "",
			matlabConnectionTiming = "onStart",
			telemetry = true
		}
	},
	single_file_support = true,
}
