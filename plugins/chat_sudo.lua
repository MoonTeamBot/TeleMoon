local function run(msg, matches)
    if msg.text == "salam" then
      if is_sudo(msg) then
        return "سلام بابایی جونم (^_^)"
      else
        return "salam babaii ^_^"
      end
    elseif msg.text == "بای" then
      if is_sudo(msg) then
        return "اودافظ بابایی جونم "
      else
        return "خداحافظ"
      end
    elseif msg.text == "سلام" then
      if is_sudo(msg) then
        return "سلام بابایی جونم "
      else
        return "سلام"
        end
    elseif msg.text == "bye" then
      if is_sudo(msg) then
        return "^_^ اودافظ بابایی جونم "
      else
        return "خدا نگه دار"
      end
    end
end
return {
	patterns = {
"^salam",
"^بای",
"سلام",
"bye",
},
run = run,
}
