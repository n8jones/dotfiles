local function format_mins(mins)
  return string.format('%02d:%02d', mins/60, math.fmod(mins, 60))
end

local function extract_tags(name)
  local tags = {}
  local c = 1
  while true do
    local s,e = string.find(name, '@[A-Za-z0-9_]+', c, false)
    if not s then break end
    c = e
    table.insert(tags, string.sub(name, s, e))
  end
  return tags
end

local function timelog_diagnostics(args)
  local regex = vim.regex("- \\d\\d:\\d\\d .*")
  local ns = vim.api.nvim_create_namespace('n8j1s.timelog')
  vim.diagnostic.reset(ns, args.buf)
  local diags = {}
  local add_diag = function (lnum, message)
    table.insert(diags, {
      lnum = lnum,
      col = 0,
      message = message,
      severity = 'Info',
    });
  end
  local line_count = vim.api.nvim_buf_line_count(args.buf)
  local last_task = nil
  local total_mins = 0
  local tag_totals = {}
  local last_line = nil
  for i = 0, line_count-1, 1
  do
    local match = regex:match_line(args.buf, i)
    if match then
      last_line = i
      local line = vim.api.nvim_buf_get_lines(args.buf, i, i+1, true)[1]
      local hours = tonumber(string.sub(line, 3, 4))
      local minutes = tonumber(string.sub(line, 6, 7))
      local name = string.sub(line, 9, -1)
      local current_task = {
        name = name,
        mins = hours * 60 + minutes,
        lnum = i,
        tags = extract_tags(name),
      }
      if last_task then
        local diff_min = current_task.mins - last_task.mins
        total_mins = total_mins + diff_min
        for _, tag in ipairs(last_task.tags) do
          local prev = tag_totals[tag]
          if not prev then prev = 0 end
          tag_totals[tag] = prev + diff_min
        end
        add_diag(last_task.lnum, format_mins(diff_min) .. ' ' .. vim.inspect(last_task.tags))
      end
      if string.find(current_task.name, '/', 1) then
        last_task = nil
      else
        last_task = current_task
      end
    end
  end
  if last_line then
    local msg = 'Total: ' .. format_mins(total_mins)
    for tag, mins in pairs(tag_totals) do
      msg = msg .. string.format(' %s: %s', tag, format_mins(mins))
    end
    add_diag(last_line + 1, msg)
  end
  vim.diagnostic.set(ns, args.buf, diags)
end

local function on_note_save(args)
  if vim.fn.filereadable('.notebook')~=1 then
    return
  end
  vim.cmd.Git { 'add "' .. args.file .. '"', mods = { silent = true } }
  vim.cmd.Git { 'commit -m "On save ' .. args.file .. '"', mods = { silent = true } }
end

local grp = vim.api.nvim_create_augroup('n8j1s', { clear = true })

vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufEnter', 'TextChanged' }, { group = grp, callback = timelog_diagnostics, pattern = {'*.md'} })
vim.api.nvim_create_autocmd('BufWritePost', { group = grp, callback = on_note_save, pattern = {'*.md'} })
vim.api.nvim_create_autocmd('TextYankPost', { group = grp, callback = function() vim.highlight.on_yank() end })
vim.api.nvim_create_autocmd('CursorHold', { group = grp, callback = function()
  vim.diagnostic.open_float()
end })

