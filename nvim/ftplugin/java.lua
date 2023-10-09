local install_path = require('mason-registry').get_package('jdtls'):get_installed_path()
require('jdtls').start_or_attach({
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  cmd = {
    install_path .. '/bin/jdtls',
    '-data',
    tostring(vim.fn.getenv 'JDTLS_WORKSPACE'),
  },
  on_attach = function(client, bufnr)
    require('jdtls.setup').add_commands()
    --require'myluaconfig'.lsp_on_attach(client, bufnr)
  end,
})
