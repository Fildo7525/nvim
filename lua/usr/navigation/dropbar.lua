local ok, dropbar = pcall(require, "dropbar")
if not ok then
	vim.notify("Nvim dropbar is not installed")
	return
end

local utils = require('dropbar.utils')
local icons = require("usr.core.icons")

dropbar.setup{
	icons = {
		kinds = {
			symbols = {
				Array = icons.kind.Array,
				Boolean = icons.kind.Boolean,
				BreakStatement = icons.dap.StepBack,
				Call = icons.kind.Call,
				CaseStatement = icons.kind.Case,
				Class = icons.kind.Class,
				Color = icons.kind.Color,
				Constant = icons.kind.Constant,
				Constructor = icons.kind.Constructor,
				ContinueStatement = icons.kind.Continue,
				Copilot = icons.kind.Copilot,
				Declaration = icons.kind.Declaration,
				Delete = icons.kind.Delete,
				DoStatement = icons.kind.Do,
				Enum = icons.kind.Enum,
				EnumMember = icons.kind.EnumMember,
				Event = icons.kind.Event,
				Field = icons.kind.Field,
				File = icons.kind.File,
				Folder = icons.kind.Folder,
				ForStatement = icons.kind.For,
				Function = icons.kind.Function,
				Identifier = icons.kind.Variable,
				IfStatement = icons.kind.If,
				Interface = icons.kind.Interface,
				Keyword = icons.kind.Keyword,
				List = icons.kind.Array,
				Log = icons.kind.File,
				Lsp = icons.diagnostics.Lsp,
				Macro = icons.kind.Snippet,
				MarkdownH1 = icons.kind.Text,
				MarkdownH2 = icons.kind.Text,
				MarkdownH3 = icons.kind.Text,
				MarkdownH4 = icons.kind.Text,
				MarkdownH5 = icons.kind.Text,
				MarkdownH6 = icons.kind.Text,
				Method = icons.kind.Method,
				Module = icons.kind.Module,
				Namespace = icons.kind.Namespace,
				Null = icons.kind.Null,
				Number = icons.kind.Number,
				Object = icons.kind.Object,
				Operator = icons.kind.Operator,
				Package = icons.kind.Package,
				Property = icons.kind.Property,
				Reference = icons.kind.Reference,
				Regex = icons.kind.Regex,
				Repeat = icons.kind.Repeat,
				Scope = icons.kind.Scope,
				Snippet = icons.kind.Snippet,
				Specifier = icons.kind.Constant,
				Statement = icons.kind.Statement,
				String = icons.kind.String,
				Struct = icons.kind.Struct,
				SwitchStatement = icons.kind.Switch,
				Text = icons.kind.Text,
				Type = icons.kind.Type,
				TypeParameter = icons.kind.TypeParameter,
				Unit = icons.kind.Unit,
				Value = icons.kind.Value,
				Variable = icons.kind.Variable,
				WhileStatement = icons.kind.While,
			},
		},
	},
	menu = {
		---@type table<string, string|function|table<string, string|function>>
		keymaps = {
			['l'] = function()
				local menu = require('dropbar.api').get_current_dropbar_menu()
				if not menu then
					return
				end
				local cursor = vim.api.nvim_win_get_cursor(menu.win)
				local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
				if component then
					menu:click_on(component, nil, 1, 'l')
				end
			end,
			['q'] = function ()
				local menu = require('dropbar.api').get_current_dropbar_menu()
				while menu do
					menu:del()
					menu = menu.prev_menu
				end
			end,
			['h'] = function ()
				require('dropbar.api').get_current_dropbar_menu():del()
			end,
		},
	},
}

