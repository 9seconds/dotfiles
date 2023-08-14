-- This module contains user commands

local M = {}


function M.setup()
  if vim.fn.executable("rg") then
    vim.o.grepprg = "rg --vimgrep --follow --trim --smart-case --color never"
  elseif vim.fn.executable("ag") then
    vim.o.grepprg = "ag --vimgrep --nocolor --follow --smart-case"
  end

  vim.cmd("command! -nargs=+ -complete=file Grep noautocmd grep! <args> | redraw! | copen")
  vim.cmd("command! -nargs=+ -complete=file LGrep noautocmd lgrep! <args> | redraw! | lopen")

  vim.api.nvim_create_user_command("RepoLink", function(args)
    require("_.commands.repo_link").make({
      branch = args.fargs[1],
      repo = args.fargs[2] or "origin",
      start_line = args.line1,
      end_line = args.line2,
    })
  end, {
    nargs = "?",
    range = true,
  })
end


return M
