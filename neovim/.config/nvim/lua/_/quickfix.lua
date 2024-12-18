-- simple quickfix wrapper that ate more time than I expected but at least now
-- I know vim a bit better.

local KEEP_LOCLIST = false
local LAST_SEEN_TICKS = {}

local function open_win(cmd)
  local win = vim.api.nvim_get_current_win()
  vim.cmd[cmd]()
  vim.api.nvim_set_current_win(win)
end

local function setup_handlers()
  vim.diagnostic.handlers["loclist"] = {
    show = vim.schedule_wrap(function()
      vim.diagnostic.setloclist({ open = false })
    end),
  }
end

local function setup_autocommands()
  local group = vim.api.nvim_create_augroup("9_Quickfix", {})

  vim.api.nvim_create_autocmd("WinEnter", {
    group = group,
    -- schedule_wrap is required because many operations with windows
    -- cannot be made outside of main loop. for example, you can close
    -- windows you do not like but meanwhile, if you are in the middle of
    -- opening a new window, you can't close them. it happens, for example,
    -- if you open something new with telescope. at the same time,
    -- there are times when you can't split a window if a window close is
    -- pending.
    --
    -- i would be happy if there was a way how to avoid that but meanwhile
    -- execution within a main loop looks legit.
    callback = vim.schedule_wrap(function()
      local winid = vim.fn.win_getid()
      local wininfo = vim.fn.getwininfo(winid)[1]
      -- nothing should be done if current window is either terminal or
      -- quickfix. I add them together here because they all are either 1 or
      -- 0, so is sum is 0, it means that everything is 0.
      if wininfo.terminal + wininfo.quickfix > 0 then
        return
      end

      -- unfortunately, DiagnosticChanged for some reason plays badly
      -- with nvim-lint, so we have to refresh this window on each.
      -- LAST_SEEN_TICKS is a table that contains a mapping between
      -- window id and last seen ticks. This is required to avoid
      -- refreshing if nothing has been changed.
      if (LAST_SEEN_TICKS[winid] or 0) < vim.b.changedtick then
        vim.diagnostic.setloclist({ open = false })
        LAST_SEEN_TICKS[winid] = vim.b.changedtick
      end

      if KEEP_LOCLIST then
        local current_loc_win = vim.fn.getloclist(0, { winid = 0 }).winid

        -- first of all, if epoch is LOC, we need to close everything
        -- except of current loclist window.
        for _, win in ipairs(vim.fn.getwininfo()) do
          -- quickfix is 1 for both loclist and quickfix :shrug:
          if win.winid ~= current_loc_win and win.loclist == 1 then
            vim.api.nvim_win_close(win.winid, true)
          end
        end

        -- if current epoch is LOC and there is not any open loclist,
        -- try to open it.
        if current_loc_win == 0 then
          open_win("lwindow")
        end
      end
    end),
  })

  -- this autocommand tracks if there is any window except of quickfix
  -- ones. if there are no, then we close a tab. If this is a last tab, we
  -- close whole editor.
  vim.api.nvim_create_autocmd("WinClosed", {
    group = group,
    callback = vim.schedule_wrap(function()
      LAST_SEEN_TICKS[vim.api.nvim_get_current_win()] = nil

      local tabno = vim.api.nvim_get_current_tabpage()
      local has_other_tabs = false

      for _, win in ipairs(vim.fn.getwininfo()) do
        if win.tabnr == tabno and win.quickfix == 0 then
          return
        elseif win.tabnr ~= tabno then
          has_other_tabs = true
        end
      end

      if has_other_tabs then
        vim.cmd.tabclose()
      else
        vim.cmd.quit()
      end
    end),
  })
end

local function setup_keymappings()
  vim.keymap.set("n", "<leader>xo", function()
    local closed = false

    for _, win in ipairs(vim.fn.getwininfo()) do
      if win.loclist == 1 then
        KEEP_LOCLIST = false
        vim.api.nvim_win_close(win.winid, true)
      elseif win.quickfix == 1 then
        vim.api.nvim_win_close(win.winid, true)
        closed = true
      end
    end

    if not closed then
      open_win("copen")
    end
  end, { desc = "Toggle quickfix" })

  vim.keymap.set("n", "<leader>xl", function()
    local closed = false

    for _, win in ipairs(vim.fn.getwininfo()) do
      if win.loclist == 1 then
        KEEP_LOCLIST = false
        closed = true
        vim.api.nvim_win_close(win.winid, true)
      elseif win.quickfix == 1 then
        vim.api.nvim_win_close(win.winid, true)
      end
    end

    if not closed and not vim.tbl_isempty(vim.diagnostic.get()) then
      open_win("lwindow")
      KEEP_LOCLIST = true
    end
  end, { desc = "Toggle loclist" })
end

local function setup()
  setup_handlers()
  setup_autocommands()
  setup_keymappings()
end

setup()
