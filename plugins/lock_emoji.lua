local function run(msg, matches)
    if is_owner(msg) then
        return
    end
    local data = load_data(_config.moderation.data)
    if data[tostring(msg.to.id)] then
        if data[tostring(msg.to.id)]['settings'] then
            if data[tostring(msg.to.id)]['settings']['antiemoji'] then
                lock_emoji = data[tostring(msg.to.id)]['settings']['antiemoji']
            end
        end
    end
    local chat = get_receiver(msg)
    local user = "user#id"..msg.from.id
    if lock_emoji == "yes" then
        send_large_msg(chat, 'شما اموجی فرستادید و این در گروه ممنوع است\nشما اخراج می شوید')
        chat_del_user(chat, user, ok_cb, true)
    end
end
 
return {
  patterns = {
    "👇(.*)",
    "👍(.*)",
    "👆(.*)",
    "👎(.*)",
    "☝(.*)",
    "👌(.*)",
    "💩(.*)",
    "☺(.*)",
    "😊(.*)",
    "😀(.*)",
    "😁(.*)",
    "😂(.*)",
    "😃(.*)",
    "😄(.*)",
    "😅(.*)",
    "😆(.*)",
    "😇(.*)",
    "😈(.*)",
    "😉(.*)",
    "😯(.*)",
    "😐(.*)",
    "😑(.*)",
    "😠(.*)",
    "😕(.*)",
    "😬(.*)",
    "😡(.*)",
    "😢(.*)",
    "😴(.*)",
    "😮(.*)",
    "😣(.*)",
    "😤(.*)",
    "😦(.*)",
    "😧(.*)",
    "😨(.*)",
    "😍(.*)",
    "😜(.*)",
    "😛(.*)",
  },
  run = run
}
