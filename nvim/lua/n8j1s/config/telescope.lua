local M = {}

function M.config()
  local def_conf = {
    layout_strategy = "flex",
    layout_config = {
      horizontal = {
        width = 0.97,
        height = 0.9,
      },
      vertical = {
        width = 0.97,
        height = 0.9,
      },
    }
  }
  require("telescope").setup {
    defaults = def_conf,
    extensions = {
      ["ui-select"] = {
        def_conf,
      }
    }
  }
  require("telescope").load_extension("ui-select")
end

return M
