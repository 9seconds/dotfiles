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
      family = "Monaspace Neon",
      harfbuzz_features = {
        "ss01",
        "ss02",
        "ss03",
        "ss04",
        "ss05",
        "ss06",
        "ss07",
        "ss08",
        "calt",
        "dlig",
      },
    },
    "Fira Code",
    "Fira Mono",
  })

  -- https://wezfurlong.org/wezterm/config/lua/config/font_size.html
  config.font_size = 13

  -- https://wezfurlong.org/wezterm/config/lua/config/freetype_load_target.html
  config.freetype_load_target = "Normal"

  -- https://wezfurlong.org/wezterm/config/lua/config/line_height.html
  config.line_height = 1.3
end
