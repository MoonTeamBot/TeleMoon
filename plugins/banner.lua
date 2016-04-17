function run(msg, matches)
text = io.popen("figlet " .. matches[1]):read('*all')
 if matches[1] == "banner" then
return text
else
  local file = io.open("./data/file/"..matches[1], "w")
  file:write(text)
  file:flush()
  file:close()
  return send_document("channel#id"..msg.to.id,"./data/file/"..matches[1], ok_cb, false)
 end
end
return {
  patterns = {
"^[#!/]banner> ([^%s]+) (.*)$",
  },
  run = run
}
