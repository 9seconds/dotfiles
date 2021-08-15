-- vim: ts=2:sw=2:sts=2

local M = {}

local utils = require("_utils")


-- returns if backspace was pressed.
local function check_back_space()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end


-- a list of constants to use here and there
local TERMCODE_CN = utils:termcode("<c-n>")
local TERMCODE_CP = utils:termcode("<c-p>")
local TERMCODE_TAB = utils:termcode("<tab>")
local TERMCODE_STAB = utils:termcode("<s-tab>")
local TERMCODE_CE = utils:termcode("<c-e>")


-- setups nvim-compe. installs tab/stab completion
function M.setup()
  function _G.tab_complete()
    if vim.fn.pumvisible() == 1 then
      return TERMCODE_CN
    elseif check_back_space() then
      return TERMCODE_TAB
    end
    return vim.fn["compe#complete"]()
  end

  function _G.stab_complete()
    if vim.fn.pumvisible() == 1 then
      return TERMCODE_CP
    end
    return TERMCODE_STAB
  end

  function _G.compe_confirm()
    local autopairs = require("nvim-autopairs")
    return vim.fn["compe#confirm"](autopairs.autopairs_cr())
  end

  function _G.compe_close()
    return vim.fn["compe#close"](TERMCODE_CE)
  end

  utils:keyemap("i", "<tab>", "v:lua.tab_complete()")
  utils:keyemap("s", "<tab>", "v:lua.tab_complete()")
  utils:keyemap("i", "<s-tab>", "v:lua.stab_complete()")
  utils:keyemap("s", "<s-tab>", "v:lua.stab_complete()")
  utils:keyemap("i", "<cr>", "v:lua.compe_confirm()")
  utils:keyemap("i", "<c-e>", "v:lua.compe_close()")
end


return M
