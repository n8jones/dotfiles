local M = {}
function M.config()
  local lsp_zero = require('lsp-zero')
  lsp_zero.extend_cmp()

  local cmp = require('cmp')

  cmp.setup({
   snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    formatting = lsp_zero.cmp_format(),
    mapping = cmp.mapping.preset.insert({
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
      ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'path' },
      { name = 'vsnip' },
      { name = 'emoji' },
    }),
  })
end
return M
