/obj/effect/portal/portal_redspace
	name = "portal"
	desc = "Looks unstable. Best to test it with the clown."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "portal"
	var/return_portal = FALSE

/obj/effect/portal/portal_redspace/teleport(atom/movable/M as mob|obj)
	if(istype(M, /obj/effect)) //sparks don't teleport
		return
	if (M.anchored&&istype(M, /obj/mecha))
		return
	if (icon_state == "portal1")
		return
	if (!( target ))
		qdel(src)
		return
	if (istype(M, /atom/movable))
		//VOREStation Addition Start: Prevent taurriding abuse
		if(istype(M, /mob/living))
			var/mob/living/L = M
			if(LAZYLEN(L.buckled_mobs))
				var/datum/riding/R = L.riding_datum
				for(var/rider in L.buckled_mobs)
					R.force_dismount(rider)
		//VOREStation Addition End: Prevent taurriding abuse
		if(return_portal)
			var/list/redexitlist = list()
			for(var/obj/effect/landmark/R in landmarks_list)
				if(R.name == "redexit")
					redexitlist += R

			if(redexitlist.len > 0)
				var/obj/effect/landmark/L = pick( redexitlist)
				do_teleport(M, L.loc, 0,local = FALSE, bohsafe = TRUE)
			else
				do_teleport(M, target, 1)  // fail...

			// passout on return to reality
			if(ishuman(M))
				var/mob/living/carbon/human/H = M
				H.AdjustSleeping(15)
				H.AdjustWeakened(3)
				H.adjustHalLoss(-9)
			return
		else
			var/list/redlist = list()
			for(var/obj/effect/landmark/R in landmarks_list)
				if(R.name == "redentrance")
					redlist += R

			if(redlist.len > 0)
				// if teleport worked, drop out... otherwise just teleport normally, it means there was no redspace spawns!
				var/obj/effect/landmark/L = pick( redlist)
				do_teleport(M, L.loc, 0,local = FALSE, bohsafe = TRUE)
				return
