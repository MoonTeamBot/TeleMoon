--Tag ppl with username and a msg after it

local function tagall(cb_extra, success, result)
    local receiver = cb_extra.receiver
    local chat_id = "chat#id"..result.id
    local text = ''
    for k,v in pairs(result.members) do
        if v.username then
			text = text.."@"..v.username.."\n"
		end
    end
	text = text.."\n"..cb_extra.msg_text
	send_large_msg(receiver, text)
end
local function run(msg, matches)
	if matches[1] == 'tagall' then
    local receiver = get_receiver(msg)
	if not is_owner(msg) then 
		return "For owner only !"
	end
	if matches[2] then
		chat_info(receiver, tagall, {receiver = receiver,msg_text = matches[1]})
	end
end
	return
end


return {
  description = "Will tag all ppl with a msg.",
  usage = {
    "tagall: Tag All Users And Show Your Message.",
  },
  patterns = {
    "^[#!/](tagall) +(.+)$",
    "^(tagall) +(.+)$"
  },
  run = run
}
