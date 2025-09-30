---@diagnostic disable: undefined-global
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-----------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
-----------------------------

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import plugins
		{ import = "plugins" },
	},
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

------------------------------------------------------------
-- Setup dashboard
local alpha = require("alpha")
local dashboard = require("alpha.themes.startify")
dashboard.section.header.val = {
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                     ]],
	[[       ████ ██████           █████      ██                     ]],
	[[      ███████████             █████                             ]],
	[[      █████████ ███████████████████ ███   ███████████   ]],
	[[     █████████  ███    █████████████ █████ ██████████████   ]],
	[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
	[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
	[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                       ]],
}
alpha.setup(dashboard.opts)

-------------------------------------------------------------------------------
-- Configure gruvbox
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

--------------------------------------------------------
-- Configure telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

-----------------------------------------------------------
-- Configure treesitter
require("nvim-treesitter.configs").setup({
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = true },
})

---------------------------------------------
-- Configure Neotree
vim.keymap.set("n", "<leader>n", ":Neotree filesystem reveal left<CR>", {})
vim.keymap.set("n", "<leader>n", ":Neotree toggle<CR>", {})

-----------------------------------------------------------------------------
-- Configure LSPs
vim.keymap.set("n", "Q", vim.lsp.buf.hover, {})
vim.keymap.set("n", "D", vim.lsp.buf.definition, {})
vim.keymap.set({ "n", "v" }, "CA", vim.lsp.buf.code_action, {})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config("lua_ls", {
  capabilites = capabilities
})
vim.lsp.config("pyright", {
  capabilites = capabilities
})
vim.lsp.config("bashls", {
  capabilities = capabilities
})
vim.lsp.enable("lua_ls")
vim.lsp.enable("pyright")
vim.lsp.enable("bashls")
--------------------------------------------------------------
-- Configure none-ls
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.black,
	},
})
vim.keymap.set("n", "F", vim.lsp.buf.format, {})

--------------------------------------------------
-- Configure completions
require("luasnip.loaders.from_vscode").lazy_load() -- luasnip communicating with friendly snippets

local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
		  require('luasnip').lsp_expand(args.body)
		end,
	},
	window = {
	  completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = 'luasnip' },
	}, {
		{ name = "buffer" },
	}),
})

------------------------------
-- Configure gitsigns
require("gitsigns").setup()

------------------------------
-- Configure toggleterm
require("toggleterm").setup{
  size = 10,
  open_mapping = [[<c-/>]],
  direction = "float",
}
