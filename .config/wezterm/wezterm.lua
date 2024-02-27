local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

config.colors = {
  -- VSCode Dark+ inspired colors
  -- 4096 colors
  foreground = "#ccc",
  background = "#111",
  cursor_fg = "#111",
  cursor_bg = "#fff",
  cursor_border = "#ccc",
  selection_fg = "#111",
  selection_bg = "#9df",
  ansi    = { '#111', '#c67', '#695', '#c97', '#59d', '#b8b', '#599', '#ccc' },
  brights = { '#444', '#f99', '#ad8', '#ed9', '#9df', '#ead', '#6ca', '#fff' },

  -- -- 256 colors
  -- foreground = "#d0d0d0",
  -- background = "#121212",
  -- cursor_fg = "#121212",
  -- cursor_bg = "#ffffff",
  -- cursor_border = "#d0d0d0",
  -- selection_fg = "#121212",
  -- selection_bg = "#87d7ff",
  -- ansi = {
  --   '#121212', -- 233
  --   '#af5f5f', -- 131
  --   '#5f8700', -- 064
  --   '#af875f', -- 137
  --   '#5f87af', -- 067
  --   '#af87af', -- 139
  --   '#5fafaf', -- 073
  --   '#d0d0d0', -- 252
  -- },
  -- brights = {
  --   '#444444', -- 238
  --   '#ff8787', -- 210
  --   '#afd787', -- 150
  --   '#ffd787', -- 222
  --   '#87d7ff', -- 117
  --   '#ffafd7', -- 218
  --   '#5fd7af', -- 079
  --   '#ffffff', -- 231
  -- },

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
    {
      key = "K",
      mods = 'SUPER',
      action = act.Multiple {
        act.ClearScrollback('ScrollbackAndViewport'),
        act.SendKey { key = 'L', mods = 'CTRL' },
      },
    },
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
  }
else
  -- Bindings for Linux
  config.keys = {
    {
      key = "K",
      mods = 'CTRL|SHIFT',
      action = act.Multiple {
        act.ClearScrollback('ScrollbackAndViewport'),
        act.SendKey { key = 'L', mods = 'CTRL' },
      },
    },
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
