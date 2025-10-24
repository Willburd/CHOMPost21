/obj/effect/portal/portal_redspace
	name = "portal"
	desc = "Looks unstable. Best to test it with the clown."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "portal"
	var/return_portal = FALSE

/obj/effect/portal/portal_redspace/teleport(atom/movable/M)
	if(istype(M, /obj/effect)) //sparks don't teleport
		return
	if(M.anchored && istype(M, /obj/mecha))
		return
	if(icon_state == "portal1")
		return
	if(istype(M, /atom/movable))
		if(return_portal)
			send_to_realspace(M, TRUE)
		else
			send_to_redspace(M)

/proc/send_to_redspace(mob/M)
	if(istype(M, /mob/living))
		var/mob/living/L = M
		if(LAZYLEN(L.buckled_mobs))
			var/datum/riding/R = L.riding_datum
			for(var/rider in L.buckled_mobs)
				R.force_dismount(rider)

	var/list/redlist = list()
	for(var/obj/effect/landmark/R in GLOB.landmarks_list)
		if(R.name == "redentrance")
			redlist += R

	if(redlist.len > 0)
		// if teleport worked, drop out... otherwise just teleport normally, it means there was no redspace spawns!
		var/obj/effect/landmark/L = pick( redlist)
		do_teleport(M, L.loc, 0,local = FALSE, bohsafe = TRUE)

/proc/send_to_realspace(mob/M, has_message)
	if(istype(M, /mob/living))
		var/mob/living/L = M
		if(LAZYLEN(L.buckled_mobs))
			var/datum/riding/R = L.riding_datum
			for(var/rider in L.buckled_mobs)
				R.force_dismount(rider)

	var/list/redexitlist = list()
	for(var/obj/effect/landmark/R in GLOB.landmarks_list)
		if(R.name == "redexit")
			redexitlist += R

	if(redexitlist.len > 0)
		var/obj/effect/landmark/L = pick( redexitlist)
		do_teleport(M, L.loc, 0,local = FALSE, bohsafe = TRUE)
	else
		do_teleport(M, get_turf(M), 1)  // fail...

	// passout on return to reality
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.AdjustSleeping(15)
		H.AdjustWeakened(3)
		H.adjustHalLoss(-9)
		if(has_message && H.client)
			var/wake = tgui_alert(H, "You don't remember how you got here, but somehow you're waking up in \the [get_area(H)]. Everything you experienced in the other world feels like a hazy and unfortunate dream. Did someone spike your drink?...", "What happened?", list("Wake Up"))
			if(H.sleeping <= 15 && wake == "Wake Up")
				H.AdjustSleeping(-15)
