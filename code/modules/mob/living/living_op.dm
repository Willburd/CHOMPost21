/mob/living/proc/handle_dripping()
	if(prob(95))
		return
	if(!isturf(src.loc))
		return
	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		if(H.species && H.species.drippy)
			// drip body color if human
			var/obj/effect/decal/cleanable/blood/B
			var/decal_type = /obj/effect/decal/cleanable/blood/splatter
			var/turf/T = get_turf(src.loc)

			// Are we dripping or splattering?
			var/list/drips = list()
			// Only a certain number of drips (or one large splatter) can be on a given turf.
			for(var/obj/effect/decal/cleanable/blood/drip/drop in T)
				drips |= drop.drips
				qdel(drop)
			if(drips.len < 6)
				decal_type = /obj/effect/decal/cleanable/blood/drip

			// Find a blood decal or create a new one.
			B = locate(decal_type) in T
			if(!B)
				B = new decal_type(T)

			var/obj/effect/decal/cleanable/blood/drip/drop = B
			if(istype(drop) && drips && drips.len)
				drop.add_overlay(drips)
				drop.drips |= drips

			// Update appearance.
			B.customname = "drips of something"
			B.customdesc = "It's thick and gooey. Perhaps it's the chef's cooking?"
			B.dryname = "dried something"
			B.drydesc = "It's dry and crusty. The janitor isn't doing their job."
			B.basecolor = rgb(H.r_skin,H.g_skin,H.b_skin)
			B.update_icon()
			B.fluorescent  = 0
			B.invisibility = 0
	//else
		// come up with drips for other mobs someday
