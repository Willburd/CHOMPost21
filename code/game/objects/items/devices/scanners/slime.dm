/obj/item/slime_scanner
	name = "slime scanner"
	icon = 'icons/obj/device.dmi'
	icon_state = "xenobio"
	item_state = "xenobio"
	w_class = ITEMSIZE_SMALL
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	matter = list(MAT_STEEL = MATERIAL_COST(0.015),MAT_GLASS = MATERIAL_COST(0.01))
	pickup_sound = 'sound/items/pickup/device.ogg'
	drop_sound = 'sound/items/drop/device.ogg'
// Outpost 21 edit begin - Ranged slime scanner
	var/is_advanced = FALSE

/obj/item/slime_scanner/advanced
	name = "advanced slime scanner"
	desc = "Now with long distance scanning capabilities!"
	icon_state = "xenobio_old2"
	is_advanced = TRUE

/obj/item/slime_scanner/attack(mob/living/M, mob/living/user, target_zone, attack_modifier)
	if(!istype(M, /mob/living/simple_mob/slime/xenobio))
		to_chat(user, span_infoplain(span_bold("This device can only scan lab-grown slimes!")))
		return ITEM_INTERACT_FAILURE

	perform_slime_scan(M, user)
	return ITEM_INTERACT_SUCCESS

/obj/item/slime_scanner/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if(!is_advanced)
		return
	if(!istype(target, /mob/living/simple_mob/slime/xenobio))
		return
	var/turf/user_turf = get_turf(user)
	var/turf/target_turf = get_turf(target)
	if(user_turf.Distance(target_turf) > 5)
		return
	user.Beam(target, icon_state = "rped_upgrade", time = 1 SECOND)
	perform_slime_scan(target, user)

/obj/item/slime_scanner/proc/perform_slime_scan(mob/living/M, mob/living/user)
	playsound(src, 'sound/machines/beep.ogg', 50)

	var/mob/living/simple_mob/slime/xenobio/S = M
	user.show_message("Slime scan results:<br>[S.slime_color] [S.is_adult ? "adult" : "baby"] slime<br>Health: [S.health]<br>Mutation Probability: [S.mutation_chance]")

	var/list/mutations = list()
	for(var/potential_color in S.slime_mutation)
		var/mob/living/simple_mob/slime/xenobio/slime = potential_color
		mutations.Add(initial(slime.slime_color))
	user.show_message("Potental to mutate into [english_list(mutations)] colors.<br>Extract potential: [S.cores]<br>Nutrition: [S.nutrition]/[S.max_nutrition]")

	if (S.nutrition < S.get_starve_nutrition())
		user.show_message(span_warning("Warning: Subject is starving!"))
	else if (S.nutrition < S.get_hunger_nutrition())
		user.show_message(span_warning("Warning: Subject is hungry."))
	user.show_message("Electric change strength: [S.power_charge]")

	if(S.has_AI())
		var/datum/ai_holder/simple_mob/xenobio_slime/AI = S.ai_holder
		if(AI.resentment)
			user.show_message(span_warning("Warning: Subject is harboring resentment."))
		if(AI.rabid)
			user.show_message(span_danger("Subject is enraged and extremely dangerous!"))
	if(S.harmless)
		user.show_message("Subject has been pacified.")
	if(S.unity)
		user.show_message("Subject is friendly to other slime colors.")

	user.show_message("Growth progress: [S.amount_grown]/10")
// Outpost 21 edit end
