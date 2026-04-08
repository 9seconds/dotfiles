-- simple statusline
-- https://github.com/nvim-mini/mini.statusline

require("_.pack").add({
  url = "https://github.com/nvim-mini/mini.statusline",
  releases = true,
  lazy = true,
  config = function()
    local mod = require("mini.statusline")

    mod.setup({
      active = function()
            local mode, mode_hl = mod.section_mode({ trunc_width = 120 })
          local git           = mod.section_git({ trunc_width = 40 })
          local diff          = mod.section_diff({ trunc_width = 75 })
          local diagnostics   = mod.section_diagnostics({ trunc_width = 75 })
          local filename      = mod.section_filename({ trunc_width = 140 })
          local fileinfo      = mod.section_fileinfo({ trunc_width = 120 })
          local location      = mod.section_location({ trunc_width = 75 })
          local search        = mod.section_searchcount({ trunc_width = 75 })

    return mod.combine_groups({
      { hl = mode_hl,                  strings = { mode } },
      { hl = 'MiniStatuslineDevinfo',  strings = { git, diff, diagnostics } },
      '%<', -- Mark general truncate point
      { hl = 'MiniStatuslineFilename', strings = { filename } },
      '%=', -- End left alignment
      { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
      { hl = mode_hl,                  strings = { search, location } },
    })
      end
    })
  end
})
