-- snippet support
-- https://github.com/nvim-mini/mini.snippets

require("_.pack").add({
  url = "https://github.com/nvim-mini/mini.snippets",
  releases = true,
  lazy = true,
  config = function()
    local mod = require("mini.snippets")

    mod.setup({
      mappings = {
        stop = "<c-k>",
      },

      expand = {
        match = function(snippets)
          return mod.default_match(snippets, { pattern_fuzzy = "%S+" })
        end,
      },

      snippets = {
        mod.gen_loader.from_file(
          vim.fs.joinpath(vim.fn.stdpath("config"), "snippets", "_.lua")
        ),
        mod.gen_loader.from_lang(),
        mod.gen_loader.from_file(vim.fs.joinpath(".snippets", "_.lua")),

        function(ctx)
          local filename = vim.fs.joinpath(".snippets", ctx.lang .. ".lua")
          if vim.uv.fs_stat(filename) then
            return mod.read_file(filename)
          end
        end,
      },
    })

    vim.keymap.set({ "n", "x" }, "<leader>c", function()
      while mod.session.get() do
        mod.session.stop()
      end
    end, {
      desc = "mini.snippets: Stop sessions",
    })
  end,
})
