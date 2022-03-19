require('jdtls').start_or_attach({
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-Xms1g',
    '-Xmx2G',
    '-jar',
    tostring(vim.fn.getenv 'JDTLS_JAR'),
    '-configuration',
    tostring(vim.fn.getenv 'JDTLS_CONFIG'),
    '-data',
    tostring(vim.fn.getenv 'JDTLS_WORKSPACE'),
  },
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  settings = {
    java = {
    }
  },
  on_attach = function(client, bufnr)
    require('jdtls.setup').add_commands()
    require'myluaconfig'.lsp_on_attach(client, bufnr)
  end,
})
