local M = {}
function M.config()
  require'nvim-treesitter.configs'.setup {
    auto_install = true,
    highlight = {
      enable = true,
      disable = {
      },
    },
    indent = { enable = true },
  }
end
return M
