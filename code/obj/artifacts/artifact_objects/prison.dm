/obj/artifact/prison
	name = "artifact imprisoner"
	associated_datum = /datum/artifact/prison

/datum/artifact/prison
	associated_object = /obj/artifact/prison
	rarity_class = 2
	min_triggers = 2
	max_triggers = 2
	validtypes = list("ancient","martian","wizard","eldritch","precursor")
	validtriggers = list(/datum/artifact_trigger/carbon_touch,/datum/artifact_trigger/silicon_touch)
	react_xray = list(15,90,90,11,"HOLLOW")
	touch_descriptors = list("You seem to have a little difficulty taking your hand off its surface.")
	var/mob/living/prisoner = null
	var/imprison_time = 0

	New()
		..()
		imprison_time = rand(50,1200)

	effect_touch(var/obj/O,var/mob/living/user)
		if (..())
			return
		if (!user)
			return
		if (prisoner)
			return
		if (istype(user,/mob/living/))
			O.visible_message("<span style=\"color:red\"><b>[O]</b> suddenly pulls [user.name] inside and slams shut!</span>")
			user.set_loc(O)
			prisoner = user
			spawn(imprison_time)
				for(var/obj/I in O.contents)
					I.set_loc(get_turf(O))
				prisoner.set_loc(get_turf(O))
				prisoner = null
				O.visible_message("<span style=\"color:red\"><b>[O]</b> releases [user.name] and shuts down!</span>")
				O.ArtifactDeactivated()
			return