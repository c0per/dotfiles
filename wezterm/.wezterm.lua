local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- font
config.font = wezterm.font_with_fallback { 'JetBrains Mono NL', 'Noto Sans CJK SC' }
config.font_size = 19

config.color_scheme = 'Catppuccin Mocha'

config.front_end = 'WebGpu'
config.webgpu_power_preference = 'HighPerformance'

-- ssh domain
config.ssh_domains = {
    { name = 'arch', remote_address = 'c0per-arch.zhili.internal', username = 'c0per' }
}

-- window
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.hide_tab_bar_if_only_one_tab = true

-- keyboard shortcuts
config.disable_default_key_bindings = true
config.keys = {
    { key = 'L',     mods = 'CTRL',        action = wezterm.action.ShowLauncher },
    { key = 'D',     mods = 'CTRL',        action = wezterm.action.DetachDomain 'CurrentPaneDomain' },
    { key = 'S',     mods = 'CTRL',        action = wezterm.action.ShowDebugOverlay },

    { key = 'c',     mods = 'SUPER',       action = wezterm.action.CopyTo 'Clipboard' },
    { key = 'v',     mods = 'SUPER',       action = wezterm.action.PasteFrom 'Clipboard' },

    { key = 't',     mods = 'SUPER',       action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
    { key = 'x',     mods = 'SUPER',       action = wezterm.action.CloseCurrentPane { confirm = true } },
    { key = 'w',     mods = 'SUPER',       action = wezterm.action.CloseCurrentTab { confirm = true } },
    { key = '[',     mods = 'SUPER',       action = wezterm.action.ActivateTabRelative(-1) },
    { key = ']',     mods = 'SUPER',       action = wezterm.action.ActivateTabRelative(1) },
    { key = 'h',     mods = 'SUPER',       action = wezterm.action.ActivatePaneDirection 'Left' },
    { key = 'j',     mods = 'SUPER',       action = wezterm.action.ActivatePaneDirection 'Down' },
    { key = 'k',     mods = 'SUPER',       action = wezterm.action.ActivatePaneDirection 'Up' },
    { key = 'l',     mods = 'SUPER',       action = wezterm.action.ActivatePaneDirection 'Right' },

    { key = '{',     mods = 'SUPER|SHIFT', action = wezterm.action.MoveTabRelative(-1) },
    { key = '}',     mods = 'SUPER|SHIFT', action = wezterm.action.MoveTabRelative(1) },
    { key = 'f',     mods = 'SUPER',       action = wezterm.action.Search { CaseSensitiveString = '' } },
    { key = 'F',     mods = 'SUPER|SHIFT', action = wezterm.action.Search { CaseInSensitiveString = '' } },
    { key = '-',     mods = 'SUPER',       action = wezterm.action.DecreaseFontSize },
    { key = '=',     mods = 'SUPER',       action = wezterm.action.IncreaseFontSize },
    { key = 'r',     mods = 'SUPER',       action = wezterm.action.ReloadConfiguration },

    { key = 'Enter', mods = 'SUPER',       action = wezterm.action.SplitPane { direction = 'Right' } },
    { key = 'Enter', mods = 'SUPER|SHIFT', action = wezterm.action.SplitPane { direction = 'Down' } }
}

return config
