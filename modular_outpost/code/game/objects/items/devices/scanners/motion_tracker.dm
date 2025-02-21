/obj/item/motiontracker
	name = "Motion Tracker"
	desc = "The \"Vibromaster V1.7\", a handheld motion tracker. Often picks up nearby vibrations as motion however."
	icon = 'icons/obj/device.dmi'
	icon_state = "forensic1"
	item_state = "analyzer"
	w_class = ITEMSIZE_SMALL
	slot_flags = SLOT_BELT
	throwforce = 5
	throw_speed = 4
	throw_range = 20

	matter = list(MAT_STEEL = 30,MAT_GLASS = 20)

	origin_tech = list(TECH_MAGNET = 1, TECH_DATA = 1)

	pickup_sound = 'sound/items/pickup/device.ogg'
	drop_sound = 'sound/items/drop/device.ogg'

/obj/item/motiontracker/Moved(atom/old_loc, direction, forced, movetime)
	. = ..()
	if(ismob(old_loc))
		var/mob/M = old_loc
		M.motiontracker_unsubscribe()
	if(ismob(loc))
		var/mob/M = loc
		M.motiontracker_subscribe()
