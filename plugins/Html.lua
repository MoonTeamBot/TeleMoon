local function get_msgs_user_chat(user_id, chat_id)
  local user_info = {}
  local uhash = 'user:'..user_id
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..user_id..':'..chat_id
  user_info.msgs = tonumber(redis:get(um_hash) or 0)
  user_info.name = user_print_name(user)..' ['..user_id..']'
  return user_info
end

local function chat_members(receiver, chat_id)
  -- Users on chat
  local hash = 'chat:'..chat_id..':members'
  local users = redis:smembers(hash)
  local users_info = {}
  -- Get user info
  for i = 1, #users do
    local user_id = users[i]
    local user_info = get_msgs_user_chat(user_id, chat_id)
    table.insert(users_info, user_info)
  end
  -- Sort users by msgs number
  table.sort(users_info, function(a, b) 
    if a.msgs and b.msgs then
        return a.msgs > b.msgs
    end
  end)
  local text = 'members in this group \n'
  for k,user in pairs(users_info) do
    text = text..user.name..' = '..user.msgs..'\n'
  end
  local file = io.open("./groups/lists/"..chat_id.."members.html", "w")
  file:write(text)
  file:flush()
  file:close() 
  send_document(receiver,"./groups/lists/"..chat_id.."members.html", ok_cb, false)
  return --text
end

local function chat_stats2(chat_id)
  -- Users on chat
  local hash = 'chat:'..chat_id..':members'
  local users = redis:smembers(hash)
  local users_info = {}

  -- Get user info
  for i = 1, #users do
    local user_id = users[i]
    local user_info = get_msgs_user_chat(user_id, chat_id)
    table.insert(users_info, user_info)
  end

  -- Sort users by msgs number
  table.sort(users_info, function(a, b) 
      if a.msgs and b.msgs then
        return a.msgs > b.msgs
      end
    end)

  local text = 'members in this chat \n'
  for k,user in pairs(users_info) do
    text = text..user.name..' = '..user.msgs..'\n'
  end
  return text
end
end


return {
 description = "html users",
 usage = "html",
 patterns = { 
 "^[Mm]embers.(.*)$",
 },
 run = run
 }
