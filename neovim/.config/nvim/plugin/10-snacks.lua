-- folke mini plugins
-- https://github.com/folke/snacks.nvim

vim.pack.add({
  {
    src = "https://github.com/folke/snacks.nvim",
    version = vim.version.range("*"),
  },
})

local mod = require("snacks")
local keymap = require("_.utils").keymap("Snacks")

local PREFIX = "<leader>s"

mod.setup({
  styles = {
    -- https://github.com/folke/snacks.nvim/blob/main/docs/zen.md#zen
    zen = {
      width = 200,
    },
  },
  -- https://github.com/folke/snacks.nvim/blob/main/docs/dim.md
  dim = {
    enabled = true,
    animate = {
      enabled = false,
    },
  },
  -- https://github.com/folke/snacks.nvim/blob/main/docs/statuscolumn.md
  statuscolumn = {
    enabled = true,
  },
  -- https://github.com/folke/snacks.nvim/blob/main/docs/bigfile.md
  bigfile = {
    enabled = true,
    size = 1024 * 1024,
  },
  -- https://github.com/folke/snacks.nvim/blob/main/docs/image.md
  image = {
    enabled = true,
  },
  -- https://github.com/folke/snacks.nvim/blob/main/docs/input.md
  input = {
    enabled = true,
  },
  -- https://github.com/folke/snacks.nvim/blob/main/docs/indent.md
  indent = {
    enabled = true,
    only_current = true,
    only_scope = true,
    animate = {
      enabled = false,
    },
    chunk = {
      enabled = true,
    },
  },
  -- https://github.com/folke/snacks.nvim/blob/main/docs/notifier.md
  notifier = {
    enabled = true,
  },
  -- https://github.com/folke/snacks.nvim/blob/main/docs/zen.md
  zen = {
    toggles = {
      git_signs = false,
      diagnostic = false,
      inlay_hints = false,
    },
  },
  -- https://github.com/folke/snacks.nvim/blob/main/docs/scope.md
  scope = {
    enabled = true,
  },
  -- https://github.com/folke/snacks.nvim/blob/main/docs/quickfile.md
  quickfile = {
    enabled = true,
  },
  -- https://github.com/folke/snacks.nvim/blob/main/docs/rename.md
  rename = {
    enabled = true,
  },
  -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
  picker = {
    enabled = true,
    ui_select = true,
  },
})

mod.toggle.inlay_hints():map(PREFIX .. "h")
mod.toggle.dim():map(PREFIX .. "m")
mod.toggle.indent():map(PREFIX .. "i")
mod.toggle.treesitter():map(PREFIX .. "t")

local state_diagnostic = false
mod.toggle({
  id = "diagnostic",
  name = "diagnostic virtual text",
  get = function ()
    return state_diagnostic
  end,
  set = function (state)
    state_diagnostic = state
    vim.diagnostic.config({ virtual_text = state })
  end,
}):map(PREFIX .. "d")

mod.toggle({
  id = "spellcheck",
  name = "spellcheck",
  get = function ()
    return vim.o.spell or false
  end,
  set = function (state)
    vim.o.spell = state
  end,
}):map(PREFIX .. "s")

mod.indent.enable()

keymap(
  "Zoom", "<A-a>", "<c-\\><c-n><cmd>lua require('snacks.zen').zoom()<cr><cmd>startinsert<cr>",
  { "i", "t" }
)
keymap("Zoom", "<A-a>", mod.zen.zoom, { "n", "x", "o" })

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("9_Snacks", {}),
  pattern = "OilActionsPost",
  callback = function (evt)
    if evt.data.actions.type == "move" then
      mod.rename.on_rename_file(evt.data.actions.src_url, evt.data.actions.dest_url)
    end
  end,
})
