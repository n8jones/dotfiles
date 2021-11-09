local lspconfig = require'lspconfig'
local system_name

if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system")
end

local cmp = require'cmp'
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp', priority = 100 },
    { name = 'buffer', priority = 75 },
    { name = 'path' },
    { name = 'cmdline' },
    { name = 'calc' },
    { name = 'emoji', opts= {insert = true } },
  })
})

local my_on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

local sumneko_root_path = vim.fn.expand('$HOME/dev/3rdparty/lua-language-server')
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
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
  on_attach = my_on_attach
}

lspconfig.jdtls.setup {
  cmd = {
    --util.path.join(tostring(vim.fn.getenv 'JAVA_HOME'), '/bin/java'),
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '-Xmx2G',
    '-jar',
    tostring(vim.fn.getenv 'JDTLS_JAR'),
    '-configuration',
    tostring(vim.fn.getenv 'JDTLS_CONFIG'),
    '-data',
    tostring(vim.fn.getenv 'JDTLS_WORKSPACE'),
    '--add-modules=ALL-SYSTEM',
    '--add-opens java.base/java.util=ALL-UNNAMED',
    '--add-opens java.base/java.lang=ALL-UNNAMED',
  },
  on_attach = my_on_attach
}

--[[ Groovyls is not ready for primetime, but keeping the config to try out in the future
lspconfig.groovyls.setup {
  cmd = {
    'java',
    '-jar',
    tostring(vim.fn.getenv 'GROOVYLS_JAR')
  },
  on_attach = my_on_attach
}
]]--

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
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
