do

local function run(msg, matches)
  if matches[1]:lower() == 'me' or "wai" then
    if is_sudo(msg) then
    send_document(get_receiver(msg), "./data/me/sudo.webp", ok_cb, false)
      return "Your Rank is : SuDo"
    elseif is_admin(msg) then
    send_document(get_receiver(msg), "./data/me/admin.webp", ok_cb, false)
      return "Your Rank is : Admin"
    elseif is_owner(msg) then
    send_document(get_receiver(msg), "./data/me/owner.webp", ok_cb, false)
      return "Your Rank is : Owner"
    elseif is_momod(msg) then
    send_document(get_receiver(msg), "./data/me/moderetion.webp", ok_cb, false)
      return "Your Rank is : Mod"
    else
      send_document(get_receiver(msg), "./data/me/member.webp", ok_cb, false)
      return "Your Rank is : member"
  end
end
end

return {
  patterns = {
    "^[!/]([Mm]e)$",
    "^([Mm]e)$",
    "^([Ww]ai)$",
    },
  run = run
}
end
