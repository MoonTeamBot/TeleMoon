local function history(extra, suc, result)
for i=1, #result do
delete_msg(result[i].id, ok_cb, false)
end
if tonumber(extra.con) == #result then
send_msg(extra.chatid, ''..#result..' msg removed', ok_cb, false)
else
send_msg(extra.chatid, 'all supergroup msgs removed', ok_cb, false)
end
end
local function run(msg, matches)
if matches[1] == 'rmmsg' and is_owner(msg) then
            if msg.to.type == 'channel' then
            if tonumber(matches[2]) > 9999 or tonumber(matches[2]) < 1 then
            return "error!"
            end
            get_history(msg.to.peer_id, matches[2] + 1 , history , {chatid = msg.to.peer_id, con = matches[2]})
        else
                         return "only for supergroups"
        end
else
return "only for mods"
end
end
return {
    patterns = {
        '^[!/#](rmmsg) (%d*)$'
    },
    run = run
}
