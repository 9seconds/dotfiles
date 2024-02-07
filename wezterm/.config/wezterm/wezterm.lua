local wezterm = require("wezterm")
local config = wezterm.config_builder()

local fonts_configure = require("fonts")
fonts_configure(config)

local visuals_configure = require("visuals")
visuals_configure(config)

local events_configure = require("events")
events_configure(config)

return config
