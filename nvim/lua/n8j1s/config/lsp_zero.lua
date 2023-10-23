local M = {}
function M.config()
  -- Disable automatic setup, we are doing it manually
  vim.g.lsp_zero_extend_cmp = 0
  vim.g.lsp_zero_extend_lspconfig = 0
end
return M
