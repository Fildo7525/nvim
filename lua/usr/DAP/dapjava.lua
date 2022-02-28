local status, dap = pcall(require, 'dap')
if not status then
	vim.notify("Dap is not installed")
	return
end

dap.adapters.java = function(callback)
  -- FIXME:
  -- Here a function needs to trigger the `vscode.java.startDebugSession` LSP command
  -- The response to the command must be the `port` used below
  callback({
	type = 'server';
	host = '127.0.0.1';
	port = vim.fn.input("Enter a port number: ", 'port');
  })
end

dap.configurations.java = {
	 -- You need to extend the classPath to list your dependencies.
	 -- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
	classPaths = {},

	javaExec = "/usr/bin/java",
	mainClass = "com.example.Main",

	-- If using the JDK9+ module system, this needs to be extended
	-- `nvim-jdtls` would automatically populate this property
	modulePaths = {},
	name = "Launch YourClassName",
	request = "launch",
	type = "java"
}

