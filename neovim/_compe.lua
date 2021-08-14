-- vim: ts=2:sw=2:sts=2

local M = {}

local utils = require("_utils")
local autopairs = require("nvim-autopairs")


-- returns internal representation of terminal code or keycodes.
-- please see :h nvim_replace_termcodes() for details.
local function tcode(code)
  return vim.api.nvim_replace_termcodes(code, true, true, true)
end

-- returns if backspace was pressed.
local function check_back_space()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

-- a list of constants to use here and there
local TERMCODE_CN = tcode("<c-n>")
local TERMCODE_CP = tcode("<c-p>")
local TERMCODE_TAB = tcode("<tab>")
local TERMCODE_STAB = tcode("<s-tab>")
local TERMCODE_VSNIP_EXPAND_OR_JUMP = tcode("<Plug>(vsnip-expand-or-jump)")
local TERMCODE_VSNIP_JUMP_PREV = tcode("<Plug>(vsnip-jump-prev)")
local TERMCODE_CE = tcode("<c-e>")


-- setups nvim-compe. installs tab/stab completion
function M.setup()
  _G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return TERMCODE_CN
    elseif vim.fn['vsnip#available'](1) == 1 then
      return TERMCODE_VSNIP_EXPAND_OR_JUMP
    elseif check_back_space() then
      return TERMCODE_TAB
    end
    return vim.fn["compe#complete"]()
  end

  _G.stab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return TERMCODE_CP
    elseif vim.fn['vsnip#jumpable'](-1) then
      return TERMCODE_VSNIP_JUMP_PREV
    end
    return TERMCODE_STAB
  end

  _G.compe_confirm = function()
    return vim.fn["compe#confirm"](autopairs.autopairs_cr())
  end

  _G.compe_close = function()
    return vim.fn["compe#close"](TERMCODE_CE)
  end

  utils.keymap("i", "<tab>", "v:lua.tab_complete()", {noremap=false, expr=true})
  utils.keymap("s", "<tab>", "v:lua.tab_complete()", {noremap=false, expr=true})
  utils.keymap("i", "<s-tab>", "v:lua.stab_complete()", {noremap=false, expr=true})
  utils.keymap("s", "<s-tab>", "v:lua.stab_complete()", {noremap=false, expr=true})

  utils.keymap("i", "<cr>", "v:lua.compe_confirm()", {noremap=false, expr=true})
  utils.keymap("i", "<c-e>", "v:lua.compe_close()", {noremap=false, expr=true})
end


return M
