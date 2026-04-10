--- different lint stuff

local M = {
  configs = {
    ["json"] = { "jsonlint", "json_tool" },
    ["bash"] = { "shellcheck", "bash" },
    ["sh"] = { "shellcheck" },
    ["git"] = { "gitlint" },
    ["fish"] = { "fish" },
  },
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
