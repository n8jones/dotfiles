local M = {}

function M.error(msg)
  vim.notify(msg, vim.log.levels.ERROR)
end

function M.warn(msg)
  vim.notify(msg, vim.log.levels.WARN)
end

function M.info(msg)
  vim.notify(msg, vim.log.levels.INFO)
end

return M
