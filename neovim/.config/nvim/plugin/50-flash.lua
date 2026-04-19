-- flash as a modern leap
-- https://github.com/folke/flash.nvim

vim.pack.add({
  {
    src = "https://github.com/folke/flash.nvim",
    version = vim.version.range("*"),
  },
})

local function keymap(name, key, func, mode)
  if mode == nil then
    mode = { "n", "x", "o" }
  end

  vim.keymap.set(mode, key, func, {
    desc = "Flash: " .. name,
  })
end

local function make_smart_case(value)
  if value:find("%n") then
    return value .. "\\C"
  end
  return value .. "\\c"
end

require("flash").setup({
  search = {
    incremental = true,
  },
  jump = {
    pos = "end",
    autojump = true,
  },
  label = {
    uppercase = false,
    rainbox = {
      enabled = true,
    },
  },
  modes = {
    char = {
      enabled = false,
    },
  },
  remote_op = {
    restore = true,
    motion = true,
  },
})

keymap("Jump to the label", "s", function()
  return require("flash").jump({
    search = {
      mode = make_smart_case,
    },
  })
end)

keymap("Jump to the beginning", "S", function()
  return require("flash").jump({
    mode = function(str)
      return make_smart_case("\\<" .. str)
    end,
  })
end)

keymap("Continue", "gs", function()
  return require("flash").jump({ continue = true })
end)

keymap("Select treesitter", "T", function()
  return require("flash").treesitter()
end)

keymap("Remote", "s", function()
  require("flash").remote()
end, "o"
)
