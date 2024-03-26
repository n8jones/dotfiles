local function toggle_my_terminal()
  local name = 'my_personal_terminal'
  local bn = vim.fn['floaterm#terminal#get_bufnr'](name)
  if bn > -1 then
    vim.cmd.FloatermToggle(name)
  else
    vim.cmd.FloatermNew('--name=' .. name, '--wintype=vsplit', '--width=0.4')
  end
end

local km = require('n8j1s.km')
km.i('jj', "<Esc>")
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
km.n('<leader>f', '<cmd>FloatermNew --opener=edit lf<cr>')
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

-- Markdown Notebook Keymaps
if require("zk.util").notebook_root(vim.fn.getcwd()) ~= nil then
  local function newNote()
    local cancel_val = '--cancel--'
    local t = vim.fn.input{prompt='Title: ', cancelreturn=cancel_val}
    if t == cancel_val then
      vim.print('Cancel')
    else
      require('zk').new { title = t }
    end
  end

  km.n('<Leader>nj', '<Cmd>ZkNew { dir = "journal" }<CR>')
  km.n('<Leader>ni', '<Cmd>edit index.md<CR>')
  km.n('<Leader>ncc', newNote)
  km.n('<Leader>tf', '<Cmd>ZkNotes { sort = {"modified-"} }<CR>')
end
