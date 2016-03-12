do
 
 local function run(msg, matches)
   if not is_sudo(msg) then
     return "only for sudo"
   end
   local receiver = get_receiver(msg)
   if matches[1] == 'dl' then
     
     local file = matches[3]
     
     if matches[2] == 'sticker' and not matches[4] then
       send_document(receiver, "./media/"..file..".webp", ok_cb, false)
     end
 
     if matches[2] == 'plugin' then
       send_document(receiver, "./plugins/"..file..".lua", ok_cb, false)
     end
   end
   
   if matches[1] == 'extensions' then
     return 'No disponible actualmente'
   end
   
   if matches[1] == 'list' and matches[2] == 'files' then
     return 'i cant find list'
     --send_document(receiver, "./media/files/files.txt", ok_cb, false)
   end
 end
 
 return {
   description = "Kicking ourself (bot) from unmanaged groups.",
   usage = {
     "!list files : Envía un archivo con los nombres de todo lo que se puede enviar",
     "!extensions : Envía un mensaje con las extensiones para cada tipo de archivo permitidas",
     "➖➖➖➖➖➖➖➖➖➖",
     "!dl sticker <nombre del sticker> : Envía ese sticker del servidor",
     "!dl photo <nombre de la foto> <extension de la foto> : Envía esa foto del servidor",
     "!dl GIF <nombre del GIF> : Envía ese GIF del servidor",
     "!send music <nombre de la canción <extension de la canción> : Envía esa canción del servidor",
     "!send video <nombre del video> <extension del video> : Envía ese video del servidor",
     "!send file <nombre del archivo> <extension del archivo> : Envía ese archivo del servidor",
     "!send plugin <Nombre del plugin> : Envía ese archivo del servidor",
     "!send manual <Ruta de archivo> <Nombre del plugin> : Envía un archivo desde el directorio TeleSeed",
     "!send dev : Envía una foto del desarrollador"
   },
   patterns = {
   "^[!/](dl) (.*) (.*) (.*)$",
   "^[!/](dl) (.*) (.*)$",
   "^[!/](dl) (.*)$",
   "^[!/](list) (files)$",
   "^[!/](extensions)$",
   "^([Dd]l) (.*) (.*) (.*)$",
   "^([Dd]l) (.*) (.*)$",
   "^([Dd]l) (.*)$",
   "^([Ll]ist) (files)$",
   "^([Ee]xtensions)$"
   },
   run = run
 }
 end
