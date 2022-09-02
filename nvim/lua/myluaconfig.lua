local M = {}

if vim.fn.has("mac") == 1 then
  M.system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  M.system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  M.system_name = "windows"
else
  print("unsupported system")
end

M.default_sources = {
  { name = 'nvim_lsp', priority = 100 },
  { name = 'buffer', priority = 75 },
  { name = 'path' },
  { name = 'cmdline' },
  { name = 'calc' },
  { name = 'emoji', option = {insert = true } },
}

function M.lsp_on_attach(_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>Telescope lsp_code_actions<CR>', opts)
end

function M.append_array(t1, t2)
  local r = {}
  for _, row in ipairs(t1) do
    table.insert(r, row)
    print(row)
  end
  for _, row in ipairs(t2) do
    table.insert(r, row)
    print(row)
  end
  print(r)
  return r
end

function M.setup()

  local cmp = require'cmp'
  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert({
      -- Your configuration here.
    }),
    sources = cmp.config.sources(M.default_sources)
  })


  local lspconfig = require'lspconfig'
  local sumneko_root_path = vim.fn.expand('$HOME/DEC/dev/3rdparty/lua-language-server')
  local sumneko_binary = sumneko_root_path.."/bin/".. M.system_name .."/lua-language-server"
  lspconfig.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          globals = {'vim'},
        },
        workspace = {
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
        },
        telemetry = { enable = false },
      },
    },
    on_attach = M.lsp_on_attach
  }

  require'nvim-treesitter.configs'.setup {
    ensure_installed = {
      "java",
      "markdown",
      "rust",
      "c",
      "html",
      "json",
      "javascript",
      "lua",
      "vim",
      "yaml"
    },
    highlight = {
      enable = true
    },
    indent = {
      enable = true
    }
  }

  require('telescope').setup {
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = false, -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                         -- the default case_mode is "smart_case"
      }
    }
  }
  -- To get fzf loaded and working with telescope, you need to call
  -- load_extension, somewhere after setup function:
  require('telescope').load_extension('fzf')
end -- setup()

return M
