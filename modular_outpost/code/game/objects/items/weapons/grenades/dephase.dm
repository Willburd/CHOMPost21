/obj/item/grenade/dephasing
	name = "\improper dephasing grenade"
	origin_tech = list(TECH_BLUESPACE = 4, TECH_COMBAT = 2)
	var/max_range = 7

/obj/item/grenade/dephasing/detonate()
	..()

	// Dephase any mob nearby
	for(var/mob/living/M in range(max_range, get_turf(src)))
		var/datum/component/shadekin/SK = M.get_shadekin_component()
		if(SK && SK.in_phase) //Shadekin
			SK.attack_dephase(null, src)
		M << 'sound/effects/EMPulse.ogg'

	// Antiabuse
	if(isliving(loc))
		var/mob/living/M = loc
		if(M.l_hand == src)
			M.apply_damage(10, BRUTE, BP_L_HAND)
		if(M.r_hand == src)
			M.apply_damage(10, BRUTE, BP_R_HAND)
		M.Confuse(10)
		M.Weaken(3)
		M.ex_act(3)

	new/obj/effect/effect/sparks(src.loc)
	new/obj/effect/effect/smoke/illumination(loc, 5, 30, 30, "#FFFFFF")

	qdel(src)
