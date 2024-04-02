local M = {}

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

function M.config()
  local lsp_zero = require('lsp-zero')
  lsp_zero.extend_lspconfig()

  lsp_zero.on_attach(function(_, bufnr)
    lsp_zero.default_keymaps({buffer = bufnr})
    local km = require('n8j1s.km')
    km.n('<leader>ca', vim.lsp.buf.code_action)
    km.n('gd', vim.lsp.buf.definition)
    km.n('K', vim.lsp.buf.hover);
  end)

  require('mason-lspconfig').setup({
    ensure_installed = {
      'jdtls',
      'lua_ls',
    },
    handlers = {
      lsp_zero.default_setup,
      jdtls = lsp_zero.noop, -- delegate to java.lua
      lua_ls = M.lua_ls_setup,
    }
  })
end

function M.lua_ls_setup()
  require('lspconfig').lua_ls.setup({
    capabilities = lsp_capabilities,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT'
        },
        diagnostics = {
          globals = {'vim'},
        },
        workspace = {
          library = {
            vim.env.VIMRUNTIME,
            vim.opt.rtp,
          }
        }
      }
    }
  })
end

return M
