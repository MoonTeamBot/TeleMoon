local function run(msg, matches)
 if matches[1]:lower() == 'code' then
  local url = http.request('https://github.com/organizations/webplatform/settings/applications/34604'..URL.escape(matches[2]))
  local jdat = json:code(url)
  text = text..'\n\n@MoonTeam'
  return text
 end
end

return {
   patterns = {
"^[/!](code) (.*)$",
   },
   run = run
}
