antienglish = {}-- An empty table for solving multiple kicking problem

do
local function run(msg, matches)
if msg.to.type == 'chat' then
  if is_momod(msg) then -- Ignore mods,owner,admins
    return
  end
  local data = load_data(_config.moderation.data)
  if data[tostring(msg.to.id)]['settings']['lock_eng'] then
    if data[tostring(msg.to.id)]['settings']['lock_eng'] == 'yes' then
      if antienglish[msg.from.id] == true then 
        return
      end
      send_large_msg("chat#id".. msg.to.id , "english words is not allowed here⛔️")
      local name = user_print_name(msg.from)
      savelog(msg.to.id, name.." ["..msg.from.id.."] kicked (english was locked) ")
      chat_del_user('chat#id'..msg.to.id,'user#id'..msg.from.id,ok_cb,false)
		  antienglish[msg.from.id] = true
      return
    end
  end
  return
end
end
local function cron()
  antienglish = {} -- Clear antienglish table 
end
return {
  patterns = {
    "(a)",
	"(o)",
	"(l)",
	"(A)",
	"(O)",
	"(L)",
	"(M)",
	"(e)",
	"(E)",
	"(i)",
	"(I)",
	"(u)",
	"(U)",
	"(m)"
    },
  run = run,
	cron = cron
}

end
