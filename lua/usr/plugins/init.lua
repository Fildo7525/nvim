-- TODO: https://github.com/nosduco/remote-sshfs.nvim
return {
	"jbyuki/one-small-step-for-vimkind",
	-- NVIM DOCS
	{"folke/neodev.nvim", opts = {}},
	"loichyan/nerdfix",

	-- SPEEDUP
	"lewis6991/impatient.nvim",

	-- ALPHA
	"goolord/alpha-nvim",

	-- PROJECTS
	"ahmedkhalf/project.nvim", -- switch between projects on the system

	-- dependencies
	"nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
	"nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
	"Fildo7525/reloader.nvim",

	-- colour scheme
	"ghifarit53/tokyonight-vim", -- colour scheme
	"sheerun/vim-polyglot",
	{
		"catppuccin/nvim",
		name = "catppuccin",
	},

	-- SCROLLING --
	"lewis6991/satellite.nvim",
	"karb94/neoscroll.nvim",

	-- snippets
	"L3MON4D3/LuaSnip", --snippet engine
	"rafamadriz/friendly-snippets", -- a bunch of snippets to use

	-- cmp plugins
	"hrsh7th/nvim-cmp", -- The completion plugin
	"hrsh7th/cmp-buffer", -- buffer completions
	"hrsh7th/cmp-path", -- path completions
	"hrsh7th/cmp-cmdline", -- cmdline completions
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua", -- lua nvim scripting
	"saadparwaiz1/cmp_luasnip", -- snippet completions
	"windwp/nvim-autopairs",

	--	LSP
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig", -- enable LSP
	"williamboman/nvim-lsp-installer",
	"ray-x/lsp_signature.nvim",
	"jose-elias-alvarez/null-ls.nvim",
	"antoinemadec/FixCursorHold.nvim", -- This is needed to fix lsp doc highlight
	"lervag/vimtex",
	{
		"folke/trouble.nvim",
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
	},
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		}
	},

	-- LUALINE & BUFFLINE
	"nvim-lualine/lualine.nvim",
	{
		'akinsho/bufferline.nvim',
		version = "*"
	},
	"famiu/bufdelete.nvim",

	-- DEVICONS and NVIM-TREE
	"ryanoasis/vim-devicons",
	{
		"kyazdani42/nvim-web-devicons",
		tag = "nerd-v2-compat",
	},
	"kyazdani42/nvim-tree.lua",

	-- TELESCOPE
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.4',
		dependencies = { 'nvim-lua/plenary.nvim', 'Fildo7525/reloader.nvim' },
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
	},

	-- TREESITTER PLUGINS
	{
		"mrjones2014/nvim-ts-rainbow",
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
		},
	},
	{
		'nvim-treesitter/nvim-treesitter-context',
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
		},
	},

	-- DOXYGEN
	{
		"danymat/neogen",
		opts = {},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		version = "*"
	},
	"folke/todo-comments.nvim", -- highlight comments like TODO:
	"RRethy/vim-illuminate", -- highlight all occurances of a word under cursor

	-- COMMENTING
	"numToStr/Comment.nvim",
	"JoosepAlviste/nvim-ts-context-commentstring",

	-- GIT
	"lewis6991/gitsigns.nvim",
	"kdheepak/lazygit.nvim",

	-- DAP
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"theHamsta/nvim-dap-virtual-text",

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

	-- GRAY OUT UNUSED CODE
	"theHamsta/nvim-semantic-tokens",
}
