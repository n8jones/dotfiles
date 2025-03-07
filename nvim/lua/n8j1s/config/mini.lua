local M = {}

local P = {}

P.opts = {
  -- {name, options, function}

  {'basics', {
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
  }},

  {'bracketed'},

  {'clue', nil, function(m) return P.clue_options(m) end},

  {'comment'},

  {'cursorword'},

  {'files', { windows = { preview = true } }},

  {'icons'},

  {'move'},

  {'notify'},

  {'starter', nil, function (starter)
    return {
      items = {
        starter.sections.recent_files(10, true),
        starter.sections.telescope(),
        starter.sections.builtin_actions(),
      }
    }
  end},

  {'statusline'},

  {'surround'},

  {'tabline'},

  {'trailspace'},

  {'visits'},
}

function M.config()
  for _, v in ipairs(P.opts) do
    local m = require('mini.'.. v[1])
    local o
    if #v == 3 then
      o = v[3](m)
    elseif #v == 2 then
      o = v[2]
    else
      o = {}
    end
    m.setup(o)
    vim.notify('Configured mini.' .. v[1], vim.log.levels.TRACE)
  end

  vim.g.minitrailspace_disable = true
end

function P.clue_options(clue)
  return {
    triggers = {
      { mode = 'n', keys = '<Leader>' },
      { mode = 'x', keys = '<Leader>' },
      { mode = 'i', keys = '<C-x>' },
      { mode = 'n', keys = 'g' },
      { mode = 'x', keys = 'g' },
      { mode = 'n', keys = "'" },
      { mode = 'n', keys = '`' },
      { mode = 'x', keys = "'" },
      { mode = 'x', keys = '`' },
      { mode = 'n', keys = '"' },
      { mode = 'x', keys = '"' },
      { mode = 'i', keys = '<C-r>' },
      { mode = 'c', keys = '<C-r>' },
      { mode = 'n', keys = '<C-w>' },
      { mode = 'n', keys = 'z' },
      { mode = 'x', keys = 'z' },
    },

    clues = {
      clue.gen_clues.builtin_completion(),
      clue.gen_clues.g(),
      clue.gen_clues.marks(),
      clue.gen_clues.registers(),
      clue.gen_clues.windows(),
      clue.gen_clues.z(),
    },
  }
end

return M
