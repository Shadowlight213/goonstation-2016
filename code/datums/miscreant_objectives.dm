#ifdef CREW_OBJECTIVES


/datum/controller/gameticker/proc/generate_miscreant_objectives(datum/mind/crewMind)
	set background = 1

	if (map_setting == "DESTINY") // no really don't make any on destiny thanks
		return
	//Requirements for individual objectives: 1) You have a mind (this eliminates 90% of our playerbase ~heh~)
											//2) You are not a traitor
	if (!crewMind)
		return
	if (!crewMind.current || !crewMind.objectives || crewMind.objectives.len || crewMind.special_role || (crewMind.assigned_role == "MODE"))
		return
	if (crewMind.current && (crewMind.current.stat == 2 || isobserver(crewMind.current) || issilicon(crewMind.current) || isintangible(crewMind.current)))
		return

	var/list/objectiveTypes = typesof(/datum/objective/miscreant) - /datum/objective/miscreant
	if (!objectiveTypes.len)
		return

	var/obj_count = 1
	var/assignCount = 1 //min(rand(1,3), objectiveTypes.len)
	while (assignCount && objectiveTypes.len)
		assignCount--
		var/selectedType = pick(objectiveTypes)
		var/datum/objective/miscreant/newObjective = new selectedType
		objectiveTypes -= newObjective.type

		newObjective.owner = crewMind
		crewMind.objectives += newObjective

		if (obj_count <= 1)
			boutput(crewMind.current, "<B>You are a miscreant!</B>")
			boutput(crewMind.current, "You should try to complete your objectives, but don't commit any traitorous acts.")
			boutput(crewMind.current, "Your objective is as follows:")
		boutput(crewMind.current, "[newObjective.explanation_text]")
		obj_count++

	miscreants += crewMind

	return


/datum/objective/miscreant/protest
	explanation_text = "Try to incite a protest or riot."

/datum/objective/miscreant/damage
	explanation_text = "Cause as much property damage as possible without killing anyone."

/datum/objective/miscreant/troll
	explanation_text = "Try to get as many people as possible out for your blood."

/datum/objective/miscreant/whiny
	explanation_text = "Complain incessantly about every minor issue you can find."

/datum/objective/miscreant/blockade
	explanation_text = "Try to block off access to something under the pretense that it's too dangerous."

/datum/objective/miscreant/bailout
	explanation_text = "Whenever someone gets arrested, try to bribe, blackmail or convince security to let them go."

/datum/objective/miscreant/vigilante
	explanation_text = "Whenever someone gets arrested, try to bribe, blackmail or convince security to execute them."

/datum/objective/miscreant/murder
	explanation_text = "Without touching or harming them, annoy someone so much that they murder you."

/datum/objective/miscreant/heirlooms
	explanation_text = "Steal as many crew members' trinkets and heirlooms as possible."

/datum/objective/miscreant/destroy_items
	explanation_text = "Choose a type of item. Try to destroy every instance of it on the station under the pretense of a market recall."

/datum/objective/miscreant/litterbug
	explanation_text = "Make a huge mess wherever you go."

/datum/objective/miscreant/stalk
	explanation_text = "Single out a crew member and stalk them everywhere."

/datum/objective/miscreant/incompetent
	explanation_text = "Be as useless and incompetent as possible without getting killed."

/datum/objective/miscreant/bureaucracy
	explanation_text = "Enforce as much unwieldy bureaucracy as possible."

/datum/objective/miscreant/access
	explanation_text = "Make as much of the station as possible accessible to the public."

/datum/objective/miscreant/paranoid
	explanation_text = "Construct an impenetrable fortress for yourself on the station."

/datum/objective/miscreant/creepy
	explanation_text = "Sneak around looking as suspicious as possible without actually doing anything illegal."

/datum/objective/miscreant/strike
	explanation_text = "Try to convince your department to go on strike and refuse to do any work."

/datum/objective/miscreant/graft
	explanation_text = "See how much money you can amass by charging pointless fees, soliciting bribes or embezzling money from other crewmembers."

/datum/objective/miscreant/steal_and_sell
	explanation_text = "Steal things from crew members and attempt to auction them off for profit."

/datum/objective/miscreant/construction
	explanation_text = "Perform obnoxious construction and renovation projects. Insist that you're just doing your job."


#endif