local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()
config.color_scheme = 'onedarkpro_onedark_dark'
config.font = wezterm.font 'JetBrainsMono NF'
config.default_prog = { 'powershell.exe', '-NoLogo' }
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 2000 }
config.scrollback_lines = 100000
config.launch_menu = {
  { label = 'Pwsh', args = {'pwsh.exe', '-NoLogo'} },
  { label = 'Powershell', args = {'powershell.exe', '-NoLogo'} },
  { label = 'CMD', args = {'cmd.exe'} },
}
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
  { key = 'd', mods = 'LEADER|SHIFT', action = act.ShowDebugOverlay },
  { key = 'e', mods = 'LEADER', action = act.SplitPane { command = { args = { 'nvim' } }, direction = 'Up' } },
  { key = 'v', mods = 'LEADER', action = act.ActivateCopyMode },
  { key = 'q', mods = 'LEADER', action = act.QuickSelect },
  { key = ' ', mods = 'LEADER', action = act.ShowLauncherArgs { flags = "FUZZY|TABS|COMMANDS|LAUNCH_MENU_ITEMS|WORKSPACES" } },
  { key = 'r', mods = 'LEADER', action = act.PromptInputLine { description = wezterm.format { { Text = "Enter command: " } }, action = wezterm.action_callback(run_callback) } },
  { key = 'n', mods = 'LEADER', action = act.SwitchToWorkspace { name = 'Notes', spawn = {args = {'nvim.exe'}, cwd = [[C:\Users\nljones2\OneDrive - NASA\Documents\Notes\]]} } },
  { key = 'd', mods = 'LEADER', action = act.SwitchToWorkspace { name = 'default'} },

  -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
  { key = 'a', mods = 'LEADER|CTRL', action = act.SendKey { key = 'a', mods = 'CTRL' } },

  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
}

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
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

local function indexOf(arr, value)
  for i, v in ipairs(arr) do
    if v == value then
      return i
    end
  end
  return 0
end

local function on_update_status(win, pane)
  local wdir = pane:get_current_working_dir()
  local path = '<nopath>'
  if wdir then path = wdir.path end
  local cwd = basename(path)
  local proc = basename(pane:get_foreground_process_name())
  local title = string.format('%s (%s)', cwd, proc)
  pane:tab():set_title(title)
  local SEP = { Text = '   ' }
  local workspaces = wezterm.mux.get_workspace_names()
  local active = wezterm.mux.get_active_workspace()
  local msg = {
    SEP,
    { Text = active },
    { Text = '(' },
    { Text = tostring(indexOf(workspaces, active)) },
    { Text = '/' },
    { Text = tostring(#workspaces) },
    { Text = ')' },
    SEP,
  }
  for _, b in ipairs(wezterm.battery_info()) do
    table.insert(msg, { Text = '🔋' .. string.format('%.0f%%', b.state_of_charge * 100) })
    table.insert(msg, SEP)
  end
  table.insert(msg, { Text = wezterm.strftime '%Y-%m-%d %H:%M:%S'})
  table.insert(msg, SEP)
  win:set_right_status(wezterm.format(msg))

  -- local tabs = win:mux_window():tabs()
  -- local overrides = win:get_config_overrides() or {}
  -- overrides.enable_tab_bar = #tabs > 1
  -- win:set_config_overrides(overrides)
end
wezterm.on('update-status', on_update_status)

wezterm.on('user-var-changed', function(window, pane, name, value)
    local overrides = window:get_config_overrides() or {}
    if name == "ZEN_MODE" then
        local incremental = value:find("+")
        local number_value = tonumber(value)
        if incremental ~= nil then
            while (number_value > 0) do
                window:perform_action(wezterm.action.IncreaseFontSize, pane)
                number_value = number_value - 1
            end
            overrides.enable_tab_bar = false
        elseif number_value < 0 then
            window:perform_action(wezterm.action.ResetFontSize, pane)
            overrides.font_size = nil
            overrides.enable_tab_bar = true
        else
            overrides.font_size = number_value
            overrides.enable_tab_bar = false
        end
    end
    window:set_config_overrides(overrides)
end)

return config
