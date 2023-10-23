local M = {}
function M.config()
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
return M
