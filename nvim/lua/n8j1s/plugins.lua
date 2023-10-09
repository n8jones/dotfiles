local M = {}

function M.setup()
  vim.print("Setup started")
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

  require("lazy").setup({
    'morhetz/gruvbox',
    'christoomey/vim-tmux-navigator',

    {
      'nvim-telescope/telescope.nvim',
      cmd = 'Telescope',
      dependencies = {
        'nvim-telescope/telescope-fzf-native.nvim',
        'nvim-lua/plenary.nvim'
      }
    },

    'ptzz/lf.vim',
    {
      'tpope/vim-fugitive',
      cmd = 'Git'
    },

    'tpope/vim-surround',
    'voldikss/vim-floaterm',
    {'mickael-menu/zk-nvim',
      config = function()
        require("zk").setup({
          picker = "select",
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
    },

    {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v3.x',
      lazy = true,
      config = false,
      init = function()
        -- Disable automatic setup, we are doing it manually
        vim.g.lsp_zero_extend_cmp = 0
        vim.g.lsp_zero_extend_lspconfig = 0
      end,
    },

    {
      'williamboman/mason.nvim',
      lazy = false,
      config = true,
    },

    -- Autocompletion
    {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {
        {'L3MON4D3/LuaSnip'},
      },
      config = function()
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
          })
        })
      end
    },

    -- LSP
    {
      'neovim/nvim-lspconfig',
      --cmd = {'LspInfo', 'LspInstall', 'LspStart'},
      --event = {'BufReadPre', 'BufNewFile'},
      dependencies = {
        {'hrsh7th/cmp-nvim-lsp'},
        {'williamboman/mason-lspconfig.nvim'},
      },
      config = function()
        -- This is where all the LSP shenanigans will live
        local lsp_zero = require('lsp-zero')
        lsp_zero.extend_lspconfig()

        lsp_zero.on_attach(function(client, bufnr)
          lsp_zero.default_keymaps({buffer = bufnr})
        end)

        require('mason-lspconfig').setup({
          ensure_installed = {'jdtls'},
          handlers = {
            lsp_zero.default_setup,
          }
        })
      end
    },
    'mfussenegger/nvim-jdtls'

  })
end

return M
