do

-- Returns the key (index) in the config.enabled_plugins table
local function plugin_enabled( name )
  for k,v in pairs(_config.enabled_plugins) do
    if name == v then
      return k
    end
  end
  -- If not found
  return false
end

-- Returns true if file exists in plugins folder
local function plugin_exists( name )
  for k,v in pairs(plugins_names()) do
    if name..'.lua' == v then
      return true
    end
  end
  return false
end

local function list_all_plugins(only_enabled)
  local text = ''
  local nsum = 0
  for k, v in pairs( plugins_names( )) do
    --  ✔ enabled, ❌ disabled
    local status = '⛔️'
    nsum = nsum+1
    nact = 0
    -- Check if is enabled
    for k2, v2 in pairs(_config.enabled_plugins) do
      if v == v2..'.lua' then 
        status = '✅' 
      end
      nact = nact+1
    end
    if not only_enabled or status == '✔' then
      -- get the name
      v = string.match (v, "(.*)%.lua")
      text = text..nsum..'. '..status..' '..v..'\n'
    end
  end
   local text = text..'\nدر مجموع '..nsum..' افزونه وجود دارد.\n'..nact..' افزونه فعال و '..nsum-nact..' افزونه غیر فعال.'
  return text
end

local function list_plugins(only_enabled)
  local text = ''
  local nsum = 0
  for k, v in pairs( plugins_names( )) do
    --  ✔ enabled, ❌ disabled
    local status = '⛔️'
    nsum = nsum+1
    nact = 0
    -- Check if is enabled
    for k2, v2 in pairs(_config.enabled_plugins) do
      if v == v2..'.lua' then 
        status = '✅' 
      end
      nact = nact+1
    end
    if not only_enabled or status == '✔' then
      -- get the name
      v = string.match (v, "(.*)%.lua")
      text = text..status..' '..v..'\n'
    end
  end
    local text = text..'\n'..nact..' افزونه فعال میباشد\nاز '..nsum..' افزونه نصب شده.'
  return text
end

local function reload_plugins( )
  plugins = {}
  load_plugins()
  return list_plugins(true)
end


local function enable_plugin( plugin_name )
  print('checking if '..plugin_name..' exists')
  -- Check if plugin is enabled
  if plugin_enabled(plugin_name) then
    return '✅ افزونه '..plugin_name..' فعال است.'
  end
  -- Checks if plugin exists
  if plugin_exists(plugin_name) then
    -- Add to the config table
    table.insert(_config.enabled_plugins, plugin_name)
    print(plugin_name..' added to _config table')
    save_config()
    -- Reload the plugins
    return reload_plugins( )
  else
     return '⛔️ افزونه '..plugin_name..' وجود ندارد.'
  end
end

local function disable_plugin( name, chat )
  -- Check if plugins exists
  if not plugin_exists(name) then
    return '⛔️ افزونه '..name..' وجود ندارد.'
  end
  local k = plugin_enabled(name)
  -- Check if plugin is enabled
  if not k then
      return '⛔️ افزونه '..name..' فعال نیست.'
  end
  -- Disable and reload
  table.remove(_config.enabled_plugins, k)
  save_config( )
  return reload_plugins(true)    
end

local function disable_plugin_on_chat(receiver, plugin)
  if not plugin_exists(plugin) then
  return "⛔️ این افزونه وجود ندارد."
  end

  if not _config.disabled_plugin_on_chat then
    _config.disabled_plugin_on_chat = {}
  end

  if not _config.disabled_plugin_on_chat[receiver] then
    _config.disabled_plugin_on_chat[receiver] = {}
  end

  _config.disabled_plugin_on_chat[receiver][plugin] = true

  save_config()
 return '⛔️ افزونه '..plugin..' غیر فعال شد.'
end

local function reenable_plugin_on_chat(receiver, plugin)
  if not _config.disabled_plugin_on_chat then
    return 'There aren\'t any disabled plugins'
  end

  if not _config.disabled_plugin_on_chat[receiver] then
    return 'There aren\'t any disabled plugins for this chat'
  end

  if not _config.disabled_plugin_on_chat[receiver][plugin] then
     return '✅ این افزونه فعال است.'
  end

  _config.disabled_plugin_on_chat[receiver][plugin] = false
  save_config()
  return '✅ افزونه '..plugin..' مجددا فعال شد.'
end

local function run(msg, matches)
  -- Show the available plugins 
  if matches[1] == '/plugins' and is_sudo(msg) then --after changed to moderator mode, set only sudo
    return list_all_plugins()
  end

  -- Re-enable a plugin for this chat
  if matches[1] == '+' and matches[3] == 'group' then
    local receiver = get_receiver(msg)
    local plugin = matches[2]
     print("✅ افزونه "..plugin..' فعال شد.')
    return reenable_plugin_on_chat(receiver, plugin)
  end

  -- Enable a plugin
  if matches[1] == '+' and is_sudo(msg) then --after changed to moderator mode, set only sudo
    local plugin_name = matches[2]
    print("enable: "..matches[2])
    return enable_plugin(plugin_name)
  end

  -- Disable a plugin on a chat
  if matches[1] == '-' and matches[3] == 'group' then
    local plugin = matches[2]
    local receiver = get_receiver(msg)
     print("⛔️ افزونه "..plugin..' غیر فعال شد.')
    return disable_plugin_on_chat(receiver, plugin)
  end

  -- Disable a plugin
  if matches[1] == '-' and is_sudo(msg) then --after changed to moderator mode, set only sudo
    if matches[2] == 'plugins' then
    	return '⛔️ این افزونه نمیتواند غیر فعال شود.'
    end
    print("disable: "..matches[2])
    return disable_plugin(matches[2])
  end

  -- Reload all the plugins!
  if matches[1] == '?' and is_sudo(msg) then --after changed to moderator mode, set only sudo
    return reload_plugins(true)
  end
end

return {
  description = "Plugin Manager", 
  usage = {
      moderator = {
          "/plugins - (name) group : disable item in group",
          "/plugins + (name) group : enable item in group",
          },
      sudo = {
          "/plugins : plugins list",
          "/plugins + (name) : enable bot item",
          "/plugins - (name) : disable bot item",
          "/plugins ? : reloads plugins" },
          },
  patterns = {
    "^[!/]plugins$",
    "^[!/]plugins? (+) ([%w_%.%-]+)$",
    "^[!/]plugins? (-) ([%w_%.%-]+)$",
    "^[!/]plugins? (+) ([%w_%.%-]+) (group)",
    "^[!/]plugins? (-) ([%w_%.%-]+) (group)",
    "^[!/]plugins? (?)$" },
  run = run,
  moderated = true, -- set to moderator mode
  --privileged = true
}

end
