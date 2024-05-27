-- settings for none-ls
-- https://github.com/nvimtools/none-ls.nvim

local SOURCE_TO_METHODS = {
  code_actions = "CODE_ACTION",
  diagnostics = "DIAGNOSTICS",
  formatting = "FORMATTING",
  hover = "HOVER",
  completion = "COMPLETION",
}

local M = {
  data = {
    code_actions = {},
    diagnostics = {},
    formatting = {},
    hover = {},
    completion = {},
    custom = {},
    initialized = false,
  },
}

function M:init()
  self.initialized = true

  local sources = {}

  for field_name in pairs(SOURCE_TO_METHODS) do
    for name, conf in pairs(self.data[field_name]) do
      local base = self:_get_config(name, field_name)
      table.insert(sources, base.with(conf or {}))
    end
  end

  for _, v in pairs(self.data.custom) do
    table.insert(sources, v())
  end

  return sources
end

function M:add_code_action(name, config)
  return self:_add(name, "code_actions", config)
end

function M:add_diagnostic(name, config)
  return self:_add(name, "diagnostics", config)
end

function M:add_formatting(name, config)
  return self:_add(name, "formatting", config)
end

function M:add_hover(name, config)
  return self:_add(name, "hover", config)
end

function M:add_completion(name, config)
  return self:_add(name, "completion", config)
end

function M:add_custom(config)
  self:remove_custom(config.name)
  self.data.custom[config.name] = config

  if self.initialized then
    require("null-ls").register(config())
  end
end

function M:remove_code_action(name)
  self:_remove(name, "code_actions")
end

function M:remove_diagnostic(name)
  self:_remove(name, "diagnostics")
end

function M:remove_formatting(name)
  self:_remove(name, "formatting")
end

function M:remove_hover(name)
  self:_remove(name, "hover")
end

function M:remove_completion(name)
  self:_remove(name, "completion")
end

function M:remove_custom(name)
  local old = self.data.custom[name]
  self.data.custom[name] = nil

  if not (self.initialized and old) then
    return
  end

  local mod = require("null-ls")
  local query = {
    name = old.name,
    method = old.method,
  }

  mod.disable(query)
  mod.deregister(query)
end

function M:reset()
  self.data = {}

  if not self.initialized then
    return
  end

  local mod = require("null-ls")
  mod.disable()
  mod.reset_sources()
end

function M:_add(name, source_name, config)
  config = config or {}
  self.data[source_name][name] = config

  if not self.initialized then
    return
  end

  local mod = require("null-ls")
  local query = {
    name = name,
    method = mod.methods[SOURCE_TO_METHODS[source_name]],
  }

  local base = self:_get_config(name, source_name)

  mod.disable(query)
  mod.deregister(query)
  mod.register(base.with(config))
end

function M:_remove(name, source_name)
  self.data[source_name][name] = nil

  if not self.initialized then
    return
  end

  local mod = require("null-ls")
  local query = {
    name = name,
    method = mod.methods[SOURCE_TO_METHODS[source_name]],
  }

  mod.disable(query)
  mod.deregister(query)
end

function M:_get_config(name, source_name)
  local builtins = require("null-ls").builtins

  local ok, base = pcall(function()
    return require(string.format("none-ls.%s.%s", source_name, name))
  end)
  if not ok then
    return builtins[source_name][name]
  end

  return base
end

return M
