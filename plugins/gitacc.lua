local function run(msg, matches)
  local eq = URL.escape(matches[1])
     url = "https://api.github.com/users/"..eq
     jstr, res = https.request(url)
     jdat = JSON.decode(jstr)
  if jdat.message then
  return jdat.message
  else
     text = jdat.login..'\nFollowers: '..jdat.followers..'\nFollowings: '..jdat.following..'\nRepos: '..jdat.public_repos..'\nProfile URL: '..jdat.html_url..'\n\n @MoonTeam'
  local file = download_to_file(jdat.avatar_url,'Hextor.webp')
  send_document('chat#id'..msg.to.id,file,ok_cb,false)
  return text
end
end
return {
  description = "", 
  usage = "",
  patterns = {
    "^[!/]git (.*)",
  },
  run = run
}
