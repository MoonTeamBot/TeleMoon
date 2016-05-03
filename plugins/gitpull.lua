local function run(msg, matches)
local text = io.popen(git pull):read('*all')
if is_sudo(msg) then
  return text
end
  end
return {
  patterns = {
    '^[#/!]up$'
  },
  run = run,
  moderated = true
}
