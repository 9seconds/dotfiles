--- different lint stuff

local M = {
  configs = {},
}

function M.set(data)
  for k, v in pairs(data) do
    if not M.configs[k] then
      M.configs[k] = {}
    end
    vim.list_extend(M.configs[k], v)
  end
end

return M
