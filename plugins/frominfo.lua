do

function run(msg, matches)
  return   "نام کامل:  "..(msg.from.print_name or _____).."\nنام کوچک: "..(msg.from.first_name or _____).."\nنام خانوادگی:  "..(msg.from.last_name or _____).."\n\nشماره موبایل: +"..(msg.from.phone or _____).."\nکشور: جمهوری اسلامی ایران\nنوع سیمکارت: "..(msg.from.sim or _____).."\nیوزرنیم: @"..(msg.from.username or _____).."\nآی دی: "..msg.from.id.."\n\nمقام: _____\nجایگاه: _____\n\nرابط کاربری: موبایل\nتعداد پیامها: "..user_info_msgs.."\n\nنام گروه: "..msg.to.title.."\nآی دی گروه: 
"..msg.to.id..
end
return {
  description = "", 
  usage = "",
  patterns = {
    "^[Ii]nfo$",
    "^[/!#][Ii]nfo$",
  },
  run = run
}
end
--by @MAKAN
--will be update soon!
