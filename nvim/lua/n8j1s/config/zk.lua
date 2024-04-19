local M = {}

function M.config()
  require("zk").setup({
    picker = "telescope",
    lsp = {
      auto_attach = {
        enabled = false,
      },
    },
  })
  require('lspconfig').zk.setup { }
end

return M
