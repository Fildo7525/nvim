local fn = vim.fn

-- Automatically install packer
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "<SPACE>", "<NOP>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	vim.notify("lazy error")
	return
end


-- Install your plugins here
return lazy.setup({
	-- SPEEDUP
	"lewis6991/impatient.nvim",

	-- ALPHA
	"goolord/alpha-nvim",

	-- PROJECTS
	"ahmedkhalf/project.nvim", -- switch between projects on the system

	-- SHOW INDENTATION
	"lukas-reineke/indent-blankline.nvim",

	-- dependencies
	"nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
	"nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins

	-- colour scheme
	"ghifarit53/tokyonight-vim", -- colour scheme
	"sheerun/vim-polyglot",
	{
		"catppuccin/nvim",
		name = "catppuccin",
	},

	-- SCROLLING --
	{
		"lewis6991/satellite.nvim",
		--[[ commit = "f9d0b08faebe97ccd3822df5d1581b0757c0ca66", ]]
	},
	"karb94/neoscroll.nvim",

	-- snippets
	"L3MON4D3/LuaSnip", --snippet engine
	{
		"rafamadriz/friendly-snippets", -- a bunch of snippets to use
	},

	-- cmp plugins
	"hrsh7th/nvim-cmp", -- The completion plugin
	"hrsh7th/cmp-buffer", -- buffer completions
	"hrsh7th/cmp-path", -- path completions
	"hrsh7th/cmp-cmdline", -- cmdline completions
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua", -- lua nvim scripting
	"saadparwaiz1/cmp_luasnip", -- snippet completions
	"windwp/nvim-autopairs",
	-- show function signature
	"ray-x/lsp_signature.nvim",

	--	LSP
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig", -- enable LSP
	"williamboman/nvim-lsp-installer",
	"mfussenegger/nvim-jdtls",
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
		version = "v2.*"
	},
	"famiu/bufdelete.nvim",

	-- DEVICONS and NVIM-TREE
	"ryanoasis/vim-devicons",
	"kyazdani42/nvim-web-devicons",
	"kyazdani42/nvim-tree.lua",

	-- TELESCOPE
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			"nvim-telescope/telescope-live-grep-args.nvim",
		},
	},
	"BurntSushi/ripgrep",

	-- TERMINAL POPUP WINDOW
	"akinsho/toggleterm.nvim",
	{
		"ckipp01/stylua-nvim",
		build = "cargo install stylua",
	},

	-- treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		commit = "e559b6fb3f1b09d96568705c668abb8c55b7e3e4"
	},
	{
		-- Optional but recommended
		-- 'nvim-treesitter/nvim-treesitter',
		'lewis6991/spellsitter.nvim',
		config = function ()
			require('spellsitter').setup ({
				enable = true,
				debug = false,
			})
		end
	},
	"p00f/nvim-ts-rainbow",
	{
		'nvim-treesitter/nvim-treesitter-context',
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
		},
	},

	-- doxygen
	{
		"danymat/neogen",
		config = function()
			require('neogen').setup {}
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		-- Uncomment next line if you want to follow only stable versions
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

	-- MARKDOWN PREVIEW
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		config = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	-- WINBAR
	"fgheng/winbar.nvim",
	{
		"SmiteshP/nvim-gps",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},

	-- ChatGPT
	{
		"jackMort/ChatGPT.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	"github/copilot.vim",
	"Fildo7525/Revolver",

	-- HLS
	{
		"asiryk/auto-hlsearch.nvim",
		config = function()
			require('auto-hlsearch').setup ()
		end,
	},
	"theHamsta/nvim-semantic-tokens",
})
