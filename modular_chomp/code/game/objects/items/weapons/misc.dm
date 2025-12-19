/obj/item/melee/chainofcommand/jingle_bells
	name = "jingle bells"
	desc = "A long whip covered in jingling bells."
	icon_state = "curator_whip"
	force = 5
	throwforce = 5
	origin_tech = list(TECH_COMBAT = 2)

/obj/item/melee/chainofcommand/jingle_bells/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/topturfcrossed)

/obj/item/melee/chainofcommand/jingle_bells/Crossed(atom/movable/AM)
	. = ..()
	if(AM.is_incorporeal())
		return
	if(loc != AM) // Must be in a mob's hand
		return
	if(prob(30))
		playsound(src, 'modular_outpost/sound/misc/jbells.ogg', 90, 1)
