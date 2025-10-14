-- terminals
-- https://github.com/waiting-for-dev/ergoterm.nvim

local KEYS = {
  close = "z",
  quit = "q",
  choose = "o",

  right = "]",
  below = "s",
  tab = "t",
  float = "f",

  alt = function(self, mapping)
    return string.format("<A-%s>", self[mapping])
  end,
  ctrl = function(self, mapping)
    return string.format("<c-%s>", self[mapping])
  end,
}

local function generate_name()
  local shuf_cmd = {
    vim.o.shell,
    vim.o.shellcmdflag,
    "sort -R /usr/share/dict/words | head -n 1",
  }

  if vim.fn.executable("shuf") == 1 then
    shuf_cmd = { "shuf", "-n", "1", "/usr/share/dict/words" }
  elseif vim.fn.executable("gshuf") == 1 then
    shuf_cmd = { "gshuf", "-n", "1", "/usr/share/dict/words" }
  end

  local words = vim.system(shuf_cmd, { text = true }):wait(2000)

  if words.code ~= 0 then
    vim.notify(
      string.format("Failed to get random word: %s", words.stderr),
      vim.log.levels.ERROR,
      { title = "ergoterm" }
    )
    return
  end

  local title = vim.trim(words.stdout)
  title = title:lower()
  title = vim.fn.shellescape(title)

  return title
end

local function term_open(direction)
  return function()
    vim.cmd(
      string.format(
        "TermNew auto_scroll=true layout=%s name=%s",
        direction,
        generate_name()
      )
    )
  end
end

local function term_close(term)
  if not term then
    term = require("ergoterm.terminal").identify()
  end
  if term then
    term:close()
  end
end

local function term_quit(term)
  if not term then
    term = require("ergoterm.terminal").identify()
  end
  if term then
    term:stop()
    term:cleanup()
  end
end

local function choose()
  local terminals = require("ergoterm.terminal").get_all()
  local snacks = require("snacks")
  local preview = require("snacks.picker.preview").file

  if #terminals == 0 then
    return
  end

  for _, term in ipairs(terminals) do
    term.text = term.name
  end

  local snacks_config = {
    title = "Choose terminal",
    items = terminals,

    preview = function(ctx)
      ctx.item.buf = ctx.item._state.bufnr
      preview(ctx)
      return true
    end,

    format = function(item)
      local ago = vim.fn.reltimefloat(vim.fn.reltime(item._state._created_at))
      local seconds = math.fmod(ago, 60)

      ago = (ago - seconds) / 60
      local minutes = math.fmod(ago, 60)
      ago = (ago - minutes) / 60

      seconds = math.floor(seconds)
      minutes = math.floor(minutes)
      local hours = math.floor(math.fmod(ago, 60))
      local days = math.fmod(hours, 24)

      local reltime = ""
      if days > 0 then
        reltime = string.format(" %d days ago ", days)
      elseif hours > 6 then
        reltime = string.format(" %d hours ago ", hours)
      elseif hours > 0 then
        reltime = string.format(" %d hours, %d minutes ago ", hours, minutes)
      elseif minutes > 0 then
        reltime = string.format(" %d minutes ago ", minutes)
      else
        reltime = string.format(" %d seconds ago", seconds)
      end

      return {
        { string.format("%d:", item.id), "SnacksPickerLabel" },
        { string.format(" %s ", item.name), "SnacksPickerBold" },
        { reltime, "SnacksPickerComment" },
      }
    end,

    actions = {},
    win = {
      input = {
        keys = {},
      },
    },
  }

  local function make_snacks_action(func)
    return function(picker, item)
      picker:close()
      func(item)
    end
  end

  local function make_open_action(direction)
    return function(item)
      if item:is_active() then
        item:close()
      end
      item:focus(direction)
    end
  end

  local function add_action(key, func)
    local name = "press_" .. key

    snacks_config.actions[name] = make_snacks_action(func)
    snacks_config.win.input.keys[KEYS:alt(key)] = {
      name,
      mode = { "n", "i" },
    }
    snacks_config.win.input.keys[KEYS:ctrl(key)] = {
      name,
      mode = { "n", "i" },
    }
  end

  add_action("right", make_open_action("right"))
  add_action("below", make_open_action("below"))
  add_action("tab", make_open_action("tab"))
  add_action("float", make_open_action("float"))
  add_action("close", function(term)
    term_close(term)
    vim.schedule(choose)
  end)
  add_action("quit", function(term)
    term_quit(term)
    vim.schedule(choose)
  end)
  snacks_config.confirm = make_snacks_action(make_open_action("right"))

  snacks.picker(snacks_config)
end

return {
  "waiting-for-dev/ergoterm.nvim",
  dependencies = {
    "folke/snacks.nvim",
  },
  version = "*",
  cmd = {
    "TermNew",
    "TermSelect",
    "TermSend",
    "TermUpdate",
    "TermToggleUniversalSelection",
  },
  keys = {
    {
      KEYS:alt("right"),
      term_open("right"),
      desc = "Open new vertical terminal",
    },
    {
      KEYS:alt("below"),
      term_open("below"),
      desc = "Open new horizontal terminal",
    },
    {
      KEYS:alt("tab"),
      term_open("tab"),
      desc = "Open new terminal in tab",
    },
    {
      KEYS:alt("float"),
      term_open("float"),
      desc = "Open new floating terminal",
    },
    {
      KEYS:alt("choose"),
      choose,
      desc = "Choose terminal",
    },
    {
      KEYS:alt("close"),
      function()
        local term = require("ergoterm.terminal").get_last_focused()
        if term then
          term:toggle()
        end
      end,
      mode = { "t", "n", "v", "x", "i" },
      desc = "Toggle last focused terminal",
    },
    {
      KEYS:alt("quit"),
      term_quit,
      ft = "Ergoterm",
      desc = "Shutdown terminal",
    },
  },

  opts = function()
    local function set_keys(term)
      local function set(lhs, rhs)
        vim.keymap.set("t", lhs, rhs, {
          buffer = term._state.bufnr,
          noremap = true,
          silent = true,
        })
      end

      set(KEYS:alt("right"), term_open("right"))
      set(KEYS:alt("below"), term_open("below"))
      set(KEYS:alt("tab"), term_open("tab"))
      set(KEYS:alt("float"), term_open("float"))
      set(KEYS:alt("choose"), choose)
      set(KEYS:alt("quit"), term_quit)
      set("<C-h>", "<cmd>wincmd h<cr>")
      set("<C-j>", "<cmd>wincmd j<cr>")
      set("<C-k>", "<cmd>wincmd k<cr>")
      set("<C-l>", "<cmd>wincmd l<cr>")
    end

    local function set_autocommands(term)
      vim.api.nvim_create_autocmd("TermEnter", {
        buffer = term._state.bufnr,
        callback = function()
          local opts = vim.wo[term._state.window]
          opts.winbar = term.name
          opts.list = false
          opts.number = false
        end,
      })
      vim.api.nvim_create_autocmd("TermLeave", {
        buffer = term._state.bufnr,
        callback = function()
          local opts = vim.wo[term._state.window]
          opts.number = true
        end,
      })
    end

    return {
      terminal_defaults = {
        shell = vim.env.SHELL or vim.o.shell or "/bin/bash",
        layout = "right",
        dir = "git_dir",
        persist_mode = false,
        start_in_insert = true,

        float_opts = {
          height = math.floor(vim.o.lines * 0.85),
          width = math.floor(vim.o.columns * 0.85),
        },
        float_winblend = 0,

        on_create = function(term)
          term._state._created_at = vim.fn.reltime()
          set_autocommands(term)
          set_keys(term)
        end,
      },
    }
  end,
}
