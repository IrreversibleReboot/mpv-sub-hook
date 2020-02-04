local hooking_state     = false;
local script_directory  = os.getenv("HOME") .. "/.config/mpv/scripts"

function toggle_hooking()

	if(hooking_state == false) then
		hooking_state = true		
		mp.observe_property('sub-text', 'string', paste_to_clipboard)
		mp.msg.info("Subtitles hooking on")
		mp.osd_message("Subtitles hooking on")

	else
		hooking_state = false
		mp.unobserve_property(paste_to_clipboard)
		mp.msg.info("Subtitles hooking off")
		mp.osd_message("Subtitles hooking off")
	end

end

function paste_to_clipboard(name, value)

	if(value ~= nil and value ~= '') then
		
        cmd = 'run /bin/sh ' .. script_directory .. '/sub-hook.sh "' .. value ..'"'
        mp.msg.info(cmd)
        mp.command(cmd)
		mp.msg.info("Pasted: " .. value)
	end

end


mp.add_key_binding("h", "toggle_hooking", toggle_hooking)
