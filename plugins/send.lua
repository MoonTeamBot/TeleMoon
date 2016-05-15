local function run(msg, matches)
	if matches[1] == 'send' and is_sudo(msg) then
		local response = matches[3]
		--send_large_msg("chat#id"..matches[2], response)
		send_large_msg("channel#id"..matches[2], response)
	end
	if matches[1] == 'sent' then
		if is_sudo(msg) then -- Only sudo !
			local data = load_data(_config.moderation.data)
			local channels = 'channels'
			local response = matches[2]
			for k,v in pairs(data[tostring(channels)]) do
				channel_id =  v
				local channel = 'channel#id'..channel_id
				local channel = 'channel#id'..channel_id
				send_large_msg(channel, response)
				send_large_msg(channel, response)
			end
		end
	end
end
return {
  patterns = {
    "^[#!/](sent) +(.+)$",
    "^[#!/](send) (%d+) (.*)$"
  },
  run = run
}
