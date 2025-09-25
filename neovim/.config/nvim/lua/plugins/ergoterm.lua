-- terminals
-- https://github.com/waiting-for-dev/ergoterm.nvim

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

local function make_start(direction)
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

local function choose()
  local terminals = require("ergoterm.terminal").get_all()
  local snacks = require("snacks")
  local preview = require("snacks.picker.preview").file

  if #terminals == 0 then
    return
  end

  local function make_run_action(direction)
    return function(picker, item)
      picker:close()
      if item:is_active() then
        item:close()
      end
      item:focus(direction)
    end
  end

  snacks.picker({
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

    actions = {
      open_horizontal = make_run_action("below"),
      open_vertical = make_run_action("right"),
      open_tab = make_run_action("tab"),
      open_float = make_run_action("float"),
      close = function(picker, item)
        picker:close()
        item:close()
        vim.schedule(choose)
      end,
      shutdown = function(picker, item)
        picker:close()
        item:stop()
        item:cleanup()
        vim.schedule(choose)
      end,
    },

    confirm = make_run_action("right"),

    win = {
      input = {
        keys = {
          ["<c-s>"] = {
            "open_horizontal",
            mode = { "n", "i" },
            desc = "Open in horizontal split",
          },
          ["<c-v>"] = {
            "open_vertical",
            mode = { "n", "i" },
            desc = "Open in vertical split",
          },
          ["<c-t>"] = {
            "open_tab",
            mode = { "n", "i" },
            desc = "Open in tab",
          },
          ["<c-f>"] = {
            "open_float",
            mode = { "n", "i" },
            desc = "Open in float window",
          },
          ["<c-q>"] = {
            "close",
            mode = { "n", "i" },
            desc = "Close terminal",
          },
          ["<c-d>"] = {
            "shutdown",
            mode = { "n", "i" },
            desc = "Shutdown terminal",
          },
        },
      },
    },
  })
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
      "<leader>]]",
      make_start("right"),
      desc = "Open new vertical terminal",
    },
    {
      "<leader>]s",
      make_start("below"),
      desc = "Open new horizontal terminal",
    },
    {
      "<leader>]t",
      make_start("tab"),
      desc = "Open new terminal in tab",
    },
    {
      "<leader>]f",
      make_start("float"),
      desc = "Open new floating terminal",
    },
    {
      "<leader>t]",
      choose,
      desc = "Choose terminal",
    },
    {
      "<A-z>",
      function()
        local term = require("ergoterm.terminal").identify()
        if term then
          term:close()
        end
      end,
      ft = "Ergoterm",
      desc = "Close terminal",
    },
    {
      "<A-q>",
      function()
        local term = require("ergoterm.terminal").identify()
        if term then
          term:stop()
          term:cleanup()
        end
      end,
      ft = "Ergoterm",
      desc = "Shutdown terminal",
    },
  },

  opts = function()
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

          local function set(lhs, rhs)
            vim.keymap.set("t", lhs, rhs, {
              buffer = term._state.bufnr,
              noremap = true,
              silent = true,
            })
          end

          vim.api.nvim_create_autocmd("TermEnter", {
            buffer = term._state.bufnr,
            callback = function()
              local opts = vim.wo[term._state.window]
              opts.winbar = term.name
              opts.list = false
            end,
          })
          vim.api.nvim_create_autocmd("TermLeave", {
            buffer = term._state.bufnr,
            callback = function()
              vim.wo[term._state.window].winbar = " " .. term.name
            end,
          })

          set("<Esc><Esc>", "<c-\\><c-n>")
          set(
            "<A-a>",
            "<c-\\><c-n><cmd>lua require('snacks.zen').zoom()<cr><cmd>startinsert<cr>"
          )
          set("<A-z>", function()
            term:close()
          end)
          set("<A-q>", function()
            term:stop()
            term:cleanup()
          end)
          set("<C-h>", "<cmd>wincmd h<cr>")
          set("<C-j>", "<cmd>wincmd j<cr>")
          set("<C-k>", "<cmd>wincmd k<cr>")
          set("<C-l>", "<cmd>wincmd l<cr>")
        end,
      },
    }
  end,
}
