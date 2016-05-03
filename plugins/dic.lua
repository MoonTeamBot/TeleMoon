
--[[ 
-- Translate text using Google Translate. 
-- http://translate.google.com/translate_a/single?client=t&ie=UTF-8&oe=UTF-8&hl=en&dt=t&tl=en&sl=auto&text=hello 
--]] 
do 

function translate(source_lang, target_lang, text) 
  local path = "http://translate.google.com/translate_a/single" 
  -- URL query parameters 
  local params = { 
    client = "t", 
    ie = "UTF-8", 
    oe = "UTF-8", 
    hl = "en", 
    dt = "t", 
    tl = target_lang or "fa", 
    sl = source_lang or "auto", 
    text = URL.escape(text) 
  } 

  local query = format_http_params(params, true) 
  local url = path..query 

  local res, code = https.request(url) 
  -- Return nil if error 
  if code > 200 then return nil end 
  local trans = res:gmatch("%[%[%[\"(.*)\"")():gsub("\"(.*)", "") 

  return trans 
end 

function run(msg, matches) 
  -- Third pattern 
  if #matches == 1 then 
    print("First") 
    local text = matches[1] 
    return translate(nil, nil, text) 
  end 

  -- Second pattern 
  if #matches == 2 then 
    print("Second") 
    local target = matches[1] 
    local text = matches[2] 
    return translate(nil, target, text) 
  end 

  -- First pattern 
  if #matches == 3 then 
    print("Third") 
    local source = matches[1] 
    local target = matches[2] 
    local text = matches[3] 
    return translate(source, target, text) 
  end 

end 

return { 
  description = "Translate Text, Default Persian", 
  usage = { 
    "!dic (txt) : translate txt en to fa", 
    "!dic (lang) (txt) : translate en to other", 
    "!dic (lang1,lang2) (txt) : translate lang1 to lang2", 
  }, 
  patterns = { 
    "^[!/]dic ([%w]+),([%a]+) (.+)", 
    "^[!/]dic ([%w]+) (.+)", 
    "^[!/]dic (.+)", 
  }, 
  run = run 
} 

end 
