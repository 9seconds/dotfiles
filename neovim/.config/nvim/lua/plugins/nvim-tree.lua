-- file explorer
-- https://github.com/nvim-tree/nvim-tree.lua/

-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#sorting-files-naturally-respecting-numbers-within-files-names
local function natural_cmp(left, right)
  left = left.name:lower()
  right = right.name:lower()

  if left == right then
    return false
  end

  for i = 1, math.max(string.len(left), string.len(right)), 1 do
    local l = string.sub(left, i, -1)
    local r = string.sub(right, i, -1)

    if
      type(tonumber(string.sub(l, 1, 1))) == "number"
      and type(tonumber(string.sub(r, 1, 1))) == "number"
    then
      local l_number = tonumber(string.match(l, "^[0-9]+"))
      local r_number = tonumber(string.match(r, "^[0-9]+"))

      if l_number ~= r_number then
        return l_number < r_number
      end
    elseif string.sub(l, 1, 1) ~= string.sub(r, 1, 1) then
      return l < r
    end
  end
end

return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "ahmedkhalf/project.nvim",
  },
  keys = {
    {
      "<leader>ee",
      "<cmd>NvimTreeToggle<cr>",
    },
    {
      "<leader>ef",
      "<cmd>NvimTreeFindFile<cr>",
    },
  },

  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.o.termguicolors = true
  end,

  opts = {
    sort_by = function(nodes)
      table.sort(nodes, natural_cmp)
    end,
    disable_netrw = true,
    sync_root_with_cwd = true,
    renderer = {
      highlight_git = true,
      highlight_modified = "name",
    },
    view = {
      width = 40,
    },
    git = {
      timeout = 2000,
    },
    modified = {
      enable = true,
    },
    filters = {
      dotfiles = true,
      custom = {
        "^.git$",
      },
    },
  },
}
