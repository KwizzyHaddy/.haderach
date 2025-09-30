---@diagnostic disable: undefined-doc-name
return {
	-- gruvbox theme
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },

	--telescope
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	--nvim-treesitter
	{ "nvim-treesitter/nvim-treesitter", branch = "master", lazy = false, build = ":TSUpdate" },

	--neo-tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		lazy = false,
		---@module "neo-tree"
		---@type neotree.Config?
	},

	--mason
	{
		"mason-org/mason.nvim",
		opts = {},
	},

	--mason-lspconfig
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls", "pyright"},
		},
	},

	--nvim-lspconfig
	{ "neovim/nvim-lspconfig" },

	--none-ls
	{ "nvimtools/none-ls.nvim" },

  --alpha
  {"goolord/alpha-nvim"},

  --nvim-cmp
  {"hrsh7th/nvim-cmp"},

  --luasnip
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },

  --cmp-nvim-lsp
  {"hrsh7th/cmp-nvim-lsp"},

  --gitsigns
  {"lewis6991/gitsigns.nvim"},

  --vim-fugitive
  {"tpope/vim-fugitive"},

  --toggleterm
  {"akinsho/toggleterm.nvim"},
}
