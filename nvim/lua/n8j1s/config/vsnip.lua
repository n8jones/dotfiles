local M = {}

function M.config()
  vim.g.vsnip_snippet_dir = vim.fn.stdpath('config') .. '/snippets'
end

return M
