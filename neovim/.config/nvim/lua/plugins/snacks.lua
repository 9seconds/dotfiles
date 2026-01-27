-- folke mini plugins
-- https://github.com/folke/snacks.nvim

return {
  "folke/snacks.nvim",
  version = "*",
  lazy = false,
  priority = 1001,

  keys = {
    {
      "<leader>sg",
      function()
        require("snacks").lazygit()
      end,
      desc = "Run LazyGit",
    },
    {
      "<leader>sG",
      function()
        require("snacks").lazygit.log_file()
      end,
      desc = "Open log for a current file",
    },
    {
      "<leader>sn",
      function()
        require("snacks").notifier.show_history()
      end,
      desc = "Show notifications history",
    },
    {
      "<leader>sN",
      function()
        require("snacks").notifier.hide()
      end,
      desc = "Dismiss all notifications",
    },
    {
      "<A-a>",
      function()
        require("snacks").zen.zoom()
      end,
      mode = { "n", "x", "o" },
      desc = "Run zoom zen mode",
    },
    {
      "<A-a>",
      "<c-\\><c-n><cmd>lua require('snacks.zen').zoom()<cr><cmd>startinsert<cr>",
      mode = { "i", "t" },
      desc = "Run zoom zen mode",
    },
  },

  opts = {
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
  },

  init = function()
    local augroup = vim.api.nvim_create_augroup("9_Snacks", {})

    vim.g.enable_autocompletion = true

    vim.api.nvim_create_autocmd("User", {
      group = augroup,
      once = true,
      pattern = "VeryLazy",
      callback = function()
        local snacks = require("snacks")

        snacks.toggle.inlay_hints():map("<leader>uh")
        snacks.toggle.dim():map("<leader>ud")
        snacks.toggle.indent():map("<leader>ui")
        snacks.toggle.treesitter():map("<leader>ut")
        snacks
          .toggle({
            id = "autocomplete",
            name = "Autocompletion",
            get = function()
              return vim.g.enable_autocompletion
            end,
            set = function(state)
              vim.g.enable_autocompletion = state
              vim.api.nvim_exec_autocmds("User", {
                pattern = "EnableAutocompleteToggled",
              })
            end,
          })
          :map("<C-x>", { mode = { "n", "i", "x", "v", "o" } })

        local state_diagnostic = false
        snacks
          .toggle({
            id = "diagnostic",
            name = "Diagnostic virtual line",
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
          :map("<leader>ux")

        snacks.indent.enable()
      end,
    })

    -- integration with oil.nvim
    vim.api.nvim_create_autocmd("User", {
      group = augroup,
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
  end,
}
