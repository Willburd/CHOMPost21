//Interactions
/turf/simulated/wall/proc/toggle_open(var/mob/user)

	if(can_open == WALL_OPENING)
		return

	SSradiation.resistance_cache.Remove(src)

	if(density)
		can_open = WALL_OPENING
		//flick("[material.icon_base]fwall_opening", src)
		density = FALSE
		blocks_air = ZONE_BLOCKED
		update_icon()
		update_air()
		set_light(0)
		src.blocks_air = 0
		set_opacity(0)
		for(var/turf/simulated/turf in loc)
			SSair.mark_for_update(turf)
	else
		can_open = WALL_OPENING
		//flick("[material.icon_base]fwall_closing", src)
		density = TRUE
		blocks_air = AIR_BLOCKED
		update_icon()
		update_air()
		set_light(1)
		src.blocks_air = 1
		set_opacity(1)
		for(var/turf/simulated/turf in loc)
			SSair.mark_for_update(turf)

	can_open = WALL_CAN_OPEN
	update_icon()

/turf/simulated/wall/proc/update_air()
	if(!SSair)
		return

	for(var/turf/simulated/turf in loc)
		update_thermal(turf)
		SSair.mark_for_update(turf)


/turf/simulated/wall/proc/update_thermal(var/turf/simulated/source)
	if(istype(source))
		if(density && opacity)
			source.thermal_conductivity = WALL_HEAT_TRANSFER_COEFFICIENT
		else
			source.thermal_conductivity = initial(source.thermal_conductivity)

/turf/simulated/wall/proc/fail_smash(var/mob/user)
	var/damage_lower = 25
	var/damage_upper = 75
	if(isanimal(user))
		var/mob/living/simple_mob/S = user
		playsound(src, S.attack_sound, 75, 1)
		if(!(S.melee_damage_upper >= STRUCTURE_MIN_DAMAGE_THRESHOLD * 2))
			to_chat(user, span_notice("You bounce against the wall."))
			return FALSE
		damage_lower = S.melee_damage_lower
		damage_upper = S.melee_damage_upper
	to_chat(user, span_danger("You smash against the wall!"))
	user.do_attack_animation(src)
	take_damage(rand(damage_lower,damage_upper))

/turf/simulated/wall/proc/success_smash(var/mob/user)
	to_chat(user, span_danger("You smash through the wall!"))
	user.do_attack_animation(src)
	if(isanimal(user))
		var/mob/living/simple_mob/S = user
		playsound(src, S.attack_sound, 75, 1)
	spawn(1)
		dismantle_wall(1)

/turf/simulated/wall/proc/try_touch(var/mob/user, var/rotting)

	if(rotting)
		if(reinf_material)
			to_chat(user, span_danger("\The [reinf_material.display_name] feels porous and crumbly."))
		else
			to_chat(user, span_danger("\The [material.display_name] crumbles under your touch!"))
			dismantle_wall()
			return 1

	if(!can_open)
		if(!material.wall_touch_special(src, user))
			to_chat(user, span_notice("You push the wall, but nothing happens."))
			playsound(src, 'sound/weapons/genhit.ogg', 25, 1)
	else
		toggle_open(user)
	return 0

/turf/simulated/wall/attack_ai(var/mob/user)
	if(!Adjacent(user))
		return
	if(!isrobot((user)))
		return
	var/rotting = (locate(/obj/effect/overlay/wallrot) in src)
	try_touch(user, rotting)

/turf/simulated/wall/attack_hand(var/mob/user)

	radiate()
	add_fingerprint(user)
	user.setClickCooldown(user.get_attack_speed())
	var/rotting = (locate(/obj/effect/overlay/wallrot) in src)
	if (HULK in user.mutations)
		if (rotting || !prob(material.hardness))
			success_smash(user)
		else
			fail_smash(user)
			return 1

	try_touch(user, rotting)

/turf/simulated/wall/attack_generic(var/mob/user, var/damage, var/attack_message)

	radiate()
	user.setClickCooldown(user.get_attack_speed())
	var/rotting = (locate(/obj/effect/overlay/wallrot) in src)
	if(damage < STRUCTURE_MIN_DAMAGE_THRESHOLD * 2)
		try_touch(user, rotting)
		return

	if(rotting)
		return success_smash(user)

	if(reinf_material)
		if(damage >= max(material.hardness, reinf_material.hardness) )
			return success_smash(user)
	else if(damage >= material.hardness)
		return success_smash(user)
	return fail_smash(user)

/turf/simulated/wall/attackby(var/obj/item/W, var/mob/user, attack_modifier, click_parameters)

	user.setClickCooldown(user.get_attack_speed(W))

	// Outpost 21 addition begin - Slamming heads into walls
	if(isliving(user) && istype(W,/obj/item/grab))
		var/mob/living/L = user
		var/damage_done = L.slam_grabbed_mob_against_thing(W)
		if(damage_done > -1)
			var/obj/item/grab/G = W
			var/mob/living/throw_mob = G.throw_held()
			if(throw_mob)
				// SMACK wall till it breaks!
				if(L.zone_sel.selecting != BP_HEAD)
					to_chat(L, span_danger("Slammed [throw_mob] into the wall!"))
					if(damage_done >= STRUCTURE_MIN_DAMAGE_THRESHOLD * 2) attack_generic(L,damage_done,"slammed")
				else
					to_chat(L, span_danger("Slammed [throw_mob] by the head into the wall"))
					if(damage_done >= STRUCTURE_MIN_DAMAGE_THRESHOLD * 2) attack_generic(L,damage_done,"slammed")
		return
	// Outpost 21 addition end

/*
//As with the floors, only this time it works AND tries pushing the wall after it's done.
	if(!construction_stage && user.a_intent == I_HELP)
		if(try_graffiti(user,W, click_parameters))
			return
*/

	if (!user.IsAdvancedToolUser())
		to_chat(user, span_warning("You don't have the dexterity to do this!"))
		return

	//get the user's location
	if(!istype(user.loc, /turf))
		return	//can't do this stuff whilst inside objects and such

	if(W)
		radiate()
		if(is_hot(W))
			burn(is_hot(W))

	if(istype(W, /obj/item/electronic_assembly/wallmount))
		var/obj/item/electronic_assembly/wallmount/IC = W
		IC.mount_assembly(src, user)
		return

	if(istype(W, /obj/item/stack/tile/roofing))
		var/expended_tile = FALSE // To track the case. If a ceiling is built in a multiz zlevel, it also necessarily roofs it against weather
		var/turf/T = GetAbove(src)
		var/obj/item/stack/tile/roofing/R = W

		// Place plating over a wall
		if(T)
			if(isopenturf(T))
				if(R.use(1)) // Cost of roofing tiles is 1:1 with cost to place lattice and plating
					T.ReplaceWithLattice()
					T.ChangeTurf(/turf/simulated/floor, preserve_outdoors = TRUE)
					playsound(src, 'sound/weapons/genhit.ogg', 50, 1)
					user.visible_message(span_notice("[user] patches a hole in the ceiling."), span_notice("You patch a hole in the ceiling."))
					expended_tile = TRUE
			else
				to_chat(user, span_warning("There aren't any holes in the ceiling to patch here."))
				return

		// Create a ceiling to shield from the weather
		if(is_outdoors())
			if(expended_tile || R.use(1)) // Don't need to check adjacent turfs for a wall, we're building on one
				make_indoors()
				if(!expended_tile) // Would've already played a sound
					playsound(src, 'sound/weapons/genhit.ogg', 50, 1)
				user.visible_message(span_notice("[user] roofs \the [src], shielding it from the elements."), span_notice("You roof \the [src] tile, shielding it from the elements."))
		return


	if(locate(/obj/effect/overlay/wallrot) in src)
		if(W.has_tool_quality(TOOL_WELDER))
			var/obj/item/weldingtool/WT = W.get_welder()
			if( WT.remove_fuel(0,user) )
				to_chat(user, span_notice("You burn away the fungi with \the [WT]."))
				playsound(src, WT.usesound, 10, 1)
				for(var/obj/effect/overlay/wallrot/WR in src)
					qdel(WR)
				return
		else if(!is_sharp(W) && W.force >= 10 || W.force >= 20)
			to_chat(user, span_notice("\The [src] crumbles away under the force of your [W.name]."))
			src.dismantle_wall(1)
			return

	//THERMITE related stuff. Calls src.thermitemelt() which handles melting simulated walls and the relevant effects
	if(thermite)
		if(W.has_tool_quality(TOOL_WELDER))
			var/obj/item/weldingtool/WT = W.get_welder()
			if( WT.remove_fuel(0,user) )
				thermitemelt(user)
				return

		else if(istype(W, /obj/item/pickaxe/plasmacutter))
			thermitemelt(user)
			return

		else if( istype(W, /obj/item/melee/energy/blade) )
			var/obj/item/melee/energy/blade/EB = W

			EB.spark_system.start()
			to_chat(user, span_notice("You slash \the [src] with \the [EB]; the thermite ignites!"))
			playsound(src, "sparks", 50, 1)
			playsound(src, 'sound/weapons/blade1.ogg', 50, 1)

			thermitemelt(user)
			return

	var/turf/T = user.loc	//get user's location for delay checks

	if(damage && W.has_tool_quality(TOOL_WELDER))

		var/obj/item/weldingtool/WT = W.get_welder()

		if(!WT.isOn())
			return

		if(WT.remove_fuel(0,user))
			to_chat(user, span_notice("You start repairing the damage to [src]."))
			playsound(src, WT.usesound, 100, 1)
			if(do_after(user, max(5, damage / 5) * WT.toolspeed) && WT && WT.isOn())
				to_chat(user, span_notice("You finish repairing the damage to [src]."))
				take_damage(-damage)
		else
			to_chat(user, span_notice("You need more welding fuel to complete this task."))
			return
		user.update_examine_panel(src)
		return

	// Basic dismantling.
	//var/dismantle_toolspeed = 0
	if(isnull(construction_stage) || !reinf_material)

		var/cut_delay = 60 - material.cut_delay
		var/dismantle_verb
		var/dismantle_sound

		if(W.has_tool_quality(TOOL_WELDER))
			var/obj/item/weldingtool/WT = W.get_welder()
			if(!WT.isOn())
				return
			if(!WT.remove_fuel(0,user))
				to_chat(user, span_notice("You need more welding fuel to complete this task."))
				return
			dismantle_verb = "cutting"
			dismantle_sound = W.usesound
		//	cut_delay *= 0.7 // Tools themselves now can shorten the time it takes.
		else if(istype(W,/obj/item/melee/energy/blade))
			dismantle_sound = "sparks"
			dismantle_verb = "slicing"
			//dismantle_toolspeed = 1
			cut_delay *= 0.5
		else if(istype(W,/obj/item/pickaxe))
			var/obj/item/pickaxe/P = W
			dismantle_verb = P.drill_verb
			dismantle_sound = P.drill_sound
			cut_delay -= P.digspeed

		if(dismantle_verb)

			to_chat(user, span_notice("You begin [dismantle_verb] through the outer plating."))
			if(dismantle_sound)
				playsound(src, dismantle_sound, 100, 1)

			if(cut_delay < 0)
				cut_delay = 0

			if(!do_after(user,cut_delay * W.toolspeed))
				return

			to_chat(user, span_notice("You remove the outer plating."))
			dismantle_wall()
			user.visible_message(span_warning("The wall was torn open by [user]!"))
			return

	//Reinforced dismantling.
	else
		switch(construction_stage)
			if(6)
				if (W.has_tool_quality(TOOL_WIRECUTTER))
					playsound(src, W.usesound, 100, 1)
					construction_stage = 5
					user.update_examine_panel(src)
					to_chat(user, span_notice("You cut through the outer grille."))
					update_icon()
					return
			if(5)
				if (W.has_tool_quality(TOOL_SCREWDRIVER))
					to_chat(user, span_notice("You begin removing the support lines."))
					playsound(src, W.usesound, 100, 1)
					if(!do_after(user,40 * W.toolspeed) || !istype(src, /turf/simulated/wall) || construction_stage != 5)
						return
					construction_stage = 4
					user.update_examine_panel(src)
					update_icon()
					to_chat(user, span_notice("You unscrew the support lines."))
					return
				else if (W.has_tool_quality(TOOL_WIRECUTTER))
					construction_stage = 6
					user.update_examine_panel(src)
					to_chat(user, span_notice("You mend the outer grille."))
					playsound(src, W.usesound, 100, 1)
					update_icon()
					return
			if(4)
				var/cut_cover
				if(W.has_tool_quality(TOOL_WELDER))
					var/obj/item/weldingtool/WT = W.get_welder()
					if(!WT.isOn())
						return
					if(WT.remove_fuel(0,user))
						cut_cover=1
					else
						to_chat(user, span_notice("You need more welding fuel to complete this task."))
						return
				else if (istype(W, /obj/item/pickaxe/plasmacutter))
					cut_cover = 1
				if(cut_cover)
					to_chat(user, span_notice("You begin slicing through the metal cover."))
					playsound(src, W.usesound, 100, 1)
					if(!do_after(user, 60 * W.toolspeed) || !istype(src, /turf/simulated/wall) || construction_stage != 4)
						return
					construction_stage = 3
					user.update_examine_panel(src)
					update_icon()
					to_chat(user, span_notice("You press firmly on the cover, dislodging it."))
					return
				else if (W.has_tool_quality(TOOL_SCREWDRIVER))
					to_chat(user, span_notice("You begin screwing down the support lines."))
					playsound(src, W.usesound, 100, 1)
					if(!do_after(user,40 * W.toolspeed) || !istype(src, /turf/simulated/wall) || construction_stage != 4)
						return
					construction_stage = 5
					user.update_examine_panel(src)
					update_icon()
					to_chat(user, span_notice("You screw down the support lines."))
					return
			if(3)
				if (W.has_tool_quality(TOOL_CROWBAR))
					to_chat(user, span_notice("You struggle to pry off the cover."))
					playsound(src, W.usesound, 100, 1)
					if(!do_after(user,100 * W.toolspeed) || !istype(src, /turf/simulated/wall) || construction_stage != 3)
						return
					construction_stage = 2
					user.update_examine_panel(src)
					update_icon()
					to_chat(user, span_notice("You pry off the cover."))
					return
			if(2)
				if (W.has_tool_quality(TOOL_WRENCH))
					to_chat(user, span_notice("You start loosening the anchoring bolts which secure the support rods to their frame."))
					playsound(src, W.usesound, 100, 1)
					if(!do_after(user,40 * W.toolspeed) || !istype(src, /turf/simulated/wall) || construction_stage != 2)
						return
					construction_stage = 1
					user.update_examine_panel(src)
					update_icon()
					to_chat(user, span_notice("You remove the bolts anchoring the support rods."))
					return
			if(1)
				var/cut_cover
				if(W.has_tool_quality(TOOL_WELDER))
					var/obj/item/weldingtool/WT = W.get_welder()
					if( WT.remove_fuel(0,user) )
						cut_cover=1
					else
						to_chat(user, span_notice("You need more welding fuel to complete this task."))
						return
				else if(istype(W, /obj/item/pickaxe/plasmacutter))
					cut_cover = 1
				if(cut_cover)
					to_chat(user, span_notice("You begin slicing through the support rods."))
					playsound(src, W.usesound, 100, 1)
					if(!do_after(user,70 * W.toolspeed) || !istype(src, /turf/simulated/wall) || construction_stage != 1)
						return
					construction_stage = 0
					user.update_examine_panel(src)
					update_icon()
					to_chat(user, span_notice("You slice through the support rods."))
					return
			if(0)
				if(W.has_tool_quality(TOOL_CROWBAR))
					to_chat(user, span_notice("You struggle to pry off the outer sheath."))
					playsound(src, W.usesound, 100, 1)
					if(!do_after(user,100 * W.toolspeed) || !istype(src, /turf/simulated/wall) || !user || !W || !T )
						return
					if(user.loc == T && user.get_active_hand() == W )
						to_chat(user, span_notice("You pry off the outer sheath."))
						dismantle_wall()
					return

	if(istype(W,/obj/item/frame))
		var/obj/item/frame/F = W
		F.try_build(src, user)
		return

	else if(!istype(W,/obj/item/rcd) && !istype(W, /obj/item/reagent_containers))
		return attack_hand(user)
