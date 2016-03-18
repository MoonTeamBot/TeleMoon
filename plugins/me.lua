do

local function run(msg, matches)
  if matches[1] == 'me' then
    if is_sudo(msg) then
    send_document(get_receiver(msg), "./data/sudo.webp", ok_cb, false)
      return "بابام هستی دیگه❤️"
    elseif is_admin(msg) then
    send_document(get_receiver(msg), "./data/admin.webp", ok_cb, false)
      return "ادمینم هستی دیگه💛"
    elseif is_owner(msg) then
    send_document(get_receiver(msg), "./data/owner.webp", ok_cb, false)
      return "مدیر اصلی گروه هستی دیگه💚"
    elseif is_momod(msg) then
    send_document(get_receiver(msg), "./data/mod.webp", ok_cb, false)
      return "مدیر گروه هستی دیگه💙"
    else
    send_document(get_receiver(msg), "./data/member.webp", ok_cb, false)
      return "کاربر عادی هستی دیگه💔"
    end
  end
end

return {
  patterns = {
    "^[!/]([Mm]e)$",
    "^([Mm]e)$"
    },
  run = run
}
end
