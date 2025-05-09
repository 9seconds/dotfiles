-- MCP servers
-- https://github.com/ravitemer/mcphub.nvim

return {
  "ravitemer/mcphub.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "olimorris/codecompanion.nvim",
  },
  cmd = {
    "MCPHub",
  },

  opts = function()
    local config_path = nil

    if vim.uv.fs_stat(vim.g.config_path or "") then
      config_path = vim.g.config_path
    elseif vim.uv.fs_stat(vim.fn.expand("mcpservers.json")) then
      config_path = vim.fn.expand("mcpservers.json")
    end

    return {
      port = vim.g.mcphub_port or 37373,
      config = config_path,
    }
  end,
}
