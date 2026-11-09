-- terminals
-- https://github.com/waiting-for-dev/ergoterm.nvim

vim.pack.add({
  {
    src = "https://github.com/waiting-for-dev/ergoterm.nvim",
    version = vim.version.range("*"),
  },
})

require("ergoterm").setup({
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
      vim.keymap.set("t", "<A-e>", "<Esc>", {
        buffer = term._state.bufnr,
        noremap = true,
        silent = true,
        desc = "Send Escape to terminal",
      })

      local registers = {
        ["+"] = "System clipboard",
        ["*"] = "Selection clipboard",
        ['"'] = "Default register",
      }
      for register, desc in pairs(registers) do
        vim.keymap.set("t", "<A-p>" .. register, '<C-\\><C-o>"' .. register .. "p", {
          buffer = term._state.bufnr,
          silent = true,
          desc = desc,
        })
      end

      local buf = term._state.bufnr
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

local function setup(key, conf)
  local keybind = string.format("<C-%s>", key)
  local term = require("ergoterm"):new(vim.tbl_deep_extend("force", {
      on_open = function (term)
        local state = term._state

        local function tset(lhs, rhs)
          vim.keymap.set("t", lhs, rhs, {
            buffer = state.bufnr,
            noremap = true,
            silent = true,
          })
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

        tset(keybind, function ()
          term:toggle()
        end)
        tset("<C-h>", "<cmd>wincmd h<cr>")
        tset("<C-j>", "<cmd>wincmd j<cr>")
        tset("<C-k>", "<cmd>wincmd k<cr>")
        tset("<C-l>", "<cmd>wincmd l<cr>")
      end,
    }, conf or {}
    ))

  vim.keymap.set("n", keybind, function () term:toggle() end, { noremap = true, silent = true })
end

local function keymap(desc, mode, key, fn)
  vim.keymap.set(mode, "<leader>k" .. key, fn, {
    noremap = true,
    silent = true,
    desc = "ErgoTerm: " .. desc,
  })
end

local function get_term()
  local term = require("ergoterm").get_state("last_focused")
  if term and term:is_started() then
    return term
  end
end

keymap("Send a filename to the terminal", "n", "f", function ()
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

keymap("Send 'this' to terminal", "n", "t", function ()
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

keymap("Send 'this' to terminal", "x", "t", function ()
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
end)

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
