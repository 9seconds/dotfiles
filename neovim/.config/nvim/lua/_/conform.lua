--- this module contains configuration for conform.nvim
--- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#lazy-loading-with-lazynvim

local M = {
  configs = {},
  chains = {},
}

function M:set(language, formatter, config)
  if self.configs[language] == nil then
    self.configs[language] = {}
  end

  self.configs[language][formatter] = config or {}
end

function M:set_execution_chain(language, chain)
  if self.chains[language] == nil then
    self.chains[language] = {}
  end

  self.chains[language] = chain
end

function M:get_config()
  local chains = {}
  local configs = {}

  for lang, conf in pairs(self.configs) do
    if chains[lang] == nil then
      chains[lang] = {}
    end

    configs = vim.tbl_extend("force", configs, conf)
    chains[lang] = vim.tbl_keys(conf)
  end

  for lang, chain in pairs(self.chains) do
    chains[lang] = chain
  end

  return {
    formatters_by_ft = chains,
    formatters = configs,
  }
end

return M
