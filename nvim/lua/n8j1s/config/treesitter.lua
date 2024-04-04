local M = {}
function M.config()
  require'nvim-treesitter.configs'.setup {
    ensure_installed = {
      'markdown',
      'markdown_inline',
    },
    highlight = {
      enable = true,
      disable = {
      },
    },
    markdown = {
      enable = true,
    },
    indent = { enable = true },
  }
end
return M
