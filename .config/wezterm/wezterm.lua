local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

config.colors = {
  -- VSCode Dark+ inspired colors
  foreground = "#ccc",
  background = "#111",
  cursor_fg = "#111",
  cursor_bg = "#fff",
  cursor_border = "#ccc",
  selection_fg = "#111",
  selection_bg = "#9df",
  ansi    = { '#111', '#d66', '#695', '#c97', '#59d', '#b8b', '#4ba', '#ccc' },
  brights = { '#444', '#f99', '#ad8', '#ed9', '#9df', '#ead', '#8dc', '#fff' },

  -- Hide tab edges, tab bar background is also #333
  tab_bar = {
    inactive_tab_edge = "#333",
  }
}

config.inactive_pane_hsb = {
  brightness = 0.5,
}

if string.find(wezterm.target_triple, 'darwin') then
  -- Bindings for Mac
  config.keys = {
    {
      key = 'D',
      mods = 'SUPER|SHIFT',
      action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
    },
    {
      key = 'D',
      mods = 'SUPER|SHIFT|ALT',
      action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
    },
    {
      key = 'Enter',
      mods = 'SUPER|SHIFT',
      action = act.TogglePaneZoomState,
    },
    {
      key = 'LeftArrow',
      mods = 'SUPER',
      action = act.ActivatePaneDirection('Left'),
    },
    {
      key = 'RightArrow',
      mods = 'SUPER',
      action = act.ActivatePaneDirection('Right'),
    },
    {
      key = 'UpArrow',
      mods = 'SUPER',
      action = act.ActivatePaneDirection('Up'),
    },
    {
      key = 'DownArrow',
      mods = 'SUPER',
      action = act.ActivatePaneDirection('Down'),
    },
    {
      key = 'LeftArrow',
      mods = 'SUPER|ALT',
      action = act.ActivateTabRelative(-1),
    },
    {
      key = 'RightArrow',
      mods = 'SUPER|ALT',
      action = act.ActivateTabRelative(1),
    },
  }
else
  -- Bindings for Linux
  config.keys = {
    {
      key = 'D',
      mods = 'CTRL|SHIFT',
      action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
    },
    {
      key = 'D',
      mods = 'CTRL|SHIFT|ALT',
      action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
    },
    {
      key = 'Enter',
      mods = 'CTRL|SHIFT',
      action = act.TogglePaneZoomState,
    },
  }

  -- Font tuning for Linux
  config.font = wezterm.font('JetBrains Mono', { weight = 'Bold' })
  config.font_size = 9
  config.freetype_load_target = 'HorizontalLcd'

  config.window_frame = {
    font_size = 9,
  }
end

return config
