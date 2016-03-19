//im coder

/obj/item/storage/backpack/satchel
	name = "satchel"
	icon_state = "satchel"
	item_state = "satchel"
	inhand_image_icon = 'icons/mob/inhand/hand_general.dmi'
	desc = "A thick, wearable container made of synthetic fibers, able to carry a number of objects comfortably on a crewmember's shoulder."

/obj/item/storage/backpack/satchel/NT
	name = "NT satchel"
	icon_state = "NTsatchel"
	item_state = "NTsatchel"

/obj/item/storage/backpack/satchel/medic
	name = "medic satchel"
	icon_state = "satchel_medic"
	item_state = "satchel_medic"

/obj/item/clothing/mask/gas/swat
	name = "SWAT gas mask"
	desc = "A snazzy-looking black gas mask."
	icon_state = "swat"
	item_state = "swat"

/obj/item/clothing/under/pilot
	name = "pilot suit"
	desc = "A jumpsuit commonly worn by pilots."
	icon = 'icons/obj/clothing/uniforms/item_js_misc.dmi'
	inhand_image_icon = 'icons/mob/inhand/jumpsuit/hand_js_misc.dmi'
	wear_image_icon = 'icons/mob/jumpsuits/worn_js_misc.dmi'
	icon_state = "mechanic"
	item_state = "mechanic"

/obj/item/clothing/suit/labcoat/alchemist
	name = "Shadow Coat"
	desc = "This coat's tragic past is lost to time, but its style isn't."
	inhand_image_icon = 'icons/mob/inhand/inhand_cl_suit.dmi'
	icon_state = "alchrobe"
	item_state = "alchrobe"
	permeability_coefficient = 0 //it's a snazzy coat
	heat_transfer_coefficient = 0.10 //the stone doesn't do anything so the coat should be cool, right?

/obj/item/clothing/suit/dio //so this should have the stats of the leather jacket
	name = "Vampiric Robe"
	desc = "Garments commonly worn by those who have transcended humanity."
	inhand_image_icon = 'icons/mob/inhand/inhand_cl_suit.dmi'
	icon_state = "vclothes"
	item_state = "vclothes"

/obj/item/clothing/suit/inspector
	name = "inspector's short coat"
	desc = "A coat for the modern detective."
	inhand_image_icon = 'icons/mob/inhand/inhand_cl_suit.dmi'
	icon_state = "inspectorc"
	item_state = "inspectorc"

/obj/item/clothing/under/inspector
	name = "inspector's uniform"
	desc = "A uniform for the modern detective."
	icon = 'icons/obj/clothing/uniforms/item_js_misc.dmi'
	inhand_image_icon = 'icons/mob/inhand/jumpsuit/hand_js_misc.dmi'
	wear_image_icon = 'icons/mob/jumpsuits/worn_js_misc.dmi'
	icon_state = "inspectorj"
	item_state = "viceG"

/obj/item/clothing/under/rank/captain/blue/NTSO
	name = "administrator's uniform"
	desc = "A uniform specifically for NanoTrasen commanders."

/obj/item/clothing/suit/space/captain/blue/NTSO
	name = "administrator's space suit"
	desc = "An armored space suit designed specifically for NanoTrasen commanders."