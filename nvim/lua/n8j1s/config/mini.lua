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

  require('mini.clue').setup(M._mini_clue_config())

  require('mini.comment').setup()

  require('mini.cursorword').setup()

  require('mini.files').setup { windows = { preview = true } }

  require('mini.icons').setup()

  require('mini.move').setup()

  require('mini.notify').setup()

  local starter = require('mini.starter')
  starter.setup {
    items = {
      starter.sections.recent_files(10, true),
      starter.sections.telescope(),
      starter.sections.builtin_actions(),
    }
  }

  require('mini.statusline').setup()

  require('mini.surround').setup()

  require('mini.tabline').setup()

  require('mini.trailspace').setup()
  vim.g.minitrailspace_disable = true

  require('mini.visits').setup()

end

function M._mini_clue_config()
  local miniclue = require('mini.clue')
  return {
    triggers = {
      -- Leader triggers
      { mode = 'n', keys = '<Leader>' },
      { mode = 'x', keys = '<Leader>' },

      -- Built-in completion
      { mode = 'i', keys = '<C-x>' },

      -- `g` key
      { mode = 'n', keys = 'g' },
      { mode = 'x', keys = 'g' },

      -- Marks
      { mode = 'n', keys = "'" },
      { mode = 'n', keys = '`' },
      { mode = 'x', keys = "'" },
      { mode = 'x', keys = '`' },

      -- Registers
      { mode = 'n', keys = '"' },
      { mode = 'x', keys = '"' },
      { mode = 'i', keys = '<C-r>' },
      { mode = 'c', keys = '<C-r>' },

      -- Window commands
      { mode = 'n', keys = '<C-w>' },

      -- `z` key
      { mode = 'n', keys = 'z' },
      { mode = 'x', keys = 'z' },
    },

    clues = {
      -- Enhance this by adding descriptions for <Leader> mapping groups
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows(),
      miniclue.gen_clues.z(),
    },
  }
end

return M
