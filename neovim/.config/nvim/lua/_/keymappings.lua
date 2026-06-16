-- This module contains basic keymappings

local function nmap(key, action, opts)
  vim.keymap.set("n", key, action, opts)
end

local function vmap(key, action, opts)
  vim.keymap.set("v", key, action, opts)
end

local function cmap(key, action, opts)
  vim.keymap.set("c", key, action, opts)
end

local function tmap(key, action, opts)
  vim.keymap.set("t", key, action, opts)
end

local function setup()
  nmap("<space>", "<nop>")
  vmap("<space>", "<nop>")

  -- always go to insert mode even in terminals
  tmap("<esc><esc>", "<c-\\><c-n>")

  -- sudo write
  -- type w!! and it would be converted into sudo tee >/dev/null <CONTENT FILENAME
  cmap("w!!", "w !sudo tee >/dev/null %")

  -- more reasonable indents/unindents
  vmap("<", "<gv")
  vmap(">", ">gv")

  -- wrapline-aware navigation
  nmap("j", "gj")
  nmap("k", "gk")
  nmap("$", "g$")
  nmap("0", "^")

  -- center screen on search operations
  nmap("n", "nzz", { remap = true })
  nmap("N", "Nzz", { remap = true })
  nmap("*", "*zz``", { remap = true })
  nmap("#", "#zz", { remap = true })
  nmap("g*", "g*zz", { remap = true })
  nmap("g#", "g#zz", { remap = true })
  nmap("<c-d>", "<c-d>zz", { remap = true })
  nmap("<c-u>", "<c-u>zz", { remap = true })
  nmap("<c-f>", "<c-f>zz", { remap = true })
  nmap("<c-b>", "<c-b>zz", { remap = true })

  -- split navigation
  nmap("<c-h>", "<c-w>h")
  vmap("<c-h>", "<c-w>h")
  nmap("<c-j>", "<c-w>j")
  vmap("<c-j>", "<c-w>j")
  nmap("<c-k>", "<c-w>k")
  vmap("<c-k>", "<c-w>k")
  nmap("<c-l>", "<c-w>l")
  vmap("<c-l>", "<c-w>l")

  -- fast save
  nmap("<leader><leader>", "<cmd>update<cr>", { silent = false })

  -- select just pasted
  nmap("gp", "`[v`]")

  -- lsp commands
  vim.keymap.set(
    {"n", "v", "x"},
    "<leader>lc",
    function()
      vim.lsp.buf.code_action()
    end
  )
  vim.keymap.set(
    {"n", "v", "x"},
    "<leader>l=",
    function()
      vim.lsp.buf.format()
    end
  )
end

setup()
