local function run(msg, matches, callback, extra)

local data = load_data(_config.moderation.data)
local group_type = data[tostring(msg.to.id)]['group_type']

if matches[1] and is_sudo(msg) then
    
data[tostring(msg.to.id)]['group_type'] = matches[1]
        save_data(_config.moderation.data, data)
        
        return 'new type : '..matches[1]

end
if not is_sudo(msg) then 
    return 'only for sudo !'
    end
end
return {
  patterns = {
  "^[!/]type (.*)$",
  },
  run = run
}
