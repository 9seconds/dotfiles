-- ai copilot
-- https://github.com/folke/sidekick.nvim

vim.pack.add({
  {
    src = "https://github.com/folke/sidekick.nvim",
    version = vim.version.range("*"),
  },
})

local PREFIX = "<leader>k"

vim.api.nvim_create_autocmd("FileType", {
  once = true,
  callback = function()
    vim.lsp.enable("copilot_ls")

    require("sidekick").setup({
      nes = {
        enabled = vim.g.copilot_nes_mode or false,
      },
      cli = {
        mux = {
          enabled = false,
        },
        win = {
          split = {
            width = 120,
          },
        },
        picker = "fzf-lua",
        prompts = {
          ["This"] = "{this}",
          ["This file"] = "{file}",
          ["Position in the file"] = "{position}",
          ["Current line"] = "{line}",
          ["Visual selection"] = "{selection}",
          ["Diagnostics in the current buffer"] = "{diagnostics}",
          ["All diagnostics"] = "{diagnostics_all}",
          ["Quickfix"] = "{quickfix}",
          ["This function"] = "{function}",
          ["This class"] = "{class}",
        },
      },
    })

    vim.keymap.set({ "n", "x", "s", "v", "t" }, "<c-.>", function()
      require("sidekick.cli").focus({ name = vim.g.sidekick_tool or "copilot" })
    end, {
      desc = "Sidekick: Toggle",
    })

    -- keymaps for sending
    vim.keymap.set({ "n", "x" }, PREFIX .. "t", function()
      require("sidekick.cli").send({ msg = "{this}" })
    end, {
      desc = "Sidekick: Send this",
    })

    vim.keymap.set({ "n", "x" }, PREFIX .. "f", function()
      require("sidekick.cli").send({ msg = "{file}" })
    end, {
      desc = "Sidekick: Send file",
    })

    vim.keymap.set({ "x" }, PREFIX .. "v", function()
      require("sidekick.cli").send({ msg = "{selection}" })
    end, {
      desc = "Sidekick: Send visual selection",
    })

    -- NES
    vim.keymap.set({ "x", "n", "t" }, PREFIX .. "a", function()
      require("sidekick.nes").apply()
    end, {
      desc = "Sidekick: Apply NES",
    })

    vim.keymap.set({ "x", "n", "t" }, PREFIX .. "j", function()
      require("sidekick.nes").jump()
    end, {
      desc = "Sidekick: Jump to the next NES",
    })
    vim.keymap.set({ "x", "n", "t" }, PREFIX .. "u", function()
      require("sidekick.nes").update()
    end, {
      desc = "Sidekick: Update NES",
    })
    vim.keymap.set({ "x", "n", "t" }, PREFIX .. "c", function()
      require("sidekick.nes").clear()
    end, {
      desc = "Sidekick: Clear NES",
    })

    vim.api.nvim_create_autocmd("User", {
      group = vim.api.nvim_create_augroup("9_SideKick", {}),
      pattern = "CopilotNesModeChanged",
      callback = function(ev)
        require("sidekick.nes").enable(ev.data)
      end,
    })
  end,
})
