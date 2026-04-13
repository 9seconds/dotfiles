-- This module contains user commands

local function setup()
  if vim.fn.executable("rg") then
    vim.o.grepprg = "rg --vimgrep --follow --trim --smart-case --color never"
  elseif vim.fn.executable("ag") then
    vim.o.grepprg = "ag --vimgrep --nocolor --follow --smart-case"
  end

  vim.cmd(
    "command! -nargs=+ -complete=file Grep noautocmd grep! <args> | redraw! | copen"
  )
  vim.cmd(
    "command! -nargs=+ -complete=file LGrep noautocmd lgrep! <args> | redraw! | lopen"
  )

  vim.api.nvim_create_user_command("PackUpdate", function()
    vim.pack.update()
  end, {
    desc = "Update all plugins",
  })

  vim.api.nvim_create_user_command("PackLock", function()
    vim.pack.update(nil, { target = "lockfile" })
  end, {
    desc = "Install from a lockfile",
  })
end

setup()
