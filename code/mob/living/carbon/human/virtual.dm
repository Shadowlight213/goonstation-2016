/mob/living/carbon/human/virtual
	real_name = "Virtual Human"
	var/mob/body = null

/mob/living/carbon/human/virtual/New()
	..()
	sound_burp = 'sound/voice/virtual_gassy.ogg'
	sound_malescream = 'sound/voice/virtual_scream.ogg'
	sound_femalescream = 'sound/voice/virtual_scream.ogg'
	sound_fart = 'sound/voice/virtual_gassy.ogg'
	sound_snap = 'sound/voice/virtual_snap.ogg'
	sound_fingersnap = 'sound/voice/virtual_snap.ogg'
	spawn(0)
		src.set_mutantrace(/datum/mutantrace/virtual)

/mob/living/carbon/human/virtual/Life(datum/controller/process/mobs/parent)
	if (!loc)
		return
	if (..(parent))
		return 1
	var/turf/T = get_turf(src)
	var/area/A = get_area(src)
	if ((T && !(T.z == 2 || T.z == 4)) || (A && !A.virtual))
		boutput(src, "<span style=\"color:red\">Is this virtual?  Is this real?? <b>YOUR MIND CANNOT TAKE THIS METAPHYSICAL CALAMITY</b></span>")
		src.gib()
		return

	if(src.body)
		if(src.body.stat == 2 || !src.body:network_device)
			Station_VNet.Leave_Vspace(src)
			return
	return

/mob/living/carbon/human/virtual/death(gibbed)
	for (var/atom/movable/a in contents)
		if (a.flags & ISADVENTURE)
			a.set_loc(get_turf(src))
	if (Station_VNet.Leave_Vspace(src))
		del src
		return
	..()

/mob/living/carbon/human/virtual/ex_act(severity)
	src.flash(30)
	if(severity == 1)
		src.death()
	return
