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
  {'folke/which-key.nvim', event = "VeryLazy", opts = { } },
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
  {'morhetz/gruvbox', config = delegate('gruvbox'), priority = 1000, lazy = false},
  {'neovim/nvim-lspconfig', cmd = {'LspInfo', 'LspInstall', 'LspStart'}, event = {'BufReadPre', 'BufNewFile'}, config = delegate('lspconfig'), dependencies = {
    {'mfussenegger/nvim-jdtls'},
    {'williamboman/mason-lspconfig.nvim', version = '*'},
  } },
  {'nvim-telescope/telescope.nvim', dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
    'nvim-lua/plenary.nvim',
  } },
  {'nvim-treesitter/nvim-treesitter', config = delegate('treesitter'), version='*', dependencies = {
    'nvim-treesitter/nvim-treesitter-context',
  } },
  {'tadmccorkle/markdown.nvim', ft = 'markdown', opts = { } },
  {'tpope/vim-fugitive'},
  {'tpope/vim-surround'},
  {'voldikss/vim-floaterm', config = delegate('floaterm')},
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x', lazy = true, config = false, init = delegate('lsp_zero'), },
  {'williamboman/mason.nvim', lazy = false, config = true, version = '*'},
})

