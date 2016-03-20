

//TG IRC bot stuff

proc/send2irc(msg,msg2)
	if(config.useircbot)
		shell("python nudge.py [msg] [msg2]")
	return

