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

config.tls_clients = {
  {
    name = "devx",
    remote_address = "sarkhipov.dev.dc1.apstra.com:9000",
    bootstrap_via_ssh = 'dev',
    local_echo_threshold_ms = 100000,
    accept_invalid_hostnames = true
  }
}

return config
