--- different lint stuff

local M = {
  configs = {},
  chains = {},
}

function M:set(language, linter, config)
  if self.configs[language] == nil then
    self.configs[language] = {}
  end

  self.configs[language][linter] = config or {}
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
    linters_by_ft = chains,
    linters = configs,
  }
end

return M
