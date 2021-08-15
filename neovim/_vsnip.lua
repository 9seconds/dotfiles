-- vim: ts=2:sw=2:sts=2

local M = {}

local utils = require("_utils")


local TERMCODE_EXPAND_OR_JUMP = utils.termcode("<Plug>(vsnip-expand-or-jump)")
local TERMCODE_CUT_TEXT = utils.termcode("<Plug>(vsnip-cut-text)")
local TERMCODE_JUMP_PREV = utils.termcode("<Plug>(vsnip-jump-prev)")
local TERMCODE_CJ = utils.termcode("<c-j>")
local TERMCODE_CK = utils.termcode("<c-k>")


local function keymap(mode, lhs, rhs, options)
  options = options or {}
  options.noremap = false
  options.expr = true

  return utils.keymap(mode, lhs, rhs, options)
end

-- setups vsnip
function M.setup()
  vim.g.vsnip_snippet_dir = vim.fn.expand("~/.config/nvim/snippets")

  _G.vsnip_cut_text = function()
    return TERMCODE_CUT_TEXT
  end

  _G.vsnip_cj = function()
    if vim.fn["vsnip#available"](1) then
      return TERMCODE_EXPAND_OR_JUMP
    end
    return TERMCODE_CJ
  end

  _G.vsnip_ck = function()
    if vim.fn["vsnip#jumpable"](-1) then
      return TERMCODE_JUMP_PREV
    end
    return TERMCODE_CK
  end

  keymap("n", "c", "v:lua.vsnip_cut_text()")
  keymap("x", "c", "v:lua.vsnip_cut_text()")
  keymap("i", "<c-j>", "v:lua.vsnip_cj()")
  keymap("s", "<c-j>", "v:lua.vsnip_cj()")
  keymap("i", "<c-k>", "v:lua.vsnip_ck()")
  keymap("s", "<c-k>", "v:lua.vsnip_ck()")
end


return M
