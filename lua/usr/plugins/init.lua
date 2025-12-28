-- TODO: https://github.com/nosduco/remote-sshfs.nvim
return {
	-- NVIM DOCS
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
					 -- Library paths can be absolute
				"~/projects/my-awesome-lib",
				-- Or relative, which means they will be resolved from the plugin dir.
				"lazy.nvim",
				-- It can also be a table with trigger words / mods
				-- Only load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				-- always load the LazyVim library
				"LazyVim",
				-- Only load the lazyvim library when the `LazyVim` global is found
				{ path = "LazyVim", words = { "LazyVim" } },
				-- Load the wezterm types when the `wezterm` module is required
				-- Needs `justinsgithub/wezterm-types` to be installed
				{ path = "wezterm-types", mods = { "wezterm" } },
				-- Load the xmake types when opening file named `xmake.lua`
				-- Needs `LelouchHe/xmake-luals-addon` to be installed
				{ path = "xmake-luals-addon/library", files = { "xmake.lua" } },
			},
			-- always enable unless `vim.g.lazydev_enabled = false`
			-- This is the default
			---@type boolean|(fun(root:string):boolean?)
			enabled = function(root_dir)
				return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
			end,
		},
		lazy = true,
	},
	"loichyan/nerdfix",

	-- SPEEDUP
	"lewis6991/impatient.nvim",

	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			bigfile = { enabled = true },
			dashboard = require("usr.snacks.dashboard"),
			indent = { enabled = false },
			input = { enabled = false },
			notifier = { enabled = false },
			quickfile = { enabled = true },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
			words = { enabled = false },
		},
	},

	-- PROJECTS
	{
		"DrKJeff16/project.nvim", -- switch between projects on the system
		dependencies = { -- OPTIONAL
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope.nvim',
		},

		opts = { },
		cond = vim.fn.has('nvim-0.11') == 1, -- RECOMMENDED
	},

	-- dependencies
	"nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
	"nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
	{
		"Fildo7525/reloader.nvim",
		event = "LspAttach",
		ft = { "cpp", "c", },
		opts = {
			autocomand = {
				enabled = false,
			},
			shorten_paths = true,
		},
	},

	-- colour scheme
	"sheerun/vim-polyglot",
	{
		"catppuccin/nvim",
		name = "catppuccin",
	},

	-- SCROLLING --
	"lewis6991/satellite.nvim",

	-- snippets
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		lazy = true,
	},
	"rafamadriz/friendly-snippets", -- a bunch of snippets to use

	-- cmp plugins
	{
		"hrsh7th/nvim-cmp", -- The completion plugin
		lazy = true,
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		lazy = true,
	},
	{
		'saghen/blink.cmp',
		-- optional: provides snippets for the snippet source
		dependencies = 'rafamadriz/friendly-snippets',

		-- use a release tag to download pre-built binaries
		version = '*',
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		opts = require("usr.lsp.blink"),
		config = function(_, opts)
			local original = require("blink.cmp.completion.list").show

			---@diagnostic disable-next-line: duplicate-set-field
			require("blink.cmp.completion.list").show = function(ctx, items_by_source)
				local seen = {}
				local function filter(item)
					if seen[item.label] then return false end
					seen[item.label] = true
					return true
				end
				for id in vim.iter(opts.sources.priority) do
					items_by_source[id] = items_by_source[id] and vim.iter(items_by_source[id]):filter(filter):totable()
				end
				return original(ctx, items_by_source)
			end
			require("blink.cmp").setup(opts)
		end,
		opts_extend = { "sources.default" },
	},
	{
		"saadparwaiz1/cmp_luasnip", -- snippet completions
		event = "LspAttach",
	},
	"windwp/nvim-autopairs",

	--	LSP
	"mason-org/mason.nvim",
	"mason-org/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig", -- enable LSP
	{
		"nvimtools/none-ls.nvim",
		lazy = true,
	},
	{
		"lervag/vimtex",
		ft = { "tex", "latex" },
		config = function() require("usr.lsp.settings.vimlatex") end,
		lazy = true,
	},

	-- LUALINE & BUFFLINE
	"nvim-lualine/lualine.nvim",
	'akinsho/bufferline.nvim',
	"famiu/bufdelete.nvim",

	-- DEVICONS and NEO-TREE
	"ryanoasis/vim-devicons",
	{
		"kyazdani42/nvim-web-devicons",
		tag = "nerd-v2-compat",
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		}
	},

	-- TELESCOPE
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		tag = '0.1.8',
		lazy = true,
	},

	-- TERMINAL POPUP WINDOW
	"akinsho/toggleterm.nvim",
	{
		"ckipp01/stylua-nvim",
		build = "cargo install stylua",
		lazy = true,
	},

	-- TREESITTER
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		lazy = false,
	},

	{
		"HiPhish/rainbow-delimiters.nvim",
		config = function()
			---@type rainbow_delimiters.config
			vim.g.rainbow_delimiters = {
				strategy = {
					[''] = 'rainbow-delimiters.strategy.global',
					vim = 'rainbow-delimiters.strategy.local',
				},
				query = {
					[''] = 'rainbow-delimiters',
					lua = 'rainbow-blocks',
				},
				priority = {
					[''] = 110,
					lua = 210,
				},
				highlight = {
					'NeogitGraphGray',
					'RainbowDelimiterYellow',
					'RainbowDelimiterBlue',
					'RainbowDelimiterViolet',
					'RainbowDelimiterCyan',
					'RainbowDelimiterOrange',
					'RainbowDelimiterGreen',
					'RainbowDelimiterRed',
				},
			}
		end,
	},

	-- DOXYGEN
	{
		"danymat/neogen",
		opts = {},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		version = "*",
		lazy = true,
	},
	{
		"folke/todo-comments.nvim", -- highlight comments like TODO:
		lazy = true,
	},

	"RRethy/vim-illuminate", -- highlight all occurances of a word under cursor

	-- COMMENTING
	"numToStr/Comment.nvim",

	-- GIT
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
	},

	-- DAP
	{
		"mfussenegger/nvim-dap",
		lazy = true,
	},
	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		lazy = true,
		opts = require("usr.DAP.virtual_text"),
	},
	{
		"nvim-neotest/nvim-nio",
		lazy = true,
	},

	-- WINBAR
	{
		"Bekaboo/dropbar.nvim",
		lazy = true,
	},

	{
		"github/copilot.vim",
		init = function()
			require("usr.copilot");
		end,
		event = "LspAttach",
	},
	{
		"Fildo7525/Revolver",
		event = "LspAttach",
	},
	{
		"Fildo7525/pretty_hover",
		event = "LspAttach",
		opts = {	},
	},

	-- HLS
	{
		"asiryk/auto-hlsearch.nvim",
		opts = {},
	},

	{
		"uga-rosa/ccc.nvim",
		lazy = true,
		opts = function(ccc, opts)
			local M_ccc = require("usr.ccc")
			opts = vim.tbl_deep_extend("force", opts, M_ccc.config())
			return opts
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			-- See Configuration section for options
		},
		-- See Commands section for default commands if you want to lazy load on them
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		ft = { "markdown", "mdx" },
		opts = {
			completions = {
				blink = {
					enabled = true,
				},
			},
			latex = {
				-- Turn on / off latex rendering.
				enabled = true,
				-- Additional modes to render latex.
				render_modes = false,
				-- Executable used to convert latex formula to rendered unicode.
				-- If a list is provided the first command available on the system is used.
				converter = { 'utftex', 'latex2text' },
				-- Highlight for latex blocks.
				highlight = 'RenderMarkdownMath',
				-- Determines where latex formula is rendered relative to block.
				-- | above	| above latex block															 |
				-- | below	| below latex block															 |
				-- | center | centered with latex block (must be single line) |
				position = 'center',
				-- Number of empty lines above latex blocks.
				top_pad = 0,
				-- Number of empty lines below latex blocks.
				bottom_pad = 0,
			},
			render_modes = true,
		},
	},
	{
		"alec-gibson/nvim-tetris",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = {
				show_start = false,
				show_end = false,
			},
			indent = {
				tab_char = "▎",
			},
			exclude = {
				filetypes = {
					"lua",
					"cpp",
				},
			},
		},
		lazy=false,
	},
}
