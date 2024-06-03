local log = require('n8j1s.log')

local function search_up(node, type)
  if node ~= nil then
    if node:type() == type then
      return node
    else
      return search_up(node:parent(), type)
    end
  end
  return nil
end

local function search_down(root, type)
  local queue = {root}
  while #queue > 0 do
    local node = table.remove(queue, 1)
    if node:type() == type then
      return node
    end
    for child in node:iter_children() do
      table.insert(queue, child)
    end
  end
  return nil
end

local function str_blank(s)
  return s == nil or s == ''
end

local function default_handler(cmd, file_extension, content)
  local fname = vim.fn.tempname() .. '.' ..file_extension
  local file = io.open(fname, "w")
  if file == nil then
    log.error('Failed to write file: ' .. fname)
    return
  end
  file:write(content)
  file:close()
  vim.cmd.FloatermNew {
    '--disposable',
    '--autoclose=0',
    cmd,
    fname
  }
end

local handlers = {}

function handlers.powershell(content)
  default_handler('powershell', 'ps1', content)
end
handlers.ps1 = handlers.powershell

function handlers.groovy(content)
  default_handler('groovy', 'groovy', content)
end

local function get_language(code_block)
  local node = search_down(code_block, 'language')
  if node == nil then
    log.warn('language node not found')
    return
  end
  local text = vim.treesitter.get_node_text(node, 0)
  if str_blank(text) then
    log.warn('language node is empty')
  end
  return text
end

local function get_content(code_block)
  local content = search_down(code_block, 'code_fence_content')
  if content == nil then
    log.error('code_fence_content not found')
    return nil
  end
  local text = vim.treesitter.get_node_text(content, 0)
  if str_blank(text) then
    log.warn('Code fence content is empty')
  end
  return text
end

local M = {}

function M.run_code_block()
  local node = vim.treesitter.get_node()
  if node == nil then
    log.error('Treesitter node not found')
    return
  end
  local code_block = search_up(node, 'fenced_code_block')
  if code_block == nil then
    log.error('Cursor not on fenced_code_block node')
    return
  end
  local language = get_language(code_block)
  local handler = handlers[language]
  if handler == nil then
    log.error('Unsupported language: ' .. language)
    return
  end
  local text = get_content(code_block)
  handler(text)
  log.info('Done')
end

return M
