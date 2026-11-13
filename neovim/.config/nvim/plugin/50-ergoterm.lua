-- terminals
-- https://github.com/waiting-for-dev/ergoterm.nvim

vim.pack.add({
  {
    src = "https://github.com/waiting-for-dev/ergoterm.nvim",
    version = vim.version.range("*"),
  },
})

local mod = require("ergoterm")
local keymap = require("_.utils").keymap("ErgoTerm")
local leader_keymap = require("_.utils").keymap("Ergoterm", "<leader>k")

mod.setup({
  -- https://github.com/waiting-for-dev/ergoterm.nvim/tree/main#terminal-defaults
  terminal_defaults = {
    shell = vim.env.SHELL or vim.o.shell or "/bin/bash",
    layout = "right",
    dir = "git_dir",
    auto_scroll = true,
    exclusive_layout = true,
    start_in_insert = true,
    persist_size = false,
    watch_files = true,

    float_opts = {
      title = "",
    },

    on_start = function (term)
      local buf = term._state.bufnr

      local function tset(desc, key, callback)
        keymap(desc, key, callback, "t", { buffer = buf })
      end

      tset("Send Esc to the terminal", "<A-e>", "<Esc>")

      local registers = {
        ["+"] = "system clipboard",
        ["*"] = "selection clipboard",
        ['"'] = "default register",
      }
      for register, desc in pairs(registers) do
        tset("Paste from " .. desc, "<A-p>" .. register, "<C-\\><C-o>" .. register .. "p")
      end

      local config = vim.b[buf].miniclue_config or {}
      config.triggers = config.triggers or {}
      table.insert(config.triggers, { mode = "t", keys = "<A-p>" })
      vim.b[buf].miniclue_config = config

      require("mini.clue").ensure_buf_triggers(buf)
    end,

    float_opts = {
      height = math.floor(vim.o.lines * 0.85),
      width = math.floor(vim.o.columns * 0.85),
    },
  },
})

-- ----------------------------------------------------------------------------

local function toggle_terminal(term)
  local others = mod.filter(function (other)
    return other ~= term and other:is_open()
  end)

  for _, other in ipairs(others) do
    other:close()
  end

  if #others > 0 then
    term:focus()
  else
    term:toggle()
  end
end

local function setup(key, conf)
  local keybind = string.format("<C-%s>", key)

  local term = mod:new(vim.tbl_deep_extend("force", {
      on_open = function (term)
        local state = term._state

        local function tset(description, key, callback)
          keymap(description, key, callback, "t", { buffer = state.bufnr })
        end

        vim.api.nvim_create_autocmd("TermEnter", {
          buffer = state.bufnr,
          callback = function ()
            local opts = vim.wo[state.window]
            opts.list = false
            opts.number = false
          end,
        })
        vim.api.nvim_create_autocmd("TermLeave", {
          buffer = state.bufnr,
          callback = function ()
            local opts = vim.wo[state.window]
            opts.number = true
          end,
        })

        tset("Go to the left", "<C-h>", "<cmd>wincmd h<cr>")
        tset("Go to the right", "<C-j>", "<cmd>wincmd j<cr>")
        tset("Go down", "<C-k>", "<cmd>wincmd k<cr>")
        tset("Go up", "<C-l>", "<cmd>wincmd l<cr>")
      end,
    }, conf or {}
    ))

  keymap(
    "Toggle " .. keybind .. " terminal", keybind, function () toggle_terminal(term) end,
    { "n", "i", "v", "t" }
  )
end

local function get_term()
  local term = mod.get_state("last_focused")
  if term and term:is_started() then
    return term
  end
end

leader_keymap("Send a filename to the terminal", "f", function ()
  local term = get_term()
  if not term then
    return
  end

  local file = vim.fn.expand("%:p")
  if file == "" then
    return
  end

  if term.name == "ai" then
    local dir = term._state.dir or vim.uv.cwd()
    file = "@" .. (vim.fs.relpath(dir, file) or file)
  end

  term:send({ file .. " " }, { trim = false, new_line = false })
end)

leader_keymap("Send 'this' to terminal", "t", function ()
  local term = get_term()
  if not term then
    return
  end

  if term.name ~= "ai" then
    term:send("single_line", { trim = false })
    return
  end

  local file = vim.fn.expand("%:p")
  if file == "" then
    return
  end

  local dir = term._state.dir or vim.uv.cwd()
  file = vim.fs.relpath(dir, file) or file
  local line = vim.api.nvim_win_get_cursor(0)[1]

  term:send({ "@" .. file .. "#" .. line .. " " }, { trim = false, new_line = false })
end)

leader_keymap("Send 'this' to terminal", "t", function ()
  local term = get_term()
  if not term then
    return
  end

  if term.name ~= "ai" then
    term:send("visual_selection", { trim = false })
    return
  end

  local file = vim.fn.expand("%:p")
  if file == "" then
    return
  end

  local first = vim.fn.getpos("v")
  local last = vim.fn.getpos(".")
  local opts = { type = vim.fn.mode() }

  local region = vim.fn.getregionpos(first, last, opts)
  if #region == 0 then
    return
  end

  local dir = term._state.dir or vim.uv.cwd()
  file = vim.fs.relpath(dir, file) or file
  local start_line = region[1][1][2]
  local end_line = region[#region][1][2]
  local reference = string.format("@%s#%d-%d ", file, start_line, end_line)

  term:send({ reference }, { trim = false, new_line = false })
end, "x"
)

-- ----------------------------------------------------------------------------

setup(",", {
  name = "alpha",
  layout = "right",
})
setup("/", {
  name = "beta",
  layout = "below",
})

if vim.fn.executable("opencode") == 1 then
  setup(".", {
    name = "ai",
    layout = "right",
    cmd = "opencode",
    env = {
      OPENCODE_CLI_CONFIG_CONTENT = '{"tabs":{"mode":"off"}}',
    },
  })
end

if vim.fn.executable("lazygit") == 1 then
  setup("'", {
    name = "git",
    layout = "float",
    cmd = "lazygit",
  })
end
