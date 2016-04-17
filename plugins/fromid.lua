local function run(msg, matches) 
    return "telegram.me/"..msg.from.username
  end

return {
  patterns ={
    "^[/!#](id)$",
    "^([Ii]d)$"
 }, 
  run = run 
}
