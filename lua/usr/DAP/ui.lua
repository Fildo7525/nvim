local dapui = require("dapui")
local icons = require("usr.core.icons")

dapui.setup({
	icons = { expanded = "▾", collapsed = "▸", current_frame = icons.ui.Home },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	-- Expand lines larger than the window
	-- Requires >= 0.7
	expand_lines = vim.fn.has("nvim-0.7") == 1,
	-- Layouts define sections of the screen to place windows.
	-- The position can be "left", "right", "top" or "bottom".
	-- The size specifies the height/width depending on position. It can be an Int
	-- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
	-- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
	-- Elements are the elements shown in the layout (in order).
	-- Layouts are opened in order so that earlier layouts take priority in window sizing.
	layouts = {
		{
			elements = {
			-- Elements can be strings or table with id and size keys.
				{ id = "scopes", size = 0.5 },
				"watches",
				{ id = "breakpoints", size = 0.05},
				{ id = "stacks", size = 0.075 },
			},
			size = 40, -- 40 columns
			position = "left",
		},
		{
			elements = {
				"repl",
				"console",
			},
			size = 0.25, -- 25% of total lines
			position = "bottom",
		},
	},
	controls = {
		-- Requires Neovim nightly (or 0.8 when released)
		enabled = true,
		-- Display controls in this element
		element = "repl",
		icons = {
			pause = icons.dap.pause,
			play =icons.dap.play,
			step_into = icons.dap.stepInto,
			step_over = icons.dap.stepOver,
			step_out = icons.dap.stepOut,
			step_back = icons.dap.stepBack,
			run_last = icons.dap.runLast,
			terminate = icons.dap.terminate,
		},
	},
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
		border = "single", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
	render = {
		max_type_length = nil, -- Can be integer or nil.
		max_value_lines = 100, -- Can be integer or nil.
	}
})

local dap = require("dap")

local keymap = vim.keymap.set

-- INSPECT the variable
keymap('n', '<leader>k', function() require("dapui").eval() end)
keymap('v', '<leader>k', function() require("dapui").eval() end)

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

