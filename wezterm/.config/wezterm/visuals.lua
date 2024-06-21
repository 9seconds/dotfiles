-- colors
-- https://wezfurlong.org/wezterm/config/appearance.html

return function(config)
  -- https://wezfurlong.org/wezterm/colorschemes/t/index.html#tokyo-night-storm
  config.color_scheme = "Tokyo Night Storm"

  -- https://wezfurlong.org/wezterm/config/lua/config/initial_cols.html
  config.initial_cols = 270

  -- https://wezfurlong.org/wezterm/config/lua/config/initial_rows.html
  config.initial_rows = 70

  -- https://wezfurlong.org/wezterm/config/lua/config/use_fancy_tab_bar.html
  config.use_fancy_tab_bar = false

  -- https://wezfurlong.org/wezterm/config/lua/config/hide_tab_bar_if_only_one_tab.html
  config.hide_tab_bar_if_only_one_tab = false

  -- https://wezfurlong.org/wezterm/config/lua/config/native_macos_fullscreen_mode.html
  config.native_macos_fullscreen_mode = true

  -- https://wezfurlong.org/wezterm/config/lua/config/window_padding.html
  config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  }

  -- https://wezfurlong.org/wezterm/config/lua/config/front_end.html
  config.front_end = "WebGpu"

  -- https://wezfurlong.org/wezterm/config/lua/config/tab_max_width.html
  config.tab_max_width = 48
end
