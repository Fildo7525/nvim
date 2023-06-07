local ok, dropbar = pcall(require, "dropbar")
if not ok then
	vim.notify("Nvim dropbar is not installed")
	return
end

local icons = require("usr.core.icons")

dropbar.setup{
	general = {
		---@type boolean|fun(buf: integer, win: integer): boolean
		enable = function(buf, win)
			return not vim.api.nvim_win_get_config(win).zindex
				and vim.bo[buf].buftype == ''
				and vim.api.nvim_buf_get_name(buf) ~= ''
				and not vim.wo[win].diff
		end,
		update_events = {
			win = {
				'CursorMoved',
				'CursorMovedI',
				'WinEnter',
				'WinLeave',
				'WinResized',
				'WinScrolled',
			},
			buf = {
				'BufModifiedSet',
				'FileChangedShellPost',
				'TextChanged',
				'TextChangedI',
			},
			global = {
				'DirChanged',
				'VimResized',
			}

		},
	},
	icons = {
		kinds = {
			use_devicons = true,
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
		ui = {
			bar = {
				separator = icons.ui.Separator,
				extends = icons.ui.Extends,
			},
			menu = {
				separator = " ",
				indicator = icons.ui.Indicator,
			},
		},
	},
	bar = {
		---@type dropbar_source_t[]|fun(buf: integer, win: integer): dropbar_source_t[]
		sources = function(_, _)
			local sources = require('dropbar.sources')
			return {
				sources.path,
				{
					get_symbols = function(buf, cursor)
						if vim.bo[buf].ft == 'markdown' then
							return sources.markdown.get_symbols(buf, cursor)
						end
						for _, source in ipairs({
							sources.lsp,
							sources.treesitter,
						}) do
							local symbols = source.get_symbols(buf, cursor)
							if not vim.tbl_isempty(symbols) then
								return symbols
							end
						end
						return {}
					end,
				},
			}
		end,
		padding = {
			left = 1,
			right = 1,
		},
		pick = {
			pivots = 'abcdefghijklmnopqrstuvwxyz',
		},
		truncate = true,
	},
	menu = {
		entry = {
			padding = {
				left = 1,
				right = 1,
			},
		},
		---@type table<string, string|function|table<string, string|function>>
		keymaps = {
			['<LeftMouse>'] = function()
				local api = require('dropbar.api')
				local menu = api.get_current_dropbar_menu()
				if not menu then
					return
				end
				local mouse = vim.fn.getmousepos()
				if mouse.winid ~= menu.win then
					local parent_menu = api.get_dropbar_menu(mouse.winid)
					if parent_menu and parent_menu.sub_menu then
						parent_menu.sub_menu:close()
					end
					if vim.api.nvim_win_is_valid(mouse.winid) then
						vim.api.nvim_set_current_win(mouse.winid)
					end
					return
				end
				menu:click_at({ mouse.line, mouse.column }, nil, 1, 'l')
			end,
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
					menu:close()
					menu = menu.parent_menu
				end
			end,
			['h'] = function ()
				require('dropbar.api').get_current_dropbar_menu():close()
			end
		},
		---@alias dropbar_menu_win_config_opts_t any|fun(menu: dropbar_menu_t):any
		---@type table<string, dropbar_menu_win_config_opts_t>
		---@see vim.api.nvim_open_win
		win_configs = {
			border = 'none',
			style = 'minimal',
			row = function(menu)
				return menu.parent_menu
						and menu.parent_menu.clicked_at
						and menu.parent_menu.clicked_at[1] - vim.fn.line('w0')
					or 1
			end,
			col = function(menu)
				return menu.parent_menu and menu.parent_menu._win_configs.width or 0
			end,
			relative = function(menu)
				return menu.parent_menu and 'win' or 'mouse'
			end,
			win = function(menu)
				return menu.parent_menu and menu.parent_menu.win
			end,
			height = function(menu)
				return math.max(
					1,
					math.min(
						#menu.entries,
						vim.go.pumheight ~= 0 and vim.go.pumheight
							or math.ceil(vim.go.lines / 4)
					)
				)
			end,
			width = function(menu)
				local min_width = vim.go.pumwidth ~= 0 and vim.go.pumwidth or 8
				if vim.tbl_isempty(menu.entries) then
					return min_width
				end
				return math.max(
					min_width,
					math.max(unpack(vim.tbl_map(function(entry)
						return entry:displaywidth()
					end, menu.entries)))
				)
			end,
		},
	},
	sources = {
		path = {
			---@type string|fun(buf: integer): string
			relative_to = function(_)
				return vim.fn.getcwd()
			end,
			---Can be used to filter out files or directories
			---based on their name
			---@type fun(name: string): boolean
			filter = function(_)
				return true
			end,
		},
		treesitter = {
			-- Lua pattern used to extract a short name from the node text
			-- Be aware that the match result must not be nil!
			name_pattern = string.rep('[#~%w%._%->!]*', 4, '%s*'),
			-- The order matters! The first match is used as the type
			-- of the treesitter symbol and used to show the icon
			-- Types listed below must have corresponding icons
			-- in the `icons.kinds.symbols` table for the icon to be shown
			valid_types = {
				'array',
				'boolean',
				'break_statement',
				'call',
				'case_statement',
				'class',
				'constant',
				'constructor',
				'continue_statement',
				'delete',
				'do_statement',
				'enum',
				'enum_member',
				'event',
				'for_statement',
				'function',
				'if_statement',
				'interface',
				'keyword',
				'list',
				'macro',
				'method',
				'module',
				'namespace',
				'null',
				'number',
				'operator',
				'package',
				'property',
				'reference',
				'repeat',
				'scope',
				'specifier',
				'string',
				'struct',
				'switch_statement',
				'type',
				'type_parameter',
				'unit',
				'value',
				'variable',
				'while_statement',
				'declaration',
				'field',
				'identifier',
				'object',
				'statement',
				'text',
			},
		},
		lsp = {
			request = {
				-- Times to retry a request before giving up
				ttl_init = 60,
				interval = 1000, -- in ms
			},
		},
		markdown = {
			parse = {
				-- Number of lines to update when cursor moves out of the parsed range
				look_ahead = 200,
			},
		},
	},
}

