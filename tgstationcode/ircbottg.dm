

//TG IRC bot stuff

proc/send2irc(msg,msg2)
	if(config.useircbot)
		shell("python nudge.py [msg] [msg2]")
	return


/proc/send2irc_adminless_only(source, msg, requiredlevel = LEVEL_SA)
	var/list/adm = get_admin_counts(requiredlevel)
	. = adm["present"]
	if(. <= 0)
		if(!adm["afk"] && !adm["stealth"] && !adm["noflags"])
			send2irc(source, "[msg] - No admins online")
		else
			send2irc(source, "[msg] - All admins AFK ([adm["afk"]]/[adm["total"]]), stealthminned ([adm["stealth"]]/[adm["total"]]), or lack required level (SA) ([adm["noflags"]]/[adm["total"]])")


/proc/get_admin_counts(requiredlevel = LEVEL_SA)
	. = list("total" = 0, "noflags" = 0, "afk" = 0, "stealth" = 0, "present" = 0)
	for(var/client/C in onlineAdmins)
		.["total"]++
		if(requiredlevel != 0 && !(C.holder.level >= requiredlevel))
			.["noflags"]++
		else if(C.is_afk())
			.["afk"]++
		else if(C.fakekey && C.stealth)
			.["stealth"]++
		else
			.["present"]++


/client/proc/is_afk(duration=3000)
	if(inactivity > duration)
		return inactivity
	return 0