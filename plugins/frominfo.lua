do

function run(msg, matches)
  return   "نام کامل:  "..(msg.from.print_name or -----).."\nنام کوچک: "..(msg.from.first_name or -----).."\nنام خانوادگی:  "..(msg.from.last_name or -----).."\n\nشماره موبایل: +"..(msg.from.phone or -----).."\nکشور: جمهوری اسلامی ایران\nنوع سیمکارت: "..(msg.from.sim or -----).."\nیوزرنیم: @"..(msg.from.username or -----).."\nآی دی: "..msg.from.id.."\nمقام: -----\nجایگاه: -----\nرابط کاربری: موبایل\nنام گروه: "..msg.to.title.."\nآی دی گروه: 
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
