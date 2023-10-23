local M = {}
function M.config()
  require'nvim-treesitter.configs'.setup {
    auto_install = true,
    highlight = {
      enable = true,
      disable = {
        "markdown", -- Use the highlighting from zk plugin
      },
    },
  }
end
return M
