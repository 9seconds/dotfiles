-- fonts
-- https://wezfurlong.org/wezterm/config/fonts.html

local wezterm = require("wezterm")

return function(config)
  -- use Fira Code and fallback to default font
  -- https://wezfurlong.org/wezterm/config/lua/config/font.html
  -- https://wezfurlong.org/wezterm/config/lua/wezterm/font_with_fallback.html
  -- https://wezfurlong.org/wezterm/config/lua/wezterm/font.html
  config.font = wezterm.font_with_fallback({
    {
      family = "Fira Code",
      weight = 450, -- retina
    },
    "Fira Code",
  })

  -- https://wezfurlong.org/wezterm/config/lua/config/font_size.html
  config.font_size = 13

  -- https://wezfurlong.org/wezterm/config/lua/config/freetype_load_target.html
  config.freetype_load_target = "Normal"

  -- https://wezfurlong.org/wezterm/config/lua/config/line_height.html
  config.line_height = 1.2
end
