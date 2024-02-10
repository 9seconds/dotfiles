-- different key settings

local wezterm = require("wezterm")
local act = wezterm.action


return function(config)
  -- https://wezfurlong.org/wezterm/config/default-keys.html
  config.disable_default_key_bindings = false

  -- https://wezfurlong.org/wezterm/config/keys.html#leader-key
  config.leader = {
    key = "Space",
    mods = "CMD|SHIFT",
    timeout_milliseconds = 1000
  }

  -- https://wezfurlong.org/wezterm/config/keys.html
  config.keys = {
    {  -- CMD+Option+Space+Space sends leader combination
      key = "Space",
      mods = "LEADER|CMD|SHIFT",
      action = act.SendKey({
        key = "Space",
        mods = "CMD|SHIFT"
      })
    },
    {
      key = "p",
      mods = "CMD",
      action = act.ActivateCommandPalette
    }

  }
end
