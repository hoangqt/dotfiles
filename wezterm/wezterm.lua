-- Inspired by https://alexplescan.com/posts/2024/08/10/wezterm/

-- Import the wezterm module
local wezterm = require 'wezterm'
-- Creates a config object which we will be adding our config to
local config = wezterm.config_builder()

-- Multiplexer module
local mux = wezterm.mux

-- Get user ID
local function get_user_id()
  local user_id

  local handle = io.popen("id | awk -F'[()]' '{print $2}'")
  if handle then
    user_id = handle:read("*a")
    handle:close()
    -- Remove any trailing newline
    user_id = user_id:gsub("%s+", "")
  end

  return user_id
end

-- Enable scrollbar
config.enable_scroll_bar = true

-- How many lines of scrollback you want to retain per tab
config.scrollback_lines = 3500

-- Cursor style https://wezfurlong.org/wezterm/config/lua/config/default_cursor_style.html
-- SteadyBar == |
config.default_cursor_style = 'SteadyBar'

-- Display hostname top right
wezterm.on('update-status', function(window)
  -- Grab the utf8 character for the "powerline" left facing
  -- solid arrow.
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

  -- Grab the current window's configuration, and from it the
  -- palette (this is the combination of your chosen colour scheme
  -- including any overrides).
  local color_scheme = window:effective_config().resolved_palette
  local bg = color_scheme.background
  local fg = color_scheme.foreground

  window:set_right_status(wezterm.format({
    -- First, we draw the arrow...
    { Background = { Color = 'none' } },
    { Foreground = { Color = bg } },
    { Text = SOLID_LEFT_ARROW },
    -- Then we draw our text
    { Background = { Color = bg } },
    { Foreground = { Color = fg } },
    { Text = get_user_id() .. ', try to live a life of service.' },
  }))
end)

-- Remove the title bar only
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'

-- Window font size
config.window_frame = {
  font_size = 15,
}

-- Maximize window on startup
wezterm.on('gui-startup', function()
 local tab, pane, window = mux.spawn_window({})
 window:gui_window():maximize()
end)

-- Find them here: https://wezfurlong.org/wezterm/colorschemes/index.html
config.color_scheme = 'Catppuccin Macchiato'

-- Choose your favourite font, make sure it's installed on your machine
config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'DemiBold' })
config.font_size = 15

-- Define leader key similar to tmux
config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 }
-- Use the same tmux keys to split
config.keys = {
  {
    key = '|',
    -- Note that instead of a key modifier mapped to a key on your keyboard
    -- like CTRL or ALT, we can use the LEADER modifier instead.
    -- This means that this binding will be invoked when you press the leader
    -- (CTRL + A), quickly followed by quotes (").
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '-',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = ',',
    mods = 'LEADER',
    -- Interactive renaming the current tab
    -- https://wezfurlong.org/wezterm/config/lua/keyassignment/PromptInputLine.html#example-of-interactively-renaming-the-current-tab
    action = wezterm.action.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
  { key = 's', mods = 'LEADER', action = wezterm.action.ShowTabNavigator },
  -- cmd+[ - navigate tab 1 to the left
  -- cmd+] - navigate tab 1 to the right
  { key = '[', mods = 'CMD', action = wezterm.action.ActivateTabRelative(-1)},
  { key = ']', mods = 'CMD', action = wezterm.action.ActivateTabRelative(1)},
}

-- Don't prompt when I close the window
config.window_close_confirmation = 'NeverPrompt'

-- Returns our config to be evaluated. We must always do this at the bottom of this file
return config
