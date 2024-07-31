-- This module contains these options you usually expect to be set with
-- :set or vim.o

local function is_gui_attached()
  if vim.g.neovide then
    return true
  end

  local uis = vim.api.nvim_list_uis()
  if vim.tbl_count(uis) == 1 then
    -- Neovide and other editors have std{in,out}_tty properties set to false
    return not (uis[1].stdin_tty or uis[1].stdout_tty)
  end

  return true
end

local function require_osc52()
  if is_gui_attached() then
    return true
  elseif os.getenv("SSH_TTY") then
    return true
  elseif os.getenv("WEZTERM_UNIX_SOCKET") then
    return true
  end

  return false
end

local function setup()
  local utils = require("_.utils")

  -- suggest to reload if file was updated outside
  -- https://neovim.io/doc/user/options.html#'autoread'
  vim.o.autoread = true

  -- keep indentation for a wrapped line
  -- https://neovim.io/doc/user/options.html#'breakindent'
  vim.o.breakindent = true
  vim.o.breakindentopt = "sbr"
  vim.o.showbreak = "↪"

  -- by default we use manual folding
  vim.o.foldmethod = "manual"

  -- Disable mandatory 1 line for cmd
  -- https://neovim.io/doc/user/options.html#'cmdheight'
  vim.o.cmdheight = 0

  -- ruler lines on columns
  -- https://neovim.io/doc/user/options.html#'colorcolumn'
  vim.o.colorcolumn = "80,120"

  -- highlight a line where cursor is placed
  -- https://neovim.io/doc/user/options.html#'cursorline'
  vim.o.cursorline = true

  -- do not use tabs, only spaces
  -- https://neovim.io/doc/user/options.html#'expandtab'
  vim.o.expandtab = true

  -- use global status line
  -- https://neovim.io/doc/user/options.html#'laststatus'
  vim.o.laststatus = 3

  -- show some hidden characters
  -- https://neovim.io/doc/user/options.html#'list'
  vim.o.list = true -- show hidden characters
  vim.o.listchars = "tab:▸ ,trail:⋅,extends:❯,precedes:❮"

  -- show line numbers
  -- https://neovim.io/doc/user/options.html#'number'
  vim.o.number = true

  -- set shell
  -- https://neovim.io/doc/user/options.html#'shell'
  if vim.fn.executable("bash") then
    vim.o.shell = vim.fn.exepath("bash")
  end

  -- what to do with hit-enter pages
  -- https://neovim.io/doc/user/options.html#'shortmess'
  vim.o.shortmess = "FOIWca"

  -- show matching stuff
  -- https://neovim.io/doc/user/options.html#'showmatch'
  vim.o.showmatch = true

  -- do not show active mode.
  -- actually, show but we are going to rely on lualine here instead
  -- https://neovim.io/doc/user/options.html#'showmode'
  vim.o.showmode = false

  -- always reserve a space for a sign column
  -- https://neovim.io/doc/user/options.html#'signcolumn'
  vim.o.signcolumn = "yes"

  -- smartcase search
  -- https://neovim.io/doc/user/options.html#'smartcase'
  vim.o.smartcase = true

  -- always try to smart indent
  -- https://neovim.io/doc/user/options.html#'smartindent'
  vim.o.smartindent = true

  -- smartly recognize when we are going to insert or remove indentation
  -- https://neovim.io/doc/user/options.html#'smarttab'
  vim.o.smarttab = true

  -- enable smoothscroll
  -- https://neovim.io/doc/user/options.html#'smoothscroll'
  vim.o.smoothscroll = true

  -- fix split positions
  -- https://neovim.io/doc/user/options.html#'splitbelow'
  -- https://neovim.io/doc/user/options.html#'splitright'
  -- https://neovim.io/doc/user/options.html#'splitkeep'
  vim.o.splitbelow = true
  vim.o.splitright = true
  vim.o.splitkeep = "screen"

  -- disable swap files
  -- https://neovim.io/doc/user/options.html#'swapfile'
  vim.o.swapfile = false

  -- enable 24bit colors
  -- https://neovim.io/doc/user/options.html#'termguicolors'
  vim.o.termguicolors = true

  -- a period of time to flush to a swap file
  -- https://neovim.io/doc/user/options.html#'updatetime'
  vim.o.updatetime = 100

  if
    os.getenv("WEZTERM_PANE") ~= nil
    and os.getenv("TMUX") == nil
    and os.getenv("ZELLIJ") == nil
  then
    -- https://neovim.io/doc/user/options.html#'termsync'
    -- this just simply does not work well with wezterm multiplexing
    vim.o.termsync = false
  end

  -- always round indentation by a given length
  -- https://neovim.io/doc/user/options.html#'shiftround'
  vim.o.shiftround = true

  -- disable internal pager
  -- https://neovim.io/doc/user/options.html#'more'
  vim.o.more = false

  -- set global indentation
  utils.set_indent(4)

  -- set clipboard
  if require_osc52() then
    local copy = require("vim.ui.clipboard.osc52").copy

    vim.g.clipboard = {
      name = "OSC 52",
      copy = {
        ["+"] = copy("+"),
        ["*"] = copy("*"),
      },
      paste = {
        ["+"] = function() end,
        ["*"] = function() end,
      },
    }
  end
end

setup()
