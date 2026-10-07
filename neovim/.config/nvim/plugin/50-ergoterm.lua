-- terminals
-- https://github.com/waiting-for-dev/ergoterm.nvim

vim.pack.add({
  {
    src = "https://github.com/waiting-for-dev/ergoterm.nvim",
    version = vim.version.range("*"),
  },
})

require("ergoterm").setup({
  -- https://github.com/waiting-for-dev/ergoterm.nvim/tree/main#terminal-defaults
  terminal_defaults = {
    shell = vim.env.SHELL or vim.o.shell or "/bin/bash",
    layout = "right",
    dir = "git_dir",
    auto_scroll = true,
    exclusive_layout = true,
    start_in_insert = true,
    persist_size = false,

    float_opts = {
      height = math.floor(vim.o.lines * 0.85),
      width = math.floor(vim.o.columns * 0.85),
    },
  },
})

local function setup(key, layout)
  local keybind = string.format("<C-%s>", key)
  local term = require("ergoterm"):new({
    name = "term-" .. layout,
    layout = layout,

    on_open = function (term)
      local function tset(lhs, rhs)
        vim.keymap.set("t", lhs, rhs, {
          buffer = term._state.bufnr,
          noremap = true,
          silent = true,
        })
      end

      vim.api.nvim_create_autocmd("TermEnter", {
        buffer = term._state.bufnr,
        callback = function ()
          local opts = vim.wo[term._state.window]
          opts.winbar = term.name
          opts.list = false
          opts.number = false
        end,
      })
      vim.api.nvim_create_autocmd("TermLeave", {
        buffer = term._state.bufnr,
        callback = function ()
          local opts = vim.wo[term._state.window]
          opts.number = true
        end,
      })

      tset(keybind, function () term:toggle() end)
      tset("<C-h>", "<cmd>wincmd h<cr>")
      tset("<C-j>", "<cmd>wincmd j<cr>")
      tset("<C-k>", "<cmd>wincmd k<cr>")
      tset("<C-l>", "<cmd>wincmd l<cr>")
    end,
  })

  vim.keymap.set("n", keybind, function ()
    term:toggle()
  end, { noremap = true, silent = true }
  )
end

setup(",", "right")
setup("/", "below")
