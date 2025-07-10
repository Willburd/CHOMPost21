/obj/item/grenade/dephasing
	name = "dephasing grenade"
	origin_tech = list(TECH_BLUESPACE = 4, TECH_COMBAT = 2)
	var/max_range = 7

/obj/item/grenade/dephasing/detonate()
	..()

	for(var/mob/M in range(max_range, get_turf(src)))
		var/mob/living/carbon/human/H = M
		if(istype(H))
			var/datum/component/shadekin/SK = H.get_shadekin_component()
			if(SK && SK.in_phase) //Shadekin
				SK.attack_dephase(null, src)
		M << 'sound/effects/EMPulse.ogg'

	new/obj/effect/effect/sparks(src.loc)
	new/obj/effect/effect/smoke/illumination(loc, 5, 30, 30, "#FFFFFF")

	qdel(src)
