local function delegate(name)
  return function()
    require('n8j1s.config.' .. name).config()
  end
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath, })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {'aklt/plantuml-syntax'},
  {'echasnovski/mini.nvim', version = '*', config = delegate('mini'), },
  {'folke/zen-mode.nvim', version = '*', opts = { window = { width = 90, }, plugins = { twilight = { enabled = true }, wezterm = { enabled = true, font = '+4' } } } },
  {'folke/twilight.nvim', version = '*', opts = { } },
  {'hiphish/rainbow-delimiters.nvim', version = '*' },
  {'hrsh7th/vim-vsnip', event = "InsertEnter", config = delegate('vsnip'), dependencies = {
    'hrsh7th/vim-vsnip-integ',
    'rafamadriz/friendly-snippets',
  } },
  {'hrsh7th/nvim-cmp', event = 'InsertEnter', config = delegate('cmp'), dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-emoji',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-vsnip',
  } },
  {'kevinhwang91/nvim-ufo', events = "VeryLazy", version = '*', opts = {}, dependencies={{'kevinhwang91/promise-async', version = '*'}}},
  {'lbrayner/vim-rzip', init = function() vim.g.rzipPlugin_extra_ext='*.slx' end},
  {'lewis6991/gitsigns.nvim', version = '*', opts = { }, event = {'BufReadPre', 'BufNewFile'}, },
  {'neovim/nvim-lspconfig', version = '*', cmd = {'LspInfo', 'LspInstall', 'LspStart'}, event = {'BufReadPre', 'BufNewFile'}, config = delegate('lspconfig'), dependencies = {
    {'mfussenegger/nvim-jdtls'},
    {'williamboman/mason-lspconfig.nvim', version = '*'},
  } },
  {'norcalli/nvim-colorizer.lua'},
  {'nvim-telescope/telescope.nvim', version = '*', config = delegate('telescope'), dependencies = {
    {'nvim-telescope/telescope-fzf-native.nvim', build='make'},
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-lua/plenary.nvim',
  } },
  {'nvim-treesitter/nvim-treesitter', config = delegate('treesitter'), version='*', dependencies = {
    'nvim-treesitter/nvim-treesitter-context',
    'tadmccorkle/markdown.nvim',
  } },
  {'olimorris/onedarkpro.nvim', priority = 1000, version='*', init = function() vim.cmd.colorscheme('onedark_dark') end },
  {'stevearc/oil.nvim', version = '*', cmd = {'Oil'}, opts = {keymaps={['<esc><esc>']='actions.close'}}},
  {'tpope/vim-fugitive'},
  {'tpope/vim-sleuth'},
  {'voldikss/vim-floaterm', config = delegate('floaterm')},
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x', lazy = true, config = false, init = delegate('lsp_zero'), },
  {'williamboman/mason.nvim', lazy = false, config = true, version = '*'},
  {'zk-org/zk-nvim', config = delegate('zk') },
  {'https://git.sr.ht/~whynothugo/lsp_lines.nvim', version = '*', opts = {} },
})

