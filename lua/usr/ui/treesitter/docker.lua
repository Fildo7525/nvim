local M = {}

local ns = vim.api.nvim_create_namespace("compose_dim")

local function define_hl()
	vim.api.nvim_set_hl(0, "ComposeDisabled", { link = "Comment", default = true })
end

local query_src = [[
	(block_mapping_pair
		key: (flow_node) @key
		value: (flow_node) @val
		(#eq? @key "run")
		(#any-of? @val "false" "False" "FALSE" "no" "off")) @pair
]]

local function find_app_node(pair)
	local node = pair:parent()
	while node do
		local t = node:type()
		if t == "block_mapping_pair" or t == "block_sequence_item" then
			return node
		end
		node = node:parent()
	end
end

function M.update(buf)
	buf = buf or vim.api.nvim_get_current_buf()
	if not vim.api.nvim_buf_is_valid(buf) then return end
	vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

	local ok, parser = pcall(vim.treesitter.get_parser, buf, "yaml")
	if not ok or not parser then return end
	local tree = parser:parse()[1]
	if not tree then return end

	local query = vim.treesitter.query.parse("yaml", query_src)
	for id, node in query:iter_captures(tree:root(), buf, 0, -1) do
		if query.captures[id] == "pair" then
			local app = find_app_node(node)
			if app then
				local sr, sc, er, ec = app:range()
				pcall(vim.api.nvim_buf_set_extmark, buf, ns, sr, sc, {
					end_row = er,
					end_col = ec,
					hl_group = "ComposeDisabled",
					priority = 200, -- above treesitter (100) and LSP semantic tokens (125)
				})
			end
		end
	end
end

function M.setup()
	define_hl()
	local group = vim.api.nvim_create_augroup("ComposeDim", { clear = true })

	vim.api.nvim_create_autocmd("ColorScheme", { group = group, callback = define_hl })

	vim.api.nvim_create_autocmd(
		{ "BufEnter", "BufWritePost", "TextChanged", "InsertLeave", "LspAttach" },
		{
			group = group,
			pattern = "*compose-setup.y*ml",
			callback = function(args) M.update(args.buf) end,
		}
	)
end

return M

