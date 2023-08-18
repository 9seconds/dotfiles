-- custom terminal wrapper

local function open_terminal(how)
  vim.cmd(how .. " term://" .. (vim.env.SHELL or vim.o.shell))
end

local function setup_keymappings()
  -- move between windows
  vim.keymap.set("n", "<A-h>", "<c-w>h")
  vim.keymap.set("t", "<A-h>", "<c-\\><c-n><c-w>h")
  vim.keymap.set("n", "<A-j>", "<c-w>j")
  vim.keymap.set("t", "<A-j>", "<c-\\><c-n><c-w>j")
  vim.keymap.set("n", "<A-k>", "<c-w>k")
  vim.keymap.set("t", "<A-k>", "<c-\\><c-n><c-w>k")
  vim.keymap.set("n", "<A-l>", "<c-w>l")
  vim.keymap.set("t", "<A-l>", "<c-\\><c-n><c-w>l")

  -- exit normal mode
  vim.keymap.set("t", "<A-q>", "<c-\\><c-n>")

  -- run terminal mappings
  vim.keymap.set("n", "<leader>]e", function()
    open_terminal("edit")
  end)

  vim.keymap.set("n", "<leader>]s", function()
    open_terminal("split")
  end)

  vim.keymap.set("n", "<leader>]v", function()
    open_terminal("vsplit")
  end)
end

local function setup_autogroup()
  local group = vim.api.nvim_create_augroup("9_Terminal", {})

  vim.api.nvim_create_autocmd("TermOpen", {
    group = group,
    callback = function()
      vim.wo.number = false
      vim.cmd("startinsert!")
    end,
  })

  vim.api.nvim_create_autocmd("TermEnter", {
    group = group,
    callback = function()
      vim.wo.number = false
    end,
  })

  vim.api.nvim_create_autocmd("WinEnter", {
    group = group,
    callback = function()
      if vim.bo.buftype == "terminal" then
        vim.cmd("startinsert!")
      end
    end,
  })

  vim.api.nvim_create_autocmd("TermClose", {
    group = group,
    callback = function()
      vim.fn.feedkeys("<esc>")
    end,
  })
end

return {
  setup = function()
    setup_keymappings()
    setup_autogroup()
  end,
}
