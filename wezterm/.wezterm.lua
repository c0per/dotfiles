local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- font
config.font = wezterm.font_with_fallback { 'Source Code Pro', 'Noto Sans CJK SC' }
config.font_size = 11.5

-- window
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.hide_tab_bar_if_only_one_tab = true

-- keyboard shortcuts
config.disable_default_key_bindings = true
config.keys = {
    {
        key = 'c',
        mods = 'SUPER',
        action = wezterm.action.CopyTo 'Clipboard'
    },
    {
        key = 'v',
        mods = 'SUPER',
        action = wezterm.action.PasteFrom 'Clipboard'
    },
    {
        key = 't',
        mods = 'SUPER',
        action = wezterm.action.SpawnTab 'CurrentPaneDomain'
    },
    {
        key = 'w',
        mods = 'SUPER',
        action = wezterm.action.CloseCurrentTab { confirm = true }
    },
    {
        key = '[',
        mods = 'SUPER',
        action = wezterm.action.ActivateTabRelative(-1)
    },
    {
        key = ']',
        mods = 'SUPER',
        action = wezterm.action.ActivateTabRelative(1)
    },
    {
        key = '{',
        mods = 'SUPER|SHIFT',
        action = wezterm.action.MoveTabRelative(-1)
    },
    {
        key = '}',
        mods = 'SUPER|SHIFT',
        action = wezterm.action.MoveTabRelative(1)
    },
    {
        key = 'f',
        mods = 'SUPER',
        action = wezterm.action.Search { CaseSensitiveString = '' }
    },
    {
        key = 'F',
        mods = 'SUPER|SHIFT',
        action = wezterm.action.Search { CaseInSensitiveString = '' }
    },
    {
        key = '-',
        mods = 'SUPER',
        action = wezterm.action.DecreaseFontSize
    },
    {
        key = '=',
        mods = 'SUPER',
        action = wezterm.action.IncreaseFontSize
    },
    {
        key = 'r',
        mods = 'SUPER',
        action = wezterm.action.ReloadConfiguration
    }
}

return config