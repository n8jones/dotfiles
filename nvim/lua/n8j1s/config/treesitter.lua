local M = {}
function M.config()
  require'nvim-treesitter.configs'.setup {
    ensure_installed = {
      'markdown',
      'markdown_inline',
      'java',
      'groovy',
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = {
        'markdown',
      },
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
