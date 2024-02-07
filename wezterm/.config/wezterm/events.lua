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
  }
}

-- a percentage when we need to mark battery as yellow
local BATTERY_WARNING = 25

-- a percentage when we need to mark battery as red
local BATTERY_CRITICAL = 10


function basename(str)
  return string.gsub(str, "(.*[/\\])(.*)", "%2")
end


local function battery_status()
  local info = wezterm.battery_info()
  if #info == 0 then
    return
  end

  local percent = 0
  local charging = false

  for _, battery in ipairs(info) do
    if battery.state == "Full" then
      percent = percent + 100
      charging = true
    elseif battery.state == "Charging" then
      percent = percent + battery.state_of_charge * 100
      charging = true
    else
      percent = percent + battery.state_of_charge * 100
    end
  end

  return {
    percent = percent / #info,
    charging = charging,
  }
end


local function right_statusline(win)
  local battery = battery_status()
  local texts = {
    { Text = wezterm.strftime("%a, %d %b %H:%M:%S ") },
    "ResetAttributes"
  }

  if battery ~= nil then
    if battery.percent <= BATTERY_CRITICAL then
      table.insert(texts, { Foreground = {AnsiColor = "Red"} })
    elseif battery.percent <= BATTERY_WARNING then
      table.insert(texts, { Foreground = {AnsiColor = "Yellow"} })
    end

    local ind = BATTERY_INDICATORS[battery.charging][math.floor(battery.percent / 10)]

    table.insert(texts, { Text = ind .. " " })
    table.insert(texts, "ResetAttributes")
  end

  win:set_right_status(wezterm.format(texts))
end


local function set_gpu(win)
  local overrides = win:get_config_overrides() or {}
  local value = "LowPower"

  if win:is_focused() and battery_status().charging then
    value = "HighPerformance"
  end

  overrides.webgpu_power_preference = value

  window:set_config_overrides(overrides)
end


local function format_tab_title(tab, tabs, panes, config, hover, max_width)
  if tab.tab_title ~= "" then
    return tab.tab_title
  end

  local pane = tab.active_pane
  local process = basename(pane.foreground_process_name)
  local working_dir = pane.current_working_dir

  if not working_dir then
    return
  end

  working_dir = string.gsub(working_dir.file_path, os.getenv("HOME"), "~")
  local title = string.format(" %d: %s [%s] ", tab.tab_index, process, working_dir)

  if #title > max_width then
    local base = string.format(" %d: %s [] ", tab.tab_index, process)
    working_dir = wezterm.truncate_right(working_dir, max_width - #base - 2)
    title = string.format(" %d: %s [%s …] ", tab.tab_index, process, working_dir)
  end

  return title
end


return function(config)
  -- https://wezfurlong.org/wezterm/config/lua/config/status_update_interval.html
  config.status_update_interval = 500  -- each half of second

  wezterm.on("update-right-status", right_statusline)
  wezterm.on("update-status", set_gpu)
  wezterm.on("format-tab-title", format_tab_title)
end
