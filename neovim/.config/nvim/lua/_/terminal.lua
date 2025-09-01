-- custom terminal wrapper

local function open_terminal(how)
  vim.cmd(
    how .. " term://" .. (vim.g.global_shell or vim.env.SHELL or vim.o.shell)
  )
end

local function setup_keymappings()
  -- move between windows
  vim.keymap.set("t", "<C-h>", "<c-\\><c-n><c-w>h")
  vim.keymap.set("t", "<C-j>", "<c-\\><c-n><c-w>j")
  vim.keymap.set("t", "<C-k>", "<c-\\><c-n><c-w>k")
  vim.keymap.set("t", "<C-l>", "<c-\\><c-n><c-w>l")

  -- exit normal mode
  vim.keymap.set("t", "<A-i>", "<c-\\><c-n>")

  -- run terminal mappings
  vim.keymap.set("n", "<leader>]o", function()
    open_terminal("edit")
  end)

  vim.keymap.set("n", "<leader>][", function()
    open_terminal("split")
  end)

  vim.keymap.set("n", "<leader>]]", function()
    open_terminal("vsplit")
  end)

  vim.keymap.set("n", "<leader>]p", function()
    open_terminal("tabedit")
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

  vim.api.nvim_create_autocmd("WinEnter", {
    group = group,
    callback = function()
      if vim.bo.buftype == "terminal" then
        vim.cmd("startinsert!")
      end
    end,
  })

  vim.api.nvim_create_autocmd("TermEnter", {
    group = group,
    callback = function()
      vim.wo.number = false
    end,
  })
end

local function setup()
  setup_keymappings()
  setup_autogroup()
end

setup()
