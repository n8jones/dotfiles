local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action
local config = wezterm.config_builder()
config.color_scheme = 'GruvboxDarkHard'
config.font = wezterm.font 'JetBrainsMono NF'
config.default_prog = { 'powershell.exe' }
config.window_decorations = 'RESIZE'
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 2000 }
local function tabn(tab)
  return { key = tostring(tab), mods = 'LEADER', action = act.ActivateTab(tab - 1) }
end

local function run_callback(window, pane, line)
  wezterm.log_info('Run callback called: "' .. line .. '"')
  if line then
    local largs = wezterm.shell_split(line)
    wezterm.log_info(largs)
    window:perform_action(act.SplitPane {
      command = { args = largs },
      direction = 'Down',
    }, pane)
  end
end

config.keys = {
  tabn(1),
  tabn(2),
  tabn(3),
  tabn(4),
  tabn(5),
  tabn(6),
  tabn(7),
  tabn(8),
  tabn(9),
  { key = '0', mods = 'LEADER', action = act.ActivateTab(9) },
  { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },
  { key = 'f', mods = 'LEADER', action = act.ToggleFullScreen },
  { key = 'c', mods = 'LEADER', action = act.SpawnTab('DefaultDomain') },
  { key = '%', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '"', mods = 'LEADER|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection('Left') },
  { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection('Right') },
  { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection('Up') },
  { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection('Down') },
  { key = 'd', mods = 'LEADER', action = act.ShowDebugOverlay },
  { key = 'e', mods = 'LEADER', action = act.SplitPane { command = { args = { 'nvim' } }, direction = 'Up' } },
  { key = 'v', mods = 'LEADER', action = act.ActivateCopyMode },
  { key = 'q', mods = 'LEADER', action = act.QuickSelect },
  { key = ' ', mods = 'LEADER', action = act.ShowLauncherArgs { flags = "FUZZY|TABS|COMMANDS|LAUNCH_MENU_ITEMS" } },
  { key = 'r', mods = 'LEADER', action = act.PromptInputLine { description = wezterm.format { { Text = "Enter command: " } }, action = wezterm.action_callback(run_callback) } },

  -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
  { key = 'a', mods = 'LEADER|CTRL', action = act.SendKey { key = 'a', mods = 'CTRL' } },
}

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

local function basename(path)
  if path == nil or path == '' then 
    return '<empty>'
  end
  if #path < 3 then
    return path
  end

  local fs = string.byte('/')
  local bs = string.byte('\\')
  local i = #path - 1
  while i > 0 do
    local b = path:byte(i)
    if b == bs or b == fs then
      break
    end
    i = i-1
  end
  return path:sub(i+1)
end

wezterm.on('update-status', function(win, pane)
  local cwd = basename(pane:get_current_working_dir().path)
  local proc = basename(pane:get_foreground_process_name())
  local title = string.format('%s (%s)', cwd, proc)
  pane:tab():set_title(title)

  local date = wezterm.strftime '%Y-%m-%d %H:%M:%S  '
  local bat = ''
  for _, b in ipairs(wezterm.battery_info()) do
    bat = '🔋 ' .. string.format('%.0f%%', b.state_of_charge * 100)
  end
  win:set_right_status(wezterm.format {
    { Text = bat .. '  ' .. date },
  })
end)

return config
