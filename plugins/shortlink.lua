local function run(msg, matches)
  local MKH = URL.escape(matches[1])
  url = "https://api-ssl.bitly.com/v3/shorten?access_token=f2d0b4eabb524aaaf22fbc51ca620ae0fa16753d&longUrl="..MKH
  jstr, res = https.request(url)
  jdat = JSON.decode(jstr)
  if jdat.message then
    return 'لینک کوتاه شده \n___________\n\n'..jdat.message
  else
    return "لینک اصلی : \n_____________________________\n"..jdat.data.long_url.."\n\nلینک کوتاه شده:\n_____________________________\n"..jdat.data.url
    end
  end

return {
  patterns = {
  "^short (.*)$",
  "^[!#/]short (.*)$"
  },
  run = run,
}
