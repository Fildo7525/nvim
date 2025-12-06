local M = {}

local function switch_source_header(bufnr)
	local method_name = 'textDocument/switchSourceHeader'
	local client = vim.lsp.get_clients({ bufnr = bufnr, name = 'clangd' })[1]
	if not client then
		return vim.notify(('method %s is not supported by any servers active on the current buffer'):format(method_name))
	end
	local params = vim.lsp.util.make_text_document_params(bufnr)
	client:request(method_name, params, function(err, result)
		if err then
			error(tostring(err))
		end
		if not result then
			vim.notify('corresponding file cannot be determined')
			return
		end
		vim.cmd.edit(vim.uri_to_fname(result))
	end, bufnr)
end

function M.setup()
	local severity = vim.diagnostic.severity
	local signs = {
		text = {
			[severity.ERROR] = "",
			[severity.WARN] = "",
			[severity.HINT] = "",
			[severity.INFO] = "",
		},
		numhl = {
			[severity.WARN] = 'WarningMsg',
			[severity.ERROR] = 'ErrorMsg',
			[severity.HINT] = 'MoreMsg',
			[severity.INFO] = 'InfoMsg',
		},
	}

	local config = {
		-- disable virtual text
		virtual_text = false,
		-- show signs
		signs = signs,
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)
end

local function lsp_highlight_document(client)
	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
			augroup lsp_document_highlight
				autocmd! * <buffer>
				autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
				autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			augroup END
		]],
			false
		)
 	end
	local illuminate = require("illuminate")
	illuminate.on_attach(client)
end

--- @param options vim.lsp.LocationOpts
local function filter_duplicates(options)
	local seen = {}
	local filtered = {}

	for _, item in ipairs(options.items) do
		local key = item.filename .. ":" .. item.user_data.range.start.line .. ":" .. item.user_data.range.start.character
		if not seen[key] then
			table.insert(filtered, item)
			seen[key] = true
		end
	end

	options.items = filtered
	vim.fn.setqflist({}, ' ', options)
	vim.cmd.cfirst()
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	local keymap = vim.keymap.set
	keymap("n", "gD", vim.lsp.buf.declaration, opts)
	keymap("n", "gd", function(_) vim.lsp.buf.definition({on_list=filter_duplicates}) end, opts)

	keymap("n", "K", require('pretty_hover').hover, opts)
	keymap("n", "gi", vim.lsp.buf.implementation, opts)
	keymap("n", "<M-k>",vim.lsp.buf.signature_help, opts)
	keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
	keymap("n", "gr", vim.lsp.buf.references, opts)
	keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	keymap("n", "<leader>qf", function(_) vim.lsp.buf.code_action({only="quickfix"}) end, opts)
	keymap("n", "[d", function(_) vim.diagnostic.jump({ count=-1, float = true }) end, opts)
	keymap("n", "<leader>ih", function(_) vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, opts)
	keymap("n", "gl", function(_) vim.diagnostic.open_float(nil, {focus=false}) end, opts)
	keymap("n", "]d", function(_) vim.diagnostic.jump({ count=1, float = true }) end, opts)
	keymap("n", "<M-d>", vim.diagnostic.setloclist, opts)
	-- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format({ async = true })' ]]
	--[[ vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>fo", "<cmd>Format<CR>", opts) ]]
end

function M.reload_buf_lsp_servers()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	local client_names = {}

	for _, client in pairs(clients) do
		table.insert(client_names, client.config.name)
		client:stop()
	end

	vim.defer_fn(function()
		for _, name in pairs(client_names) do
			local config = vim.lsp.config[name]
			if not config then
				goto continue
			end

			vim.lsp.start(config)
			::continue::
		end
	end, 200)
end

function M.on_attach(client, bufnr)
	if client.name == "tsserver" then -- or client.name == "jdt.ls" then
		client.server_capabilities.document_formatting = false
	end
	if client.name == "clangd" then
		client.server_capabilities.document_formatting = false

		vim.api.nvim_buf_create_user_command(0, 'LspClangdSwitchSourceHeader', function()
			switch_source_header(0)
		end, { desc = 'Switch between source/header' })
	end

	vim.api.nvim_create_user_command("LspBufReload", M.reload_buf_lsp_servers, { desc = "Reload LSP servers for current buffer" })

	-- if client.name == "jdt.ls" then
	--	require("jdtls").setup_dap { hotcoderpalce = "auto" }
	--	require("jdtls.dap").setup_dap_main_class_configs();
	-- end
	-- vim.print("LSP client attached: " .. client.name)
	lsp_keymaps(bufnr)
	lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true;

local cmp_nvim_lsp = require("cmp_nvim_lsp")

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M

