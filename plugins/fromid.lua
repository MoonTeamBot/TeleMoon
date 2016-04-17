local function run(msg, matches) 
  local support_id = msg.from.id
 if matches[1]:lower() == 'id' and msg.to.type == "chat" or msg.to.type == "user" then
    if msg.to.type == "user" then
      return "Bot ID: "..msg.to.id.. "\n\nYour ID: "..msg.from.id
    end
    if type(msg.reply_id) ~= "nil" then
      local print_name = user_print_name(msg.from):gsub("‮", "")
	  local name = print_name:gsub("_", "")
        savelog(msg.to.id, name.." ["..msg.from.id.."] used /id ")
        id = get_message(msg.reply_id,get_message_callback_id, false)
    elseif matches[1]:lower() == 'id' then
      local name = user_print_name(msg.from)
      savelog(msg.to.id, name.." ["..msg.from.id.."] used /id ")
      return "👥Group name：" ..string.gsub(msg.to.print_name, "_", " ").. "\n🔺Group id: "..msg.to.id.. "\n🔻Your id: "..msg.from.id.. "telegram.me/"..msg.from.username
  end

return {
  patterns ={
    "^[/!#](id)$",
    "^([Ii]d)$"
 }, 
  run = run 
}
