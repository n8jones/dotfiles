local M = {}
function M.n(...)
  vim.keymap.set("n", ...)
end
function M.i(...)
  vim.keymap.set("i", ...)
end
function M.s(...)
  vim.keymap.set("s", ...)
end
function M.t(...)
  vim.keymap.set("t", ...)
end
return M
