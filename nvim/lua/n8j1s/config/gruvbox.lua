local M = {}

function M.config()
  vim.opt.background = 'dark'
  vim.g.gruvbox_contrast_dark = 'hard'
  vim.cmd.colorscheme("gruvbox")
end

return M
