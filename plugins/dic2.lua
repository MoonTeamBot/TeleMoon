do
local function run(msg, matches)
if #matches == 1 then
local htp = https.request('https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20160119T111342Z.fd6bf13b3590838f.6ce9d8cca4672f0ed24f649c1b502789c9f4687a&format=plain&lang=fa&text='..URL.escape(matches[2]))
local data = json:decode(htp)
return ''..data.text[1]
elseif #matches == 2 then
local htp = https.request('https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20160119T111342Z.fd6bf13b3590838f.6ce9d8cca4672f0ed24f649c1b502789c9f4687a&format=plain&lang='..URL.escape(matches[1])..'&text='..URL.escape(matches[2]))
local data = json:decode(htp)
return ''..data.text[1]
end
end
return {
  patterns = {
    "^[Dd]ic, ([^%s]+) (.*)$",
  "^[Dd]ic (.*)$"
  },
  run = run
}
end
