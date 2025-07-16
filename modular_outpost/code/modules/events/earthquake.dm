/datum/event/quake
	announceWhen = 1
	startWhen = 20

/datum/event/quake/announce()
	command_announcement.Announce("Sudden seismic activity detected in lower crust. Possible tectonic event incoming. All personnel should seek structurally safe locations and stay low to the ground.", "Structural Alert")

/datum/event/quake/start()
	var/datum/planet/P = pick(SSplanets.planets)
	if(!P)
		return

	affecting_z = P.expected_z_levels.Copy()
	if(!affecting_z.len)
		return

	// Vibe lights
	for(var/obj/machinery/light/L in GLOB.machines)
		if(!(L.z in affecting_z))
			continue
		if(prob(6))
			L.broken()
		else if(prob(12))
			L.flicker(16)
	// break windows
	for(var/obj/structure/S in world)
		if(!(S.z in affecting_z))
			continue
		if(istype(S,/obj/structure/window))
			if(prob(9))
				S.take_damage(12 + rand(60))
		if(istype(S,/obj/structure/table))
			if(prob(8))
				var/obj/structure/table/T = S
				T.flip(pick(GLOB.cardinal))
	// Stun and knock down anyone standing
	for(var/mob/living/L in GLOB.living_mob_list)
		if(!(L.z in affecting_z))
			continue
		if(isAI(L))
			continue
		if(istype(L,/mob/living/carbon/human/monkey/auto_doc))
			continue
		if(L.stat != CONSCIOUS)
			continue
		if(L.resting)
			continue
		L.Confuse(8)
		L.make_dizzy(10)
		L.Weaken(4)
		playsound(L, "punch", 60, 1)
		shake_camera(L, 4, 1)
		// sound
		if(L.client && (L.ear_deaf <= 0 || !L.ear_deaf))
			if(!istype(L.loc,/turf/space))
				L << 'sound/effects/explosionfar.ogg'
