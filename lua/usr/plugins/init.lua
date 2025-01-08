-- TODO: https://github.com/nosduco/remote-sshfs.nvim
return {
	"jbyuki/one-small-step-for-vimkind",
	-- NVIM DOCS
	{"folke/neodev.nvim", opts = {}},
	"loichyan/nerdfix",

	-- SPEEDUP
	"lewis6991/impatient.nvim",

	-- ALPHA
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
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
			words = { enabled = false },
		},
	},

	-- PROJECTS
	{
		"LennyPhoenix/project.nvim", -- switch between projects on the system
		branch = "fix-get_clients",
	},

	-- dependencies
	"nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
	"nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
	"Fildo7525/reloader.nvim",

	-- colour scheme
	"sheerun/vim-polyglot",
	{
		"catppuccin/nvim",
		name = "catppuccin",
	},

	-- SCROLLING --
	"lewis6991/satellite.nvim",
	"karb94/neoscroll.nvim",

	-- snippets
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
	},
	"rafamadriz/friendly-snippets", -- a bunch of snippets to use

	-- cmp plugins
	"hrsh7th/nvim-cmp", -- The completion plugin
	"hrsh7th/cmp-buffer", -- buffer completions
	"hrsh7th/cmp-path", -- path completions
	"hrsh7th/cmp-cmdline", -- cmdline completions
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua", -- lua nvim scripting
	{
		"saadparwaiz1/cmp_luasnip", -- snippet completions
		lazy = true,
	},
	"windwp/nvim-autopairs",

	--	LSP
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig", -- enable LSP
	"ray-x/lsp_signature.nvim",
	"nvimtools/none-ls.nvim",
	"antoinemadec/FixCursorHold.nvim", -- This is needed to fix lsp doc highlight
	"lervag/vimtex",

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
		dependencies = { 'nvim-lua/plenary.nvim', 'Fildo7525/reloader.nvim' },
		tag = '0.1.8',
	},
	"BurntSushi/ripgrep",

	-- TERMINAL POPUP WINDOW
	"akinsho/toggleterm.nvim",
	{
		"ckipp01/stylua-nvim",
		build = "cargo install stylua",
	},

	-- TREESITTER
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		lazy = true,
	},

	"HiPhish/rainbow-delimiters.nvim",

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
	"folke/todo-comments.nvim", -- highlight comments like TODO:
	"RRethy/vim-illuminate", -- highlight all occurances of a word under cursor

	-- COMMENTING
	"numToStr/Comment.nvim",
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
	},

	-- GIT
	"lewis6991/gitsigns.nvim",
	"kdheepak/lazygit.nvim",

	-- DAP
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"theHamsta/nvim-dap-virtual-text",
	"nvim-neotest/nvim-nio",

	-- WINBAR
	"Bekaboo/dropbar.nvim",

	"github/copilot.vim",
	"Fildo7525/Revolver",
	{
		"Fildo7525/pretty_hover",
		event = "LspAttach",
		opts = {},
	},

	-- HLS
	{
		"asiryk/auto-hlsearch.nvim",
		opts = {},
	},

	-- INDENT BLANKLINE
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			indent = {
				char = "▏",
				tab_char = "▏"
			},
			scope = {
				show_start = false,
				show_end = false,
				include = { node_type = {
					python = { "if_statement", "elif_statement", "else_clause", "while_statement", "for_statement", "with_statement" },
				}},
			},
		},
	},
}
