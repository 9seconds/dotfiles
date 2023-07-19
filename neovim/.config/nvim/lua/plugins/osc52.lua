-- use OSC52 to copy back to a system clipboard
-- https://github.com/ojroques/nvim-osc52


local function copy(lines, _)
  require("osc52").copy(table.concat(lines, "\n"))
end

local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end


return {
  "ojroques/nvim-osc52",
  main = "osc52",
  event = "VeryLazy",

  config = function()
    require("osc52").setup({})

    vim.g.clipboard = {
      name = "osc52",
      copy = {
        ["+"] = copy,
        ["*"] = copy,
      },
      paste = {
        ["+"] = paste,
        ["*"] = paste,
      },
    }
  end
}
