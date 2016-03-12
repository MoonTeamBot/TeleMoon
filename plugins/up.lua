do
 local function save_file(name, text)
    local file = io.open("./plugins/"..name, "w")
    file:write(text)
    file:flush()
    file:close()
    return "done!"
end   
function run(msg, matches)
  if matches[1] == "up" and is_sudo(msg) then
 
         local name = matches[2]
        local text = matches[3]
        return save_file(name, text)
        end
        if not is_sudo(msg) then 
		return "only for sudo"
	end
end
return {
  patterns = {
  "^[/!#](up) ([^%s]+) (.+)$"
  "^([Uu]p) ([^%s]+) (.+)$"
  },
  run = run
}
end
