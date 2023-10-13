local jdtls_bin = vim.fn.stdpath("data") .. "/mason/bin/jdtls"
local rootDir = vim.fs.dirname(vim.fs.find({'settings.gradle', '.git'}, { upward = true })[1])
local wsDir = vim.fn.getenv('JDTLS_WORKSPACE')
if (wsDir == vim.NIL or string.len(wsDir) == 0) then
  wsDir = rootDir .. '/../.workspace/' .. vim.fs.basename(rootDir) .. '.workspace'
end
require('jdtls').start_or_attach({
  root_dir = rootDir,
  cmd = {
    jdtls_bin,
    '-data',
    wsDir,
  },
  settings = {
    java = {
      signatureHelp = { enabled = true },
      completion = {
        favoriteStaticMembers = {},
        filteredTypes = {
          "com.sun.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
        importOrder = {""},
      },
    }
  },
  on_attach = function(_, _)
    require('jdtls.setup').add_commands()
  end,
})
vim.bo.expandtab = false
