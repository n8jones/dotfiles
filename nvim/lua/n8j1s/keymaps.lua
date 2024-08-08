local function toggle_my_terminal()
  local name = 'my_personal_terminal'
  local bn = vim.fn['floaterm#terminal#get_bufnr'](name)
  if bn > -1 then
    vim.cmd.FloatermToggle(name)
  else
    vim.cmd.FloatermNew('--name=' .. name, '--wintype=vsplit', '--width=0.4')
  end
end

local function save_source()
  vim.cmd.write()
  vim.cmd.source('%')
end

local function random_string(num)
  local chars = 'abcdefghijklmnopqrstuvwxyz0123456789'
  local str = ''
  for i=1,num do
    local r = math.random(#chars)
    str = str .. string.char(string.byte(chars, r))
  end
  return str
end

local function jump_next()
  if vim.fn['vsnip#jumpable'](1)==1 then
    return '<Plug>(vsnip-jump-next)'
  else
    return '<Tab>'
  end
end

local function jump_back()
  if vim.fn['vsnip#jumpable'](-1)==1 then
    return '<Plug>(vsnip-jump-prev)'
  else
    return '<S-Tab>'
  end
end

local function expand()
  if vim.fn['vsnip#expandable']()==1 then
    return '<Plug>(vsnip-expand)'
  else
    return '<C-e>'
  end
end

local km = require('n8j1s.km')
km.i('jj', "<Esc>")
km.i('<C-e>', expand, { expr = true })
km.s('<C-e>', expand, { expr = true })
km.i('<Tab>', jump_next, { expr = true })
km.s('<Tab>', jump_next, { expr = true })
km.i('<S-Tab>', jump_back, { expr = true })
km.s('<S-Tab>', jump_back, { expr = true })
km.n('<leader>tt', '<cmd>Telescope resume<cr>')
km.n('<leader>tf', "<cmd>Telescope find_files<cr>")
km.n('<leader>tj', "<cmd>Telescope find_files theme=dropdown find_command=rg,--type=java,--files<cr>")
km.n('<leader>ts', function() require'telescope.builtin'.treesitter { symbols={ 'type', 'field', 'method', 'function' } } end)
km.n('<leader>tg', "<cmd>Telescope live_grep<cr>")
km.n('<leader>tb', "<cmd>Telescope buffers<cr>")
km.n('<leader>th', "<cmd>Telescope help_tags<cr>")
km.n('<leader>cfs', "<cmd>Telescope lsp_document_symbols<cr>")
km.n('<leader>cfS', "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>")
km.n('<leader>cfr', '<cmd>Telescope lsp_references<cr>')
km.n('<leader>cfi', '<cmd>Telescope lsp_implementations<cr>')
km.n('<leader>f', function() require('mini.files').open(vim.api.nvim_buf_get_name(0)) end)
km.n('<leader>r', function() require('mini.visits').select_path() end)
km.n('<leader>ss', save_source)
km.n('<C-p>', "<cmd>bprevious<cr>")
km.n('<C-n>', "<cmd>bnext<cr>")
km.n('<C-d>', '<C-d>zz')
km.n('<C-u>', '<C-u>zz')
km.n('n', 'nzz')
km.n('N', 'Nzz')
km.n('<C-Space><C-Space>', toggle_my_terminal)
km.n('<leader><leader>', toggle_my_terminal)
km.t("<C-Space><C-Space>", "<C-\\><C-n>")
km.t("<leader><leader>", "<C-\\><C-n>")
km.n('<Tab>', '>>_')
km.n('<S-Tab>', '<<_')
km.n('[c', function() require('treesitter-context').go_to_context(vim.v.count1) end, { silent = true })

-- Markdown Notebook Keymaps
if vim.fn.filereadable('.notebook')==1 then
  local function new_note()
    local filename = nil
    repeat
      filename = random_string(4) .. '.md'
    until vim.fn.filereadable(filename) == 0
    vim.cmd.edit(filename)
    vim.fn['vsnip#anonymous']('quicknote')
    vim.fn['vsnip#expand']()
  end

  km.n('<Leader>nj', function() vim.cmd.edit('Journal/' .. os.date('%Y-%m-%d') .. '.md') end)
  km.n('<Leader>ni', function() vim.cmd.edit('0000.md') end)
  km.n('<Leader>ncc', new_note)
  km.n('<Leader>tf', '<Cmd>ZkNotes { sort = {"modified-"} }<CR>')
  km.n('<Leader>nt', function() require('zk').edit({tags = {'Task', '-Done'}, sort = {'modified-'} }, {}) end)
  km.n('<Leader>nb', '<Cmd>ZkBacklinks<CR>')
  km.n('<Leader>nl', '<Cmd>ZkLinks<CR>')
end

