/mob/living/critter/wendigo
	name = "wendigo"
	real_name = "wendigo"
	desc = "Oh god."
	density = 1
	icon_state = "wendigo"
	icon_state_dead = "wendigo-dead"
	custom_gib_handler = /proc/gibs
	hand_count = 2
	can_throw = 1
	can_grab = 1
	can_disarm = 1
	blood_id = "beff"
	burning_suffix = "humanoid"

/mob/living/critter/wendigo/specific_emotes(var/act, var/param = null, var/voluntary = 0)
	switch (act)
		if ("scream")
			if (src.emote_check(voluntary, 50))
				playsound(get_turf(src), "sound/misc/wendigo_roar.ogg", 80, 1)
				return "<b><span style='color:red'>[src] howls!</span></b>"
	return null

/mob/living/critter/wendigo/specific_emote_type(var/act)
	switch (act)
		if ("scream")
			return 2
	return ..()

/mob/living/critter/wendigo/setup_equipment_slots()
	equipment += new /datum/equipmentHolder/suit(src)
	equipment += new /datum/equipmentHolder/ears(src)
	equipment += new /datum/equipmentHolder/head(src)

/mob/living/critter/wendigo/setup_hands()
	..()
	var/datum/handHolder/HH = hands[1]
	HH.limb = new /datum/limb/wendigo
	HH.icon_state = "handl"				// the icon state of the hand UI background
	HH.limb_name = "left wendigo arm"

	HH = hands[2]
	HH.limb = new /datum/limb/wendigo
	HH.name = "right hand"
	HH.suffix = "-R"
	HH.icon_state = "handr"				// the icon state of the hand UI background
	HH.limb_name = "right wendigo arm"

/mob/living/critter/wendigo/New()
	..()
	abilityHolder.addAbility(/datum/targetable/critter/fadeout/wendigo)
	abilityHolder.addAbility(/datum/targetable/critter/tackle)
	abilityHolder.addAbility(/datum/targetable/critter/frenzy)

/mob/living/critter/wendigo/setup_healths()
	add_hh_flesh(-100, 100, 0.85)
	add_hh_flesh_burn(-100, 100, 1.4)
	add_health_holder(/datum/healthHolder/toxin)
	add_health_holder(/datum/healthHolder/brain)
