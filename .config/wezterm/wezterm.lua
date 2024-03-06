local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

local HYPER = 'CTRL|SHIFT'
local HYPER_SHIFT_OR_ALT = 'CTRL|SHIFT|ALT'
if string.find(wezterm.target_triple, 'darwin') then
  HYPER = 'SUPER'
  HYPER_SHIFT_OR_ALT = 'SUPER|SHIFT'
end

config.check_for_updates = false

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

return config
