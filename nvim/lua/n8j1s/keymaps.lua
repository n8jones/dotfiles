local function n(...)
  vim.keymap.set("n", ...)
end
local function i(...)
  vim.keymap.set("i", ...)
end
local function t(...)
  vim.keymap.set("t", ...)
end

local function toggle_my_terminal()
  local name = 'my_personal_terminal'
  local bn = vim.fn['floaterm#terminal#get_bufnr'](name)
  if bn > -1 then
    vim.cmd.FloatermToggle(name)
  else
    vim.cmd.FloatermNew('--name=' .. name, '--wintype=vsplit', '--width=0.4')
  end
end

i('jj', "<Esc>")
n('<leader>tf', "<cmd>Telescope find_files<cr>")
n('<leader>tg', "<cmd>Telescope live_grep<cr>")
n('<leader>tb', "<cmd>Telescope buffers<cr>")
n('<leader>th', "<cmd>Telescope help_tags<cr>")
n('<leader>cfs', "<cmd>Telescope lsp_document_symbols<cr>")
n('<leader>cfS', "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>")
n('<leader>cfr', '<cmd>Telescope lsp_references<cr>')
n('<leader>cfi', '<cmd>Telescope lsp_implementations<cr>')
n('<leader>ca', vim.lsp.buf.code_action)
n('<leader>f', '<cmd>FloatermNew --opener=edit lf<cr>')
n('<C-p>', "<cmd>bprevious<cr>")
n('<C-n>', "<cmd>bnext<cr>")
n('<C-d>', '<C-d>zz')
n('<C-u>', '<C-u>zz')
n('n', 'nzz')
n('N', 'Nzz')
n('<C-Space><C-Space>', toggle_my_terminal)
t("<C-Space><C-Space>", "<C-\\><C-n>")
