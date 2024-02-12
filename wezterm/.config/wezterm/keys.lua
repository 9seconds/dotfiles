-- different key settings

local wezterm = require("wezterm")
local act = wezterm.action

return function(config)
  -- https://wezfurlong.org/wezterm/config/default-keys.html
  config.disable_default_key_bindings = true

  -- https://wezfurlong.org/wezterm/config/keys.html
  config.keys = {
    {
      key = "c",
      mods = "CMD",
      action = act.CopyTo("Clipboard"),
    },
    {
      key = "v",
      mods = "CMD",
      action = act.PasteFrom("Clipboard"),
    },

    {
      key = "Enter",
      mods = "CMD",
      action = act.ToggleFullScreen,
    },
    {
      key = "k",
      mods = "CMD",
      action = act.ClearScrollback("ScrollbackOnly"),
    },
    {
      key = "k",
      mods = "CMD|OPT",
      action = act.ClearScrollback("ScrollbackAndViewport"),
    },
    {
      key = "p",
      mods = "CMD",
      action = act.ShowLauncherArgs({ flags = "FUZZY|COMMANDS" }),
    },

    {
      key = "-",
      mods = "CMD",
      action = act.IncreaseFontSize,
    },
    {
      key = "-",
      mods = "CMD|OPT",
      action = act.DecreaseFontSize,
    },
    {
      key = "0",
      mods = "CMD",
      action = act.ResetFontSize,
    },

    {
      key = "n",
      mods = "CMD",
      action = act.SpawnWindow,
    },
    {
      key = "t",
      mods = "CMD",
      action = act.SpawnTab("CurrentPaneDomain"),
    },
    {
      key = "`",
      mods = "CMD",
      action = act.ShowTabNavigator,
    },
    {
      key = "x",
      mods = "CMD",
      action = act.CloseCurrentPane({ confirm = false }),
    },
    {
      key = "x",
      mods = "CMD|OPT",
      action = act.CloseCurrentTab({ confirm = false }),
    },
    {
      key = "d",
      mods = "CMD",
      action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "d",
      mods = "CMD|SHIFT",
      action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
    },

    {
      key = "f",
      mods = "CMD",
      action = act.Search({ CaseSensitiveString = "" }),
    },
    {
      key = "f",
      mods = "CMD|OPT",
      action = act.QuickSelect,
    },

    {
      key = "h",
      mods = "CMD",
      action = act.ActivatePaneDirection("Left"),
    },
    {
      key = "j",
      mods = "CMD",
      action = act.ActivatePaneDirection("Down"),
    },
    {
      key = "k",
      mods = "CMD",
      action = act.ActivatePaneDirection("Up"),
    },
    {
      key = "l",
      mods = "CMD",
      action = act.ActivatePaneDirection("Right"),
    },

    {
      key = "LeftArrow",
      mods = "CMD",
      action = act.AdjustPaneSize({ "Left", 1 }),
    },
    {
      key = "RightArrow",
      mods = "CMD",
      action = act.AdjustPaneSize({ "Right", 1 }),
    },
    {
      key = "UpArrow",
      mods = "CMD",
      action = act.AdjustPaneSize({ "Up", 1 }),
    },
    {
      key = "DownArrow",
      mods = "CMD",
      action = act.AdjustPaneSize({ "Down", 1 }),
    },

    {
      key = "LeftArrow",
      mods = "CMD|OPT",
      action = act.MoveTabRelative(-1),
    },
    {
      key = "RightArrow",
      mods = "CMD|OPT",
      action = act.MoveTabRelative(1),
    },
    {
      key = "UpArrow",
      mods = "CMD|OPT",
      action = act.MoveTab(0),
    },

    {
      key = "z",
      mods = "CMD",
      action = act.TogglePaneZoomState,
    },

    {
      key = "w",
      mods = "CMD",
      action = wezterm.action_callback(function(win1, pane1)
        local workspaces = {}
        for _, v in ipairs(wezterm.mux.get_workspace_names()) do
          table.insert(workspaces, { id = v, label = v })
        end
        table.insert(workspaces, { label = "+ Create new workspace" })

        win1:perform_action(
          act.InputSelector({
            title = "Workspaces",
            choices = workspaces,
            fuzzy = true,
            action = wezterm.action_callback(function(win2, pane2, id, label)
              if not label then
                return
              end

              if id then
                win2:perform_action(act.SwitchToWorkspace({ name = id }), pane2)
                return
              end

              win2:perform_action(
                act.PromptInputLine({
                  description = "Enter a name of the new workspace",
                  action = wezterm.action_callback(
                    function(win3, pane3, line)
                      if line then
                        win3:perform_action(
                          act.SwitchToWorkspace({ name = line }),
                          pane3
                        )
                      end
                    end
                  ),
                }),
                pane2
              )
            end),
          }),
          pane1
        )
      end),
    },
  }

  for i = 1, 9 do
    table.insert(config.keys, {
      key = tostring(i),
      mods = "CMD",
      action = act.ActivateTab(i - 1),
    })
  end

  config.mouse_bindings = {
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "CMD",
      action = wezterm.action_callback(function(win, pane)
        if win:get_selection_text_for_pane(pane) ~= "" then
          win:perform_action(act.ExtendSelectionToMouseCursor("Word"), pane)
        else
          win:perform_action(act.OpenLinkAtMouseCursor, pane)
        end
      end),
    },
    {
      event = { Down = { streak = 3, button = "Left" } },
      action = act.SelectTextAtMouseCursor("SemanticZone"),
      mods = "NONE",
    },
  }
end
