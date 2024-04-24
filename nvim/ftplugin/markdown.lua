local function my_match(str, regex, ctx)
ctx.match = string.match(str, regex)
  return ctx.match ~= nil
end

local function newLine()
  local line_number = vim.fn.line(".")
  local line = vim.api.nvim_get_current_line()
  local prefix = nil
  local ctx = {}
  if my_match(line, '^- %d%d:%d%d ', ctx) then
    prefix = '- ' .. os.date("%H:%M") .. ' '
  elseif my_match(line, '^%w*- ', ctx)  then
    prefix = ctx.match
  end
  if prefix then
    vim.fn.append(line_number, prefix)
    vim.fn.cursor(line_number + 1, #prefix)
    vim.cmd('startinsert!')
  end
end

local km = require('n8j1s.km')
km.n('<Leader>o', newLine)
vim.bo.formatlistpat = "^\\s*\\(\\-\\|\\*\\|\\d\\+\\.\\) "

