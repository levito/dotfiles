local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

local HYPER = 'CTRL|SHIFT'
local HYPER_SHIFT_OR_ALT = 'CTRL|SHIFT|ALT'
if string.find(wezterm.target_triple, 'darwin') then
  HYPER = 'SUPER'
  HYPER_SHIFT_OR_ALT = 'SUPER|SHIFT'
end

local TITLEBAR_BG = '#2b2b2b'

config.check_for_updates = false

config.colors = {
  -- VSCode Dark+ inspired colors
  foreground = "#ccc",
  background = "#111",
  cursor_fg = "#111",
  cursor_bg = "#fff",
  cursor_border = "#ccc",
  selection_fg = "#111",
  selection_bg = "#8ce",
  ansi    = { '#111', '#d67', '#7a6', '#da8', '#48b', '#c8c', '#6bb', '#ccc' },
  brights = { '#444', '#f9a', '#ad8', '#ed9', '#8ce', '#faf', '#8ed', '#fff' },

  tab_bar = {
    active_tab = {
      bg_color = '#111',
      fg_color = '#ccc',
    },
    inactive_tab = {
      bg_color = TITLEBAR_BG,
      fg_color = '#777',
    },
    inactive_tab_edge = TITLEBAR_BG,
    new_tab = {
      bg_color = TITLEBAR_BG,
      fg_color = '#777',
    },
  }
}

config.font = wezterm.font_with_fallback {
  { family = 'MesloLGS NF', weight = 'Bold' },
  { family = 'JetBrains Mono', weight = 'Bold' },
  'Noto Color Emoji',
}
config.font_size = 11
config.freetype_load_target = 'HorizontalLcd'

config.inactive_pane_hsb = {
  brightness = 0.5,
}

config.keys = {
  {
    key = 'LeftArrow',
    mods = HYPER,
    action = act.ActivatePaneDirection 'Prev',
  },
  {
    key = 'RightArrow',
    mods = HYPER,
    action = act.ActivatePaneDirection 'Next',
  },
  {
    key = 'LeftArrow',
    mods = HYPER .. '|ALT',
    action = act.ActivateTabRelative(-1),
  },
  {
    key = 'RightArrow',
    mods = HYPER .. '|ALT',
    action = act.ActivateTabRelative(1),
  },
  {
    key = "k",
    mods = HYPER,
    action = act.Multiple {
      act.ClearScrollback 'ScrollbackAndViewport',
      act.SendKey{ key = 'l', mods = 'CTRL' },
    },
  },
  {
    key = "o",
    mods = HYPER,
    action = act.ShowTabNavigator,
  },
  {
    key = 'd',
    mods = HYPER,
    action = act.SplitHorizontal{ domain = 'CurrentPaneDomain' },
  },
  {
    key = 'd',
    mods = HYPER_SHIFT_OR_ALT,
    action = act.SplitVertical{ domain = 'CurrentPaneDomain' },
  },
  {
    key = 'Enter',
    mods = HYPER .. '|SHIFT',
    action = act.TogglePaneZoomState,
  },
}

config.scrollback_lines = 1000000

-- config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
config.window_frame = {
  active_titlebar_bg = TITLEBAR_BG,
  inactive_titlebar_bg = TITLEBAR_BG,
}

return config
