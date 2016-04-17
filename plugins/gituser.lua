local function run(msg, matches)
--  local eq = URL.escape(matches[1])
     url = "https://api.github.com/repos/"..matches[1].."/"..matches[2]
     jstr, res = https.request(url)
     jdat = JSON.decode(jstr)
  if jdat.message then
  return jdat.message
  else
     text = jdat.owner.login..' / '..jdat.name
  if jdat.description then
  text = text..'\n______________________________\n'..jdat.description
  end
  text = text..'\n______________________________\nLanguage: '..jdat.language
  ..'\nForks: '..jdat.forks_count
  ..'\nIssues: '..jdat.open_issues
  ..'\nRepo URL: '..jdat.html_url
  ..'\n\n@FacelessTeam'
  local file = download_to_file(jdat.owner.avatar_url,'Hextor.webp')
  send_document('chat#id'..msg.to.id,file,ok_cb,false)
  return text
end
end
return {
  description = "", 
  usage = "",
  patterns = {
    "^[!/]gituser (.*)/(.*)",
  },
  run = run
}
