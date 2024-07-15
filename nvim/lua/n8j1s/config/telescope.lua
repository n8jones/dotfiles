local M = {}

function M.config()
  require("telescope").setup {
    defaults = {
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
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {
        }
      }
    }
  }
  require("telescope").load_extension("ui-select")
end

return M
