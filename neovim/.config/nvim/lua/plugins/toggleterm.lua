-- terminal management
-- https://github.com/akinsho/toggleterm.nvim

local WORDS_TIMEOUT = 2 * 1000 -- in milliseconds
local VISIBILITIES = {}

local function run_new(direction)
  local words = vim
    .system({ "shuf", "-n", "1", "/usr/share/dict/words" }, { text = true })
    :wait(WORDS_TIMEOUT)

  if words.code ~= 0 then
    return vim.notify(
      ("Failed to get random word: %s"):format(words.stderr),
      vim.log.levels.ERROR,
      { title = "toggleterm" }
    )
  end

  local title = vim.trim(words.stdout)
  title = title:lower()
  title = vim.fn.shellescape(title)

  vim.cmd(
    ("%dToggleTerm direction=%s name=%s"):format(
      #VISIBILITIES + 1,
      direction,
      title
    )
  )
end

local function run_existing(number, direction)
  local cmd = ("%dToggleTerm direction=%s"):format(number, direction)

  if VISIBILITIES[number] then
    vim.cmd(cmd)
  end

  vim.cmd(cmd)
end

local function choose()
  local terminals = require("toggleterm.terminal").get_all()
  local snacks = require("snacks")
  local preview = require("snacks.picker.preview").file

  if #terminals == 0 then
    return
  end

  local function make_action(direction)
    return function(picker, item)
      picker:close()
      return run_existing(item.id, direction)
    end
  end

  snacks.picker({
    title = "Choose terminal",
    items = terminals,

    preview = function(ctx)
      ctx.item.buf = ctx.item.bufnr
      preview(ctx)

      return true
    end,

    format = function(item)
      return {
        { ("%d:"):format(item.id), "SnacksPickerLabel" },
        { (" %s "):format(item:_display_name()), "SnacksPickerBold" },
      }
    end,

    actions = {
      open_horizontal = make_action("horizontal"),
      open_vertical = make_action("vertical"),
      open_tab = make_action("tab"),
      open_float = make_action("float"),
    },

    win = {
      input = {
        keys = {
          ["<c-s>"] = {
            "open_horizontal",
            mode = { "n", "i" },
            desc = "Open in horizontal split",
          },
          ["<c-v>"] = {
            "open_vertical",
            mode = { "n", "i" },
            desc = "Open in vertical split",
          },
          ["<c-t>"] = {
            "open_tab",
            mode = { "n", "i" },
            desc = "Open in tab",
          },
          ["<c-f>"] = {
            "open_float",
            mode = { "n", "i" },
            desc = "Open in float window",
          },
        },
      },
    },

    confirm = make_action("vertical"),
  })
end

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  dependencies = {
    "folke/snacks.nvim",
  },
  cmd = {
    "TermSelect",
    "TermExec",
    "TermNew",
    "ToggleTerm",
    "ToggleTermToggleAll",
    "ToggleTermSendVisualLines",
    "ToggleTermSendVisualSelection",
    "ToggleTermSendCurrentLine",
    "ToggleTermSetName",
  },
  keys = {
    {
      "<leader>]]",
      function()
        run_new("vertical")
      end,
      desc = "Open new vertical terminal",
    },
    {
      "<leader>]s",
      function()
        run_new("horizontal")
      end,
      desc = "Open new horizontal terminal",
    },
    {
      "<leader>]t",
      function()
        run_new("tab")
      end,
      desc = "Open new tab terminal",
    },
    {
      "<leader>]f",
      function()
        run_new("float")
      end,
      desc = "Open new float terminal",
    },
    {
      "<leader>][",
      function()
        return choose()
      end,
      desc = "Choose terminal (or open a new one)",
    },
    {
      "<leader>]c",
      "<cmd>ToggleTermToggleAll<cr>",
      desc = "Close all open terminals",
    },
  },

  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 20
      end

      return vim.o.columns * 0.5
    end,

    shell = function()
      return vim.env.SHELL or vim.o.shell or "/bin/bash"
    end,

    on_create = function(term)
      local function set(lhs, rhs)
        vim.keymap.set("t", lhs, rhs, {
          buffer = term.bufnr,
          noremap = true,
          silent = true,
        })
      end

      set("<A-q>", "<c-\\><c-n>")
      set("<A-z>", "<cmd>ToggleTerm<cr>")
      set("<C-h>", "<cmd>wincmd h<cr>")
      set("<C-j>", "<cmd>wincmd j<cr>")
      set("<C-k>", "<cmd>wincmd k<cr>")
      set("<C-l>", "<cmd>wincmd l<cr>")
    end,

    on_open = function(term)
      VISIBILITIES[term.id] = true
    end,
    on_close = function(term)
      VISIBILITIES[term.id] = false
    end,

    winbar = {
      enabled = true,
    },
    shading_factor = -20,
    insert_mappings = false,
    terminal_mappings = false,
  },
}
