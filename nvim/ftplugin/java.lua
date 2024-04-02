local mason_pkg = require('mason-registry').get_package('jdtls')
if not mason_pkg:is_installed() then
  print 'jdtls mason package not installed'
  return
end
local jdtls_bin = mason_pkg:get_install_path() .. '/jdtls'
if vim.fn.has('win64') then
  jdtls_bin = jdtls_bin .. '.cmd'
end
local rootDir = vim.fs.dirname(vim.fs.find({'settings.gradle', '.git'}, { upward = true })[1])
if not rootDir then
  rootDir = vim.fn.getcwd()
end
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
      },
    }
  },
  on_attach = function(_, _)
  end,
})
