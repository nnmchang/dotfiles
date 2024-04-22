local wezterm = require("wezterm")

function fullscreen_tab_hide(window)
  local window_dims = window:get_dimensions()
  print(window:toggle_fullscreen())
end

function toggle_enable_tab_bar(window)
  local overrides = window:get_config_overrides() or {}
  if overrides.enable_tab_bar then
    overrides.enable_tab_bar = false
  else
    overrides.enable_tab_bar = true
  end
  window:set_config_overrides(overrides)
end

wezterm.on('toggle-fullscreen', function (window,pane)
  fullscreen_tab_hide(window)
end)

wezterm.on('toggle-tab-bar', function (window,pane)
  toggle_enable_tab_bar(window)
end)

return {
  default_prog = { 'pwsh' },
  font = wezterm.font("Moralerspace Neon HWNF"),
  color_scheme = "Catppuccin Mocha",
  -- color_scheme = 'Monokai Pro (Gogh)',
  window_padding = {
    left = '0',
    right = '0',
    top = '0',
    bottom = '0'
  },
  enable_tab_bar = false,
  keys = {
    {
      key = 'f',
      mods = 'SHIFT|META',
      action = wezterm.action.EmitEvent 'toggle-fullscreen',
      -- action = wezterm.action.ToggleFullScreen,
    },
    {
      key = 't',
      mods = 'SHIFT|META',
      action = wezterm.action.EmitEvent 'toggle-tab-bar',
    }
  },
}
