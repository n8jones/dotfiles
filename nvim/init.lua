if vim.loader then
    vim.loader.enable()
end
vim.g.mapleader = " "

require("n8j1s.plugins")
require("n8j1s.settings")
require("n8j1s.keymaps")
require("n8j1s.autocmds")

