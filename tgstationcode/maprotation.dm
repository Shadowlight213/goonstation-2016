
/*
/proc/maprotate()
	if (!SERVERTOOLS)
		return
	var/players = clients.len
	var/list/mapvotes = list()
	//count votes
	for (var/client/c in clients)
		var/vote = c.prefs.preferred_map
		if (!vote)
			if (config.defaultmap)
				mapvotes[config.defaultmap.name] += 1
			continue
		mapvotes[vote] += 1

	//filter votes
	for (var/map in mapvotes)
		if (!map)
			mapvotes.Remove(map)
		if (!(map in config.maplist))
			mapvotes.Remove(map)
			continue
		var/datum/votablemap/VM = config.maplist[map]
		if (!VM)
			mapvotes.Remove(map)
			continue
		if (VM.voteweight <= 0)
			mapvotes.Remove(map)
			continue
		if (VM.minusers > 0 && players < VM.minusers)
			mapvotes.Remove(map)
			continue
		if (VM.maxusers > 0 && players > VM.maxusers)
			mapvotes.Remove(map)
			continue

		mapvotes[map] = mapvotes[map]*VM.voteweight

	var/pickedmap = pickweight(mapvotes)
	if (!pickedmap)
		return
	var/datum/votablemap/VM = config.maplist[pickedmap]
	message_admins("Randomly rotating map to [VM.name]([VM.friendlyname])")
	. = changemap(VM)
	if (. == 0)
		world << "<span class='boldannounce'>Map rotation has chosen [VM.friendlyname] for next round!</span>"

*/


var/datum/votablemap/nextmap

/proc/changemap(var/datum/votablemap/VM)
	if (!SERVERTOOLS)
		return
	if (!istype(VM))
		return

	log_game("Changing map to [VM.name]([VM.friendlyname])")
	var/file = file("setnewmap.bat")
	file << "\nset MAPROTATE=[VM.name]\n"
	. = shell("..\\bin\\maprotate.bat")
	switch (.)
		if (null)
			message_admins("Failed to change map: Could not run map rotator")
			log_game("Failed to change map: Could not run map rotator")
		if (0)
			log_game("Changed to map [VM.friendlyname]")
			nextmap = VM
		//1x: file errors
		if (11)
			message_admins("Failed to change map: File error: Map rotator script couldn't find file listing new map")
			log_game("Failed to change map: File error: Map rotator script couldn't find file listing new map")
		if (12)
			message_admins("Failed to change map: File error: Map rotator script couldn't find tgstation-server framework")
			log_game("Failed to change map: File error: Map rotator script couldn't find tgstation-server framework")
		//2x: conflicting operation errors
		if (21)
			message_admins("Failed to change map: Conflicting operation error: Current server update operation detected")
			log_game("Failed to change map: Conflicting operation error: Current server update operation detected")
		if (22)
			message_admins("Failed to change map: Conflicting operation error: Current map rotation operation detected")
			log_game("Failed to change map: Conflicting operation error: Current map rotation operation detected")
		//3x: external errors
		if (31)
			message_admins("Failed to change map: External error: Could not compile new map:[VM.name]")
			log_game("Failed to change map: External error: Could not compile new map:[VM.name]")

		else
			message_admins("Failed to change map: Unknown error: Error code #[.]")
			log_game("Failed to change map: Unknown error: Error code #[.]")




/datum/configuration/proc/loadmaplist(filename)
	var/list/Lines = file2list(filename)
	var/datum/votablemap/currentmap = null
	for(var/t in Lines)
		if(!t)	continue
		t = trim(t)
		if(length(t) == 0)
			continue
		else if(copytext(t, 1, 2) == "#")
			continue
		var/pos = findtext(t, " ")
		var/command = null
		var/data = null
		if(pos)
			command = lowertext(copytext(t, 1, pos))
			data = copytext(t, pos + 1)
		else
			command = lowertext(t)
		if(!command)
			continue
		if (!currentmap && command != "map")
			continue
		switch (command)
			if ("map")
				currentmap = new (data)
			if ("friendlyname")
				currentmap.friendlyname = data
			if ("minplayers","minplayer")
				currentmap.minusers = text2num(data)
			if ("maxplayers","maxplayer")
				currentmap.maxusers = text2num(data)
			if ("friendlyname")
				currentmap.friendlyname = data
			if ("weight","voteweight")
				currentmap.voteweight = text2num(data)
			if ("default","defaultmap")
				config.defaultmap = currentmap
			if ("endmap")
				config.maplist[currentmap.name] = currentmap
				currentmap = null
			else
				diary << "Unknown command in map vote config: '[command]'"




/datum/votablemap
	var/name = ""
	var/friendlyname = ""
	var/minusers = 0
	var/maxusers = 0
	var/voteweight = 1

/datum/votablemap/New(name)
	src.name = name
	src.friendlyname = name




/client/proc/adminchangemap()
	set category = "Server"
	set name = "Change Map"
	var/list/maprotatechoices = list()
	for (var/map in config.maplist)
		var/datum/votablemap/VM = config.maplist[map]
		var/mapname = VM.friendlyname
		if (VM == config.defaultmap)
			mapname += " (Default)"

		if (VM.minusers > 0 || VM.maxusers > 0)
			mapname += " \["
			if (VM.minusers > 0)
				mapname += "[VM.minusers]"
			else
				mapname += "0"
			mapname += "-"
			if (VM.maxusers > 0)
				mapname += "[VM.maxusers]"
			else
				mapname += "inf"
			mapname += "\]"

		maprotatechoices[mapname] = VM
	var/chosenmap = input("Choose a map to change to", "Change Map")  as null|anything in maprotatechoices
	if (!chosenmap)
		return
	//ticker.maprotatechecked = 1
	var/datum/votablemap/VM = maprotatechoices[chosenmap]
	message_admins("[key_name(usr)] is changing the map to [VM.name]([VM.friendlyname])")
	log_admin("[key_name(usr)] is changing the map to [VM.name]([VM.friendlyname])")
	if (changemap(VM) == 0)
		message_admins("[key_name(usr)] has changed the map to [VM.name]([VM.friendlyname])")


/proc/file2list(filename, seperator="\n")
	return splittext(return_file_text(filename),seperator)