local jdtls_bin = vim.fn.stdpath("data") .. "/mason/bin/jdtls"
vim.print("jdtls_bin: " .. jdtls_bin)
require('jdtls').start_or_attach({
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  cmd = {
    jdtls_bin,
    '-data',
    tostring(vim.fn.getenv 'JDTLS_WORKSPACE'),
  },
  on_attach = function(client, bufnr)
    require('jdtls.setup').add_commands()
  end,
})
