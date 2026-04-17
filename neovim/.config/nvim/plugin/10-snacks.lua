-- folke mini plugins
-- https://github.com/folke/snacks.nvim

vim.pack.add({
  {
    src = "https://github.com/folke/snacks.nvim",
    version = vim.version.range("*"),
  },
})

local PREFIX = "<leader>s"
local TOGGLE_PREFIX = PREFIX .. "t"
local mod = require("snacks")

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

mod.toggle.inlay_hints():map(TOGGLE_PREFIX .. "h")
mod.toggle.dim():map(TOGGLE_PREFIX .. "m")
mod.toggle.indent():map(TOGGLE_PREFIX .. "i")
mod.toggle.treesitter():map(TOGGLE_PREFIX .. "t")

local state_diagnostic = false
mod
  .toggle({
    id = "diagnostic",
    name = "diagnostic virtual line",
    get = function()
      return state_diagnostic
    end,
    set = function(state)
      state_diagnostic = state
      if state then
        state = {
          current_line = true,
        }
      else
        state = false
      end
      vim.diagnostic.config({ virtual_lines = state })
    end,
  })
  :map(TOGGLE_PREFIX .. "d")

mod
  .toggle({
    id = "spellcheck",
    name = "spellcheck",
    get = function()
      return vim.o.spell or false
    end,
    set = function(state)
      vim.o.spell = state
    end,
  })
  :map(TOGGLE_PREFIX .. "s")

mod
  .toggle({
    id = "copilot",
    name = "copilot completions",
    get = function()
      return vim.g.copilot_mode or false
    end,
    set = function(state)
      vim.g.copilot_mode = state
      vim.api.nvim_exec_autocmds("User", {
        pattern = "CopilotModeChanged",
        data = state,
      })
    end,
  })
  :map(TOGGLE_PREFIX .. "c")

mod
  .toggle({
    id = "nes",
    name = "copilot next edit suggestions",
    get = function()
      return vim.g.copilot_nes_mode or false
    end,
    set = function(state)
      vim.g.copilot_nes_mode = state
      vim.api.nvim_exec_autocmds("User", {
        pattern = "CopilotNesModeChanged",
        data = state,
      })
    end,
  })
  :map(TOGGLE_PREFIX .. "n")

mod.indent.enable()

vim.keymap.set(
  { "i", "t" },
  "<A-a>",
  "<c-\\><c-n><cmd>lua require('snacks.zen').zoom()<cr><cmd>startinsert<cr>",
  {
    desc = "Snacks: Zoom",
  }
)

vim.keymap.set({ "n", "x", "o" }, "<A-a>", function()
  require("snacks").zen.zoom()
end, {
  desc = "Snacks: Zoom",
})
vim.keymap.set("n", PREFIX .. "g", function()
  require("snacks").lazygit()
end, {
  desc = "Snacks: LazyGit",
})

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("9_Snacks", {}),
  pattern = "OilActionsPost",
  callback = function(evt)
    if evt.data.actions.type == "move" then
      require("snacks").rename.on_rename_file(
        evt.data.actions.src_url,
        evt.data.actions.dest_url
      )
    end
  end,
})
