local function zk_config()
  require("zk").setup({
    picker = "telescope",
    lsp = {
      config = {
        cmd = { "zk", "lsp" },
        name = "zk",
      },
      auto_attach = {
        enabled = true,
        filetypes = { "markdown" },
      },
    },
  })
end

local function lsp_zero_init()
  -- Disable automatic setup, we are doing it manually
  vim.g.lsp_zero_extend_cmp = 0
  vim.g.lsp_zero_extend_lspconfig = 0
end

local function cmp_config()
  -- Here is where you configure the autocompletion settings.
  local lsp_zero = require('lsp-zero')
  lsp_zero.extend_cmp()

  -- And you can configure cmp even more, if you want to.
  local cmp = require('cmp')
  local cmp_action = lsp_zero.cmp_action()

  cmp.setup({
    formatting = lsp_zero.cmp_format(),
    mapping = cmp.mapping.preset.insert({
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
      ['<C-f>'] = cmp_action.luasnip_jump_forward(),
      ['<C-b>'] = cmp_action.luasnip_jump_backward(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    })
  })
end

local function lspconfig_config()
  local lsp_zero = require('lsp-zero')
  lsp_zero.extend_lspconfig()

  lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({buffer = bufnr})
  end)

  require('mason-lspconfig').setup({
    ensure_installed = {'jdtls'},
    handlers = {
      lsp_zero.default_setup,
      jdtls = lsp_zero.noop, -- delegate to java.lua
    }
  })
end

local function treesitter_config()
  require'nvim-treesitter.configs'.setup {
    auto_install = true,
    highlight = {
      enable = true,
      disable = {
        "markdown", -- Use the highlighting from zk plugin
      },
    },
  }
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath, })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {'christoomey/vim-tmux-navigator'},
  {'hrsh7th/nvim-cmp', event = 'InsertEnter', dependencies = { {'L3MON4D3/LuaSnip'}, }, config = cmp_config },
  {'mfussenegger/nvim-jdtls'},
  {'mickael-menu/zk-nvim', config = zk_config },
  {'morhetz/gruvbox'},
  {'neovim/nvim-lspconfig', cmd = {'LspInfo', 'LspInstall', 'LspStart'}, event = {'BufReadPre', 'BufNewFile'}, dependencies = { {'hrsh7th/cmp-nvim-lsp'}, {'williamboman/mason-lspconfig.nvim'}, }, config = lspconfig_config },
  {'nvim-telescope/telescope.nvim', cmd = 'Telescope', dependencies = { 'nvim-telescope/telescope-fzf-native.nvim', 'nvim-lua/plenary.nvim' } },
  {'nvim-treesitter/nvim-treesitter', config = treesitter_config},
  {'ptzz/lf.vim'},
  {'tpope/vim-fugitive', cmd = 'Git' },
  {'tpope/vim-surround'},
  {'voldikss/vim-floaterm'},
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x', lazy = true, config = false, init = lsp_zero_init, },
  {'williamboman/mason.nvim', lazy = false, config = true},
})

