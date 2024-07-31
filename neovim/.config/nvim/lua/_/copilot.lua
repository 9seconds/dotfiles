-- different copilot stuff

local M = {
  enabled = false,
}

function M:user_toggle()
  M.user_enabled(not M.enabled)
end

function M.user_enabled(enabled)
  M.enabled = enabled
  M.set()
end

function M.cmp_enabled(enabled)
  vim.b.copilot_cmp_enabled = enabled
  M.set()
end

function M.set()
  local enabled = vim.g.use_copilot and M.enabled and vim.b.copilot_cmp_enabled
  if enabled == vim.b.copilot_active then
    return
  end

  vim.b.copilot_active = enabled
  vim.b.copilot_suggestion_hidden = not enabled
  vim.b.copilot_suggestion_auto_trigger = enabled

  local copilot_suggestion = package.loaded["copilot.suggestion"]
  if not copilot_suggestion then
    return
  end

  if copilot_suggestion.is_visible() then
    copilot_suggestion.dismiss()
  else
    copilot_suggestion.next()
  end
end

function M.activate()
  local mod = package.loaded["copilot.command"]
  if not mod then
    return
  end

  if vim.g.use_copilot then
    mod.enable()
  else
    mod.disable()
  end

  M.set()
end

local function setup()
  local group = vim.api.nvim_create_augroup("9_Copilot", {})

  vim.api.nvim_create_autocmd({ "User" }, {
    group = group,
    pattern = "_9ExrcUpdated",
    callback = M.activate,
  })

  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = group,
    callback = function()
      if vim.b.copilot_active == nil then
        vim.b.copilot_active = false
      end

      if vim.b.copilot_cmp_enabled == nil then
        vim.b.copilot_cmp_enabled = true
      end

      M.set()
    end,
  })
end

setup()

return M
