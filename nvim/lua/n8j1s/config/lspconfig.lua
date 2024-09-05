local M = {}

local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
lsp_capabilities = vim.tbl_deep_extend('keep', lsp_capabilities, require('cmp_nvim_lsp').default_capabilities())
lsp_capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

function M.config()
  local lsp_zero = require('lsp-zero')
  lsp_zero.extend_lspconfig()

  lsp_zero.on_attach(function(_, bufnr)
    local opts = {buffer = bufnr}
    lsp_zero.default_keymaps(opts)
    local km = require('n8j1s.km')
    km.n('<leader>ca', vim.lsp.buf.code_action, opts)
    km.n('gd', vim.lsp.buf.definition, opts)
    km.n('K', vim.lsp.buf.hover, opts);
  end)

  require('mason-lspconfig').setup({
    ensure_installed = {
      'jdtls',
      'lua_ls',
    },
    handlers = {
      lsp_zero.default_setup,
      --jdtls = M.jdtls_setup,
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

function M.jdtls_setup()
  local mason_pkg = require('mason-registry').get_package('jdtls')
  if not mason_pkg:is_installed() then
    print 'jdtls mason package not installed'
    return
  end
  local jdtls_bin = mason_pkg:get_install_path() .. '/jdtls'
  if vim.fn.has('win64') then
    jdtls_bin = jdtls_bin .. '.cmd'
  end
  local rootDir = vim.fs.dirname(vim.fs.find({'settings.gradle', '.git'}, { upward = true })[1])
  if not rootDir then
    rootDir = vim.fn.getcwd()
  end
  local wsDir = vim.fn.getenv('JDTLS_WORKSPACE')
  if (wsDir == vim.NIL or string.len(wsDir) == 0) then
    wsDir = rootDir .. '/../.workspace/' .. vim.fs.basename(rootDir) .. '.workspace'
  end
  require('jdtls').start_or_attach({
    root_dir = rootDir,
    cmd = {
      jdtls_bin,
      '-data',
      wsDir,
    },
    settings = {
      java = {
        signatureHelp = { enabled = true },
        completion = {
          favoriteStaticMembers = {},
          filteredTypes = {
            "com.sun.*",
            "java.awt.*",
            "jdk.*",
            "sun.*",
          },
        },
      }
    },
  })
end

return M
