-- This module contains basic keymappings

local function imap(key, action, opts)
  vim.keymap.set("i", key, action, opts)
end

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
  nmap("n", "nzz")
  nmap("N", "Nzz")
  nmap("*", "*zz``")
  nmap("#", "#zz")
  nmap("g*", "g*zz")
  nmap("g#", "g#zz")
  nmap("<c-d>", "<c-d>zz")
  nmap("<c-u>", "<c-u>zz")
  nmap("<c-f>", "<c-f>zz")
  nmap("<c-b>", "<c-b>zz")

  -- split navigation
  nmap("<c-h>", "<c-w>h")
  vmap("<c-h>", "<c-w>h")
  nmap("<c-j>", "<c-w>j")
  vmap("<c-j>", "<c-w>j")
  nmap("<c-k>", "<c-w>k")
  vmap("<c-k>", "<c-w>k")
  nmap("<c-l>", "<c-w>l")
  vmap("<c-l>", "<c-w>l")

  nmap("<leader><space>", "<cmd>update<cr>", { silent = true })

  -- select just pasted
  nmap("gp", "`[v`]")

  -- clear highlight
  nmap("<leader>l", "<cmd>nohlsearch<cr>", { silent = true })

  -- exit insert mode
  imap("jj", "<esc>")
  imap("kk", "<esc>")

  -- spellcheck
  nmap("<leader>?", function()
    vim.o.spell = not vim.o.spell
  end)
end

setup()
