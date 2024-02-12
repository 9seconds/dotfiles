-- different events handlers

local wezterm = require("wezterm")

-- mapping of charging / battery bucket (number of tens) to a nerdfont icon
local BATTERY_INDICATORS = {
  [false] = { -- charging
    wezterm.nerdfonts.md_battery_10,
    wezterm.nerdfonts.md_battery_20,
    wezterm.nerdfonts.md_battery_30,
    wezterm.nerdfonts.md_battery_40,
    wezterm.nerdfonts.md_battery_50,
    wezterm.nerdfonts.md_battery_60,
    wezterm.nerdfonts.md_battery_70,
    wezterm.nerdfonts.md_battery_80,
    wezterm.nerdfonts.md_battery_90,
    wezterm.nerdfonts.md_battery,
  },
  [true] = { -- charging
    wezterm.nerdfonts.md_battery_charging_10,
    wezterm.nerdfonts.md_battery_charging_20,
    wezterm.nerdfonts.md_battery_charging_30,
    wezterm.nerdfonts.md_battery_charging_40,
    wezterm.nerdfonts.md_battery_charging_50,
    wezterm.nerdfonts.md_battery_charging_60,
    wezterm.nerdfonts.md_battery_charging_70,
    wezterm.nerdfonts.md_battery_charging_80,
    wezterm.nerdfonts.md_battery_charging_90,
    wezterm.nerdfonts.md_battery_charging_100,
  },
}

-- a percentage when we need to mark battery as yellow
local BATTERY_WARNING = 25

-- a percentage when we need to mark battery as red
local BATTERY_CRITICAL = 10

-- a percentage when we consider battery as charged enough
local BATTERY_OK = 95

-- default max width of a title if nothing is defined
local DEFAULT_MAX_WIDTH = 255

function basename(str)
  return string.gsub(str, "(.*[/\\])(.*)", "%2")
end

local function get_process_name(pane)
  if pane.user_vars.IS_SSH == "1" then
    return basename(pane.user_vars.CMD)
  end

  return basename(pane.foreground_process_name)
end

local function get_pwd(pane)
  local home = wezterm.home_dir
  local path

  if pane.user_vars.IS_SSH == "1" then
    home = pane.user_vars.HOME
    path = pane.user_vars.PWD
  elseif pane.current_working_dir then
    path = pane.current_working_dir.file_path
  end

  if not path then
    return
  end

  return string.gsub(path, home, "~")
end

local function format_tab_title(tab, tabs, _, config, _, max_width)
  if tab.tab_title ~= "" then
    return tab.tab_title
  end

  local pane = tab.active_pane
  local process = get_process_name(pane)
  local pwd = get_pwd(pane)

  if not pwd then
    return
  end

  local tabref = tab.tab_index + 1
  local title = string.format(" %d: %s ➜ %s ", tabref, process, pwd)

  if #title > config.tab_max_width then
    title = wezterm.truncate_right(title, config.tab_max_width - 2) .. "… "
  end

  return title
end

local function format_window_title(win, pane)
  local pane_obj = wezterm.mux.get_pane(pane.pane_id)

  local domain = pane_obj:get_domain_name()
  local window = pane_obj:window()

  if not window then
    return domain
  end

  return domain .. ": " .. window:get_workspace()
end

local function right_statusline(win, pane)
  local ok, domain = pcall(pane.get_domain_name, pane)
  if not ok then
    return
  end

  local texts = {
    { Background = { AnsiColor = "White" } },
    { Foreground = { AnsiColor = "Black" } },
    { Text = " " .. pane:get_domain_name() .. " " },

    { Background = { AnsiColor = "Blue" } },
    { Foreground = { AnsiColor = "Black" } },
    { Text = " " .. win:active_workspace() .. " " },
    "ResetAttributes",
  }

  if not win:get_dimensions().is_full_screen then
    win:set_right_status(wezterm.format(texts))
    return
  end

  table.insert(texts, {
    Text = " " .. wezterm.strftime("%a, %d %b %H:%M ") .. " ",
  })

  for _, battery in ipairs(wezterm.battery_info()) do
    local is_charging = battery.state == "Full" or battery.state == "Charging"
    local percent = 100
      * (battery.state == "Full" and 1 or battery.state_of_charge)

    local icon = BATTERY_INDICATORS[is_charging][math.floor(percent / 10)]

    if percent < BATTERY_CRITICAL then
      table.insert(texts, { Foreground = { AnsiColor = "Red" } })
    elseif percent < BATTERY_WARNING then
      table.insert(texts, { Foreground = { AnsiColor = "Yellow" } })
    elseif percent > BATTERY_OK then
      table.insert(texts, { Foreground = { AnsiColor = "Green" } })
    end

    table.insert(texts, {
      Text = string.format("%s %.0f%% ", icon, math.floor(percent)),
    })
    table.insert(texts, "ResetAttributes")
  end

  win:set_right_status(wezterm.format(texts))
end

local function set_left_statusline(win, pane)
  local ok, user_vars = pcall(pane.get_user_vars, pane)
  if not ok then
    win:set_left_status("")
    return
  end

  local text = ""

  if user_vars.IS_SSH == "1" then
    text = wezterm.format({
      { Background = { AnsiColor = "Yellow" } },
      { Foreground = { AnsiColor = "Black" } },
      { Text = " " .. user_vars.HOSTNAME .. " " },
    })
  end

  win:set_left_status(text)
end

local function set_gpu(win)
  local overrides = win:get_config_overrides() or {}

  if not win:is_focused() then
    overrides.webgpu_power_preference = "LowPower"
    win:set_config_overrides(overrides)
    return
  end

  for _, bat in ipairs(wezterm.battery_info()) do
    if bat.state == "Full" or bat.state == "Charging" then
      overrides.webgpu_power_preference = "HighPerformance"
      win:set_config_overrides(overrides)
      return
    end
  end

  overrides.webgpu_power_preference = "LowPower"
  win:set_config_overrides(overrides)
end

return function(config)
  -- https://wezfurlong.org/wezterm/config/lua/config/status_update_interval.html
  config.status_update_interval = 500 -- each half of second

  wezterm.on("update-right-status", right_statusline)
  wezterm.on("update-status", set_gpu)
  wezterm.on("update-status", set_left_statusline)
  wezterm.on("format-tab-title", format_tab_title)
  wezterm.on("format-window-title", format_window_title)
end
