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

return {
  setup = function()
    -- map space to leader and unmap a space in normal mode
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "
    nmap("<space>", "<nop>")
    vmap("<space>", "<nop>")

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
    nmap("<c-d>", "<c-d>")
    nmap("<c-u>", "<c-u>")
    nmap("<c-f>", "<c-f>")
    nmap("<c-b>", "<c-b>")

    -- split navigation
    nmap("<c-h>", "<c-w>h")
    nmap("<c-j>", "<c-w>j")
    nmap("<c-k>", "<c-w>k")
    nmap("<c-l>", "<c-w>l")

    -- clear highlight
    nmap("<leader>l", ":noh<cr>", { silent = true })

    -- exit insert mode
    imap("jj", "<esc>")
    imap("kk", "<esc>")

    -- fast save
    nmap("<leader><leader>", ":update<cr>", { silent = true })

    -- spellcheck
    nmap("<leader>?", function()
      vim.o.spell = not vim.o.spell
    end)
  end,
}
