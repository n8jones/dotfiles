local M = {}

function M.config()

  require('mini.basics').setup {
    options = {
      basic = true,
      extra_ui = true,
      win_borders = 'single',
    },
    mappings = {
      basic = true,
      windows = true,
      move_with_alt = true,
    }
  }

  require('mini.bracketed').setup()

  require('mini.comment').setup()

  require('mini.files').setup()

  require('mini.statusline').setup()

  require('mini.surround').setup()

end

return M
