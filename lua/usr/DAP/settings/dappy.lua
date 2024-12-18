local dap = require('dap')

local function getPipenvPath()
	local env = os.getenv('VIRTUAL_ENV')
	if env == nil or #env == 0 then
		return '/usr/bin/python'
	end
	return env .. '/bin/python'
end

local enrich_config = function(config, on_config)
	if not config.pythonPath and not config.python then
		config.pythonPath = getPipenvPath()
	end
	if config.subProcess == nil then
		config.subProcess = false
	end
	on_config(config)
end


function dap.adapters.python(cb, config)
	if config.request == 'attach' then
		---@diagnostic disable-next-line: undefined-field
		local port = (config.connect or config).port
		---@diagnostic disable-next-line: undefined-field
		local host = (config.connect or config).host or '127.0.0.1'
		cb({
			type = 'server',
			port = assert(port, '`connect.port` is required for a python `attach` configuration'),
			host = host,
			enrich_config = enrich_config,
			options = {
				source_filetype = 'python',
			},
		})
	else
		cb({
			type = 'executable',
			command = getPipenvPath(),
			args = { '-m', 'debugpy.adapter' },
			enrich_config = enrich_config,
			options = {
				source_filetype = 'python',
			},
		})
	end
end

dap.configurations.python = {
	{
		-- The first three options are required by nvim-dap
		type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = 'launch';
		name = "Launch file";

		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

		program = "${file}"; -- This configuration will launch the current file if used.
		pythonPath = function()
			-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
			-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
			-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
			return getPipenvPath()
		end;
	},
}
