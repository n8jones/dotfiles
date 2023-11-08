-- Add the key mappings only for Markdown files in a zk notebook.
if require("zk.util").notebook_root(vim.fn.expand('%:p')) ~= nil then
  local function map(...) vim.api.nvim_buf_set_keymap(0, ...) end
  local opts = { noremap=true, silent=false }
  -- Open the link under the caret.
  map("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  -- Create a new note after asking for its title.
  -- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
  map("n", "<leader>zn", "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
  -- Create a new note in the same directory as the current buffer, using the current selection for title.
  map("v", "<leader>znt", ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", opts)
  -- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
  map("v", "<leader>znc", ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
  -- Open notes linking to the current buffer.
  map("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", opts)
  -- Alternative for backlinks using pure LSP and showing the source context.
  --map('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- Open notes linked by the current buffer.
  map("n", "<leader>zl", "<Cmd>ZkLinks<CR>", opts)
  -- Preview a linked note.
  map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- Open the code actions for a visual selection.
  map("v", "<leader>za", ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)
end
local function n(...)
  vim.keymap.set("n", ...)
end
n('<Leader>nj', '<Cmd>ZkNew { dir = "journal" }<CR>')
n('<Leader>ni', '<Cmd>edit index.md<CR>')
local function newNote()
  local cancel_val = '--cancel--'
  local t = vim.fn.input{prompt='Title: ', cancelreturn=cancel_val}
  if t == cancel_val then
    vim.print('Cancel')
  else
    require('zk').new { title = t }
  end
end
n('<Leader>ncc', newNote)

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

n('<Leader>o', newLine)
