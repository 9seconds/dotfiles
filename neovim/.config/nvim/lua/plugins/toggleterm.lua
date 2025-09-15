-- terminal management
-- https://github.com/akinsho/toggleterm.nvim

local LINES_IN_PREVIEW = 100

local STATE = {
  visible = false,
  counter = 1,
}

function STATE:new(direction)
  self:run(self.counter, direction)
  self.counter = self.counter + 1
end

function STATE:run(number, direction)
  if self.visible then
    vim.cmd("ToggleTermToggleAll")
  end

  vim.cmd(
    ("%dToggleTerm direction=%s name=%d"):format(number, direction, number)
  )
end

function STATE:choose()
  local terminals = require("toggleterm.terminal").get_all()
  local snacks = require("snacks")

  if #terminals == 0 then
    return self:new("vertical")
  end

  snacks.picker({
    title = "Choose terminal",
    items = terminals,

    preview = function(ctx)
      local bufnr = tonumber(ctx.item.bufnr)

      if not bufnr then
        return
      end

      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local total = #lines
      local start = math.max(1, total - LINES_IN_PREVIEW + 1)
      local tail = {}

      for i = start, total do
        table.insert(tail, lines[i])
      end

      ctx.preview:set_lines(tail)
      ctx.preview:highlight({
        ft = vim.bo[bufnr].filetype,
      })

      return true
    end,

    format = function(item)
      return {
        { tostring(item.id), "SnacksPickerLabel" },
      }
    end,

    actions = {
      open_horizontal = function(picker, item)
        picker:close()
        self:run(item.id, "horizontal")
      end,
      open_vertical = function(picker, item)
        picker:close()
        self:run(item.id, "vertical")
      end,
      open_tab = function(picker, item)
        picker:close()
        self:run(item.id, "tab")
      end,
      open_float = function(picker, item)
        picker:close()
        self:run(item.id, "float")
      end,
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

    confirm = function(picker, item)
      picker:close()
      self:run(item.id, "vertical")
    end,
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
      "<leader>]v",
      function()
        STATE:new("vertical")
      end,
      desc = "Open new vertical terminal",
    },
    {
      "<leader>]s",
      function()
        STATE:new("horizontal")
      end,
      desc = "Open new horizontal terminal",
    },
    {
      "<leader>]t",
      function()
        STATE:new("tab")
      end,
      desc = "Open new tab terminal",
    },
    {
      "<leader>]f",
      function()
        STATE:new("edit")
      end,
      desc = "Open new float terminal",
    },
    {
      "<leader>]]",
      function()
        STATE:choose()
      end,
    },
  },

  config = function()
    require("toggleterm").setup({
      size = function(term)
        if term.direction == "horizontal" then
          return 20
        end

        return vim.o.columns * 0.5
      end,

      on_create = function(term)
        vim.notify("New terminal " .. term.id, vim.log.levels.INFO, {})
      end,
      on_open = function()
        STATE.visible = true
      end,
      on_close = function()
        STATE.visible = false
      end,

      shell = function()
        return vim.env.SHELL or vim.o.shell or "/bin/bash"
      end,

      persist_mode = false,
      insert_mappings = false,
    })

    local group = vim.api.nvim_create_augroup("9_ToggleTerm", {})
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = "toggleterm",
      callback = function(args)
        local opts = {
          buffer = args.buf,
        }

        vim.keymap.set("t", "<C-h>", "<c-\\><c-n><c-w>h", opts)
        vim.keymap.set("t", "<C-j>", "<c-\\><c-n><c-w>j", opts)
        vim.keymap.set("t", "<C-k>", "<c-\\><c-n><c-w>k", opts)
        vim.keymap.set("t", "<C-l>", "<c-\\><c-n><c-w>l", opts)
        vim.keymap.set("t", "<A-q>", "<c-\\><c-n>", opts)
        vim.keymap.set("t", "<A-z>", "<cmd>ToggleTerm<cr>", opts)
      end,
    })
    vim.api.nvim_create_autocmd("WinEnter", {
      group = group,
      pattern = "term://*toggleterm*",
      callback = vim.schedule_wrap(function()
        vim.cmd("startinsert")
      end),
    })
  end,
}
