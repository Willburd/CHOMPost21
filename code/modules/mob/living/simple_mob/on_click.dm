/*
	Animals
*/
/mob/living/simple_mob/UnarmedAttack(var/atom/A, var/proximity)
	if(!(. = ..()))
		return

//	setClickCooldown(get_attack_speed())

	if(has_hands && istype(A,/obj) && a_intent != I_HURT)
		var/obj/O = A
		return O.attack_hand(src)

	// Outpost 21 edit begin - borers cannot prod from inside host
	if(istype(src,/mob/living/simple_mob/animal/borer) && istype(loc,/mob))
		to_chat(src,"You cannot interact with that from inside a host!")
		return
	// Outpost 21 edit end

	switch(a_intent)
		if(I_HELP)

			if(isliving(A))
				var/mob/living/L = A
				if(istype(L) && (!has_hands || !L.attempt_to_scoop(src)))
					if(src.zone_sel.selecting == BP_GROIN) //CHOMPEdit
						if(src.vore_bellyrub(A)) //ChompEDIT
							return //ChompEDIT
					automatic_custom_emote(VISIBLE_MESSAGE,"[pick(friendly)] \the [A]!", check_stat = TRUE)
			if(istype(A,/obj/structure/micro_tunnel))	//Allows simplemobs to click on mouse holes, mice should be allowed to go in mouse holes, and other mobs
				var/obj/structure/micro_tunnel/t = A	//should be allowed to drag the mice out of the mouse holes!
				t.tunnel_interact(src)

		if(I_HURT)
			if(can_special_attack(A) && special_attack_target(A))
				return

			else if(melee_damage_upper == 0 && isliving(A))
				automatic_custom_emote(VISIBLE_MESSAGE,"[pick(friendly)] \the [A]!", check_stat = TRUE)

			else
				attack_target(A)

		if(I_GRAB)
			if(has_hands)
				A.attack_hand(src)
			else if(isliving(A) && src.client && !vore_attack_override)
				animal_nom(A)
			else
				attack_target(A)

		if(I_DISARM)
			if(has_hands)
				A.attack_hand(src)
			else
				attack_target(A)

/mob/living/simple_mob/RangedAttack(var/atom/A)
//	setClickCooldown(get_attack_speed())

	if(can_special_attack(A) && special_attack_target(A))
		return

	if(projectiletype)
		shoot_target(A)
