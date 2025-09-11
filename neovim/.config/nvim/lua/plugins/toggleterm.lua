-- terminal management
-- https://github.com/akinsho/toggleterm.nvim

local STATE = {
  visible = false,
  counter = 1,
}

function STATE:new(direction)
  if self.visible then
    vim.cmd("ToggleTermToggleAll")
  end

  vim.cmd(
    ("%dToggleTerm direction=%s name=%d"):format(
      self.counter,
      direction,
      self.counter
    )
  )
  self.counter = self.counter + 1
end

function STATE:choose(direction)
  local terminals = require("toggleterm.terminal").get_all()

  if #terminals == 0 then
    return self:new(direction)
  end

  local function switch(terminal)
    if not terminal then
      return
    end

    if self.visible then
      vim.cmd("ToggleTermToggleAll")
    end

    vim.cmd(
      ("%dToggleTerm direction=%s name=%d"):format(
        terminal.id,
        direction,
        terminal.id
      )
    )
  end

  if #terminals == 1 then
    return switch(terminals[1])
  end

  vim.ui.select(terminals, {
    prompt = "Please select a terminal",
    format_item = function(term)
      return ("%d (%s -> %s)"):format(term.id, term.cmd, term.dir)
    end,
  }, function(_, idx)
    switch(terminals[idx])
  end)
end

return {
  "akinsho/toggleterm.nvim",
  version = "*",
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
      "<leader>]V",
      function()
        STATE:new("vertical")
      end,
      desc = "Open new vertical terminal",
    },
    {
      "<leader>]S",
      function()
        STATE:new("horizontal")
      end,
      desc = "Open new horizontal terminal",
    },
    {
      "<leader>]T",
      function()
        STATE:new("tab")
      end,
      desc = "Open new tab terminal",
    },
    {
      "<leader>]F",
      function()
        STATE:new("edit")
      end,
      desc = "Open new float terminal",
    },
    {
      "<leader>]v",
      function()
        STATE:choose("vertical")
      end,
      desc = "Switch to vertical terminal",
    },
    {
      "<leader>]s",
      function()
        STATE:choose("horizontal")
      end,
      desc = "Switch to horizontal terminal",
    },
    {
      "<leader>]t",
      function()
        STATE:choose("tab")
      end,
      desc = "Switch to tab terminal",
    },
    {
      "<leader>]f",
      function()
        STATE:choose("float")
      end,
      desc = "Switch to float terminal",
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
        vim.api.nvim_notify("New terminal " .. term.id, vim.log.levels.INFO, {})
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
        vim.keymap.set("t", "<A-]>", "<c-\\><c-n>", opts)
        vim.keymap.set("t", "<A-[>", "<cmd>ToggleTerm<cr>", opts)
      end,
    })
  end,
}
