local function run(msg, matches)
   if msg.to.type == 'chat' and is_momod then
chat_upgrade('chat#id'..msg.to.id, ok_cb, false)
     return "Chat Upgraded to SuperGroups"
   end
end
 return {
   patterns = {
"^[!/#](tosuper)$",
"^([Tt]osuper)$",
  }, 
   run = run 
 }
