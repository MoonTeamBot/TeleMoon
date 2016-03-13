do

  local function scan_name(extra, success, result)
    local founds = {}
    for k,member in pairs(result.members) do
      if extra.name then
        gp_member = extra.name
        fields = {'first_name', 'last_name', 'print_name'}
      elseif extra.user then
        gp_member = string.gsub(extra.user, '@', '')
        fields = {'username'}
      end
      for k,field in pairs(fields) do
        if member[field] and type(member[field]) == 'string' then
          if member[field]:match(gp_member) then
            founds[tostring(member.id)] = member
          end
        end
      end
    end
    if next(founds) == nil then — Empty table
      send_large_msg(extra.receiver, (extra.name or extra.user)..' در این گروه پیدا نشد')
    else
      local text = ''
      for k,user in pairs(founds) do
        text = text..'نام کامل: '..(user.first_name or '')..' '..(user.last_name or '')..'\n'
               ..'نام: '..(user.first_name or '')..'\n'
               ..'نام خانوادگی: '..(user.last_name or '')..'\n\n'
               ..'یوزر نیم: @'..(user.username or '')..'\n'
               ..'آیدی: '..(user.id  or '')..'\n\n'
      end
      send_large_msg(extra.receiver, text)
    end
  end

  local function action_by_reply(extra, success, result)
    local text = 'نام کامل: '..(result.from.first_name or '')..' '..(result.from.last_name or '')..'\n'
                 ..'نام: '..(result.from.first_name or '')..'\n'
                 ..'نام خانوادگی: '..(result.from.last_name or 'ندارد')..'\n'
                 ..'یوزر نیم: @'..(result.from.username or 'ندارد')..'\n'
                 ..'آیدی: '..result.from.id
    send_large_msg(extra.receiver, text)
  end

  local function returnids(extra, success, result)
    local chat_id = extra.msg.to.id
    local text = '['..result.id..'] '..result.title..'.\n'
                 ..result.members_num..' members.\n\n'
    i = 0
    for k,v in pairs(result.members) do
      i = i+1
      if v.username then
        user_name = ' @'..v.username
      else
        user_name = ''
      end
      text = text..i..'. ['..v.id..'] '..user_name..' '..(v.first_name or '')..(v.last_name or '')..'\n'
    end
    if extra.matches == 'pm' then
      send_large_msg('user#id'..extra.msg.from.id, text)
    elseif extra.matches == 'txt' or extra.matches == 'pmtxt' then
      local textfile = '/tmp/chat_info_'..chat_id..'_'..os.date("%y%m%d.%H%M%S")..'.txt'
      local file = io.open(textfile, 'w')
      file:write(text)
      file:flush()
      file:close()
      if extra.matches == 'txt' then
        send_document('chat#id'..chat_id, textfile, rmtmp_cb, {file_path=textfile})
      elseif extra.matches == 'pmtxt' then
        send_document('user#id'..extra.msg.from.id, textfile, rmtmp_cb, {file_path=textfile})
      end
    elseif not extra.matches then
      send_large_msg('chat#id'..chat_id, text)
    end
  end

local function run(msg, matches)
    local receiver = get_receiver(msg)
    if is_chat_msg(msg) then
      if msg.text == '!id' then
        if msg.reply_id then
          if is_mod(msg) then
            msgr = get_message(msg.reply_id, action_by_reply, {receiver=receiver})
          end
        else
          local text = 'نام کامل: '..(msg.from.first_name or '')..' '..(msg.from.last_name or '')..'\n'
                       ..'نام: '..(msg.from.first_name or '')..'\n'
                       ..'نام خانوادگی: '..(msg.from.last_name or '')..'\n\n'
                       ..'یوزر نیم @'..(msg.from.username or '')..'\n'
                       ..'آیدی: ' .. msg.from.id
          local text = text..'\n  شما در گروه '
                       ..msg.to.title..' هستید \n(آیدی گروه: '..msg.to.id..')\n\n@CycloneTG team'
          return text
        end
      elseif is_mod(msg) and matches[1] == 'chat' then
        if matches[2] == 'pm' or matches[2] == 'txt' or matches[2] == 'pmtxt' then
          chat_info(receiver, returnids, {msg=msg, matches=matches[2]})
        else
          chat_info(receiver, returnids, {msg=msg})
        end
      elseif is_mod(msg) and string.match(matches[1], '^@.+$') then
        chat_info(receiver, scan_name, {receiver=receiver, user=matches[1]})
      elseif is_mod(msg) and string.gsub(matches[1], ' ', '_') then
        user = string.gsub(matches[1], ' ', '_')
        chat_info(receiver, scan_name, {receiver=receiver, name=matches[1]})
      end
    else
      return 'شما در گروه نیستید'
    end
  end

  return {
    description = 'Know your id or the id of a chat members.',
    usage = {
      user = {
        '!id: Return your ID and the chat id if you are in one.'
      },
      moderator = {
        '!id : Return ID of replied user if used by reply.',
        '!id chat : Return the IDs of the current chat members.',
        '!id chat txt : Return the IDs of the current chat members and send it as text file.',
        '!id chat pm : Return the IDs of the current chat members and send it to PM.',
        '!id chat pmtxt : Return the IDs of the current chat members, save it as text file and then send it to PM.',
        '!id <id> : Return the IDs of the <id>.',
        '!id @<user_name> : Return the member @<user_name> ID from the current chat.',
        '!id <text> : Search for users with <text> on first_name, last_name, or print_name on current chat.'
      },
    },
    patterns = {
      "^!id$",
      "^!id (chat) (.*)$",
      "^!id (.*)$",
      "^[Ii]d$",
      "^[Ii]d (chat) (.*)$",
      "^[Ii]d (.*)$"
    },
    run = run
  }

end
