local function run(msg, matches)
	if matches[1] == 'send' and is_sudo(msg) then
		local response = matches[3]
		send_large_msg("channel#id"..matches[2], response)
	end
	end
return {
  patterns = {
    "^[#!/](send) (%d+) (.*)$"
  },
  run = run
}
