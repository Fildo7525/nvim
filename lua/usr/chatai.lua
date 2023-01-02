local status, chatgpt = pcall(require, "chatgpt");
if not status then
	vim.notify("ChatGPT is not installed an it will not be set up", vim.log.levels.WARN)
	vim.keymap.del('n', '<leader>gp')
	return
end

chatgpt.setup({
	welcome_message = "What may I help you with?", -- set to "" if you don't like the fancy robot
	loading_text = "loading",
	question_sign = "", -- you can use emoji if you want e.g. 🙂
	answer_sign = "ﮧ", -- 🤖
	max_line_length = 120,
	yank_register = "+",
	chat_layout = {
		relative = "editor",
		position = "50%",
		size = {
			height = "80%",
			width = "80%",
		},
	},
	chat_window = {
		filetype = "chatgpt",
		border = {
			highlight = "FloatBorder",
			style = "rounded",
			text = {
				top = " ChatGPT ",
			},
		},
	},
	chat_input = {
		prompt = "  ",
		border = {
			highlight = "FloatBorder",
			style = "rounded",
			text = {
				top_align = "center",
				top = " Prompt ",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal",
		},
	},
	openai_params = {
		model = "text-davinci-003",
		frequency_penalty = 0,
		presence_penalty = 0,
		max_tokens = 300,
		temperature = 0,
		top_p = 1,
		n = 1,
	},
	openai_edit_params = {
		model = "code-davinci-edit-001",
		temperature = 0,
		top_p = 1,
		n = 1,
	},
	keymaps = {
		close = "<C-c>",
		yank_last = "<C-y>",
		scroll_up = "<C-u>",
		scroll_down = "<C-d>",
	},
})

