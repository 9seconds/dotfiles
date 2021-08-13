-- vim: ts=2:sw=2:sts=2

local helpers = require("helpers")
local autopairs = require("nvim-autopairs")

local t_cn = vim.api.nvim_replace_termcodes("<c-n>", true, true, true)
local t_cp = vim.api.nvim_replace_termcodes("<c-p>", true, true, true)
local t_tab = vim.api.nvim_replace_termcodes("<tab>", true, true, true)
local t_stab = vim.api.nvim_replace_termcodes("<s-tab>", true, true, true)
local t_expand_or_jump = vim.api.nvim_replace_termcodes("<Plug>(vsnip-expand-or-jump)", true, true, true)
local t_jump_prev = vim.api.nvim_replace_termcodes("<Plug>(vsnip-jump-prev)", true, true, true)


local function check_back_space()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end


local M = {}


function M.setup()
  _G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t_cn
    elseif vim.fn['vsnip#available'](1) == 1 then
      return t_expand_or_jump
    elseif check_back_space() then
      return t_tab
    end
    return vim.fn["compe#complete"]()
  end

  _G.stab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t_cp
    elseif vim.fn['vsnip#jumpable'](-1) then
      return t_jump_prev
    end
    return t_stab
  end

  _G.compe_confirm = function()
    return vim.fn["compe#confirm"](autopairs.autopairs_cr())
  end

  helpers.keymap("i", "<tab>", "v:lua.tab_complete()", {noremap=false, expr=true})
  helpers.keymap("s", "<tab>", "v:lua.tab_complete()", {noremap=false, expr=true})
  helpers.keymap("i", "<s-tab>", "v:lua.stab_complete()", {noremap=false, expr=true})
  helpers.keymap("s", "<s-tab>", "v:lua.stab_complete()", {noremap=false, expr=true})

  helpers.keymap("i", "<cr>", "v:lua.compe_confirm()", {noremap=false, expr=true})
  helpers.keymap("i", "<c-e>", "compe#close('<C-e>')", {noremap=false, expr=true})
end


return M
