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

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

	keymap(bufnr, "n", "K", "<cmd>lua require('pretty_hover').hover()<CR>", opts)

	keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "<C-M-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	keymap(bufnr, "n", "<leader>qf", "<cmd>lua vim.lsp.buf.code_action({only=\"quickfix\"})<CR>", opts)
	keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
	keymap(bufnr, "n", "<leader>ih", '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>', opts)
	keymap(bufnr, "n", "gl", '<cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>', opts)
	keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
	keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	-- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format({ async = true })' ]]
	--[[ vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>fo", "<cmd>Format<CR>", opts) ]]
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

