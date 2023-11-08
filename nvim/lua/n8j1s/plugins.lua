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
  {'christoomey/vim-tmux-navigator'},
  {'hrsh7th/vim-vsnip', dependencies = { {'hrsh7th/vim-vsnip-integ'}, {'rafamadriz/friendly-snippets'}, } },
  {'hrsh7th/nvim-cmp', event = 'InsertEnter', dependencies = { {'hrsh7th/cmp-nvim-lsp'}, {'hrsh7th/cmp-buffer'}, {'hrsh7th/cmp-path'}, {'hrsh7th/cmp-cmdline'} }, config = delegate('cmp') },
  {'LukasPietzschmann/telescope-tabs', dependencies = { 'nvim-telescope/telescope.nvim' }, config = delegate('telescope_tabs') },
  {'mfussenegger/nvim-jdtls'},
  {'mickael-menu/zk-nvim', config = delegate('zk') },
  {'morhetz/gruvbox', config = delegate('gruvbox'), priority = 1000, lazy = false},
  {'neovim/nvim-lspconfig', cmd = {'LspInfo', 'LspInstall', 'LspStart'}, event = {'BufReadPre', 'BufNewFile'}, dependencies = { {'hrsh7th/cmp-nvim-lsp'}, {'williamboman/mason-lspconfig.nvim'}, }, config = delegate('lspconfig') },
  {'nvim-telescope/telescope.nvim', dependencies = { 'nvim-telescope/telescope-fzf-native.nvim', 'nvim-lua/plenary.nvim', } },
  {'nvim-treesitter/nvim-treesitter', config = delegate('treesitter') },
  {'ptzz/lf.vim'},
  {'sindrets/diffview.nvim'},
  {'tpope/vim-fugitive'},
  {'tpope/vim-surround'},
  {'voldikss/vim-floaterm', config = delegate('floaterm')},
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x', lazy = true, config = false, init = delegate('lsp_zero'), },
  {'williamboman/mason.nvim', lazy = false, config = true},
})

