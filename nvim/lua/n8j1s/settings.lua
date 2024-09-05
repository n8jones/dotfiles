vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.foldcolumn = "auto:9"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = {
  tab = '» ',
  trail = '~',
  nbsp = '␣',
  eol = '$',
}
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.wrap = true
vim.opt.breakindentopt = 'list:-1'

vim.g.markdown_fenced_languages = {'ps1', 'sql', 'groovy', 'java', 'c', 'cpp'}

vim.diagnostic.config {
  virtual_text = true,
  virtual_lines = false,
}

