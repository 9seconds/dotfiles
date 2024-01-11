local M = {}

function M.setup()
  vim.o.linespace = 2
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 15
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 10
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_no_idle = false
  vim.g.neovide_input_macos_alt_is_meta = true
  vim.g.neovide_touch_deadzone = 6
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.2
  vim.g.neovide_cursor_antialiasing = true

  vim.keymap.set("n", "<A-->", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * (1 / 1.1)
  end, {desc = "Increase Neovide editor font"})

  vim.keymap.set("n", "<A-+>", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.1
  end, {desc = "Decrease Neovide editor font"})

  vim.keymap.set("n", "<A-=>", function()
    vim.g.neovide_scale_factor = 1.0
  end, {desc = "Return Neovide back to normal font"})
end

return M
