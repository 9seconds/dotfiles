<<<<<<< HEAD
local wezterm = require("wezterm")
local config = wezterm.config_builder()

local fonts_configure = require("fonts")
fonts_configure(config)

local visuals_configure = require("visuals")
visuals_configure(config)

local events_configure = require("events")
events_configure(config)

return config
||||||| 958fcc7
=======
local wezterm = require("wezterm")
local config = wezterm.config_builder()

local fonts_configure = require("fonts")
fonts_configure(config)

local visuals_configure = require("visuals")
visuals_configure(config)

local events_configure = require("events")
events_configure(config)

local keys_configure = require("keys")
keys_configure(config)

local ok, local_configure = pcall(require, "local")
if ok then
  local_configure(config)
else
  wezterm.log_warn("Cannot load local configuration", local_configure)
end

return config
>>>>>>> origin/wezterm
