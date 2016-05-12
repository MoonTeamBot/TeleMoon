local function run(msg, matches)
 if matches[1]:lower() == 'code' then
  local url = http.request('http://www.iwebtool.com/code_viewer'..URL.escape(matches[2]))
  return text
 end
end

return {
   patterns = {
"^[/!](code) (.*)$",
   },
   run = run
}
