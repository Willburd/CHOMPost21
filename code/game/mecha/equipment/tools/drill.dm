/obj/item/mecha_parts/mecha_equipment/tool/drill
	name = "drill"
	desc = "This is the drill that'll pierce the heavens!"
	icon_state = "mecha_drill"
	equip_cooldown = 30
	energy_drain = 10
	force = 15
	var/advanced = 0	//Determines if you can pierce the heavens or not. Used in diamond drill.
	required_type = list(/obj/mecha/working/ripley)

/obj/item/mecha_parts/mecha_equipment/tool/drill/action(atom/target)
	if(!action_checks(target)) return
	if(isobj(target))
		var/obj/target_obj = target
		if(!target_obj.vars.Find("unacidable") || target_obj.unacidable)	return
	set_ready_state(FALSE)
	chassis.use_power(energy_drain)
	chassis.visible_message(span_danger("[chassis] starts to drill [target]"), span_warning("You hear the drill."))
	occupant_message(span_danger("You start to drill [target]"))
	var/T = chassis.loc
	var/C = target.loc	//why are these backwards? we may never know -Pete
	if(do_after_cooldown(target))
		if(T == chassis.loc && src == chassis.selected)
			if(istype(target, /turf/simulated/wall))
				var/turf/simulated/wall/W = target
				if(W.reinf_material && !advanced)//R wall but no good drill
					occupant_message(span_warning("[target] is too durable to drill through."))
					return

				else if((W.reinf_material && advanced) || do_after_cooldown(target))//R wall with good drill
					log_message("Drilled through [target]")
					target.ex_act(3)
				else
					log_message("Drilled through [target]")
					target.ex_act(2)

			else if(ismineralturf(target))
				if(enable_special)
					for(var/turf/simulated/mineral/M in range(chassis,1))
						if(get_dir(chassis,M)&chassis.dir)
							M.GetDrilled()
				else
					var/turf/simulated/mineral/M1 = target
					M1.GetDrilled()
				log_message("Drilled through [target]")
				if(locate(/obj/item/mecha_parts/mecha_equipment/tool/hydraulic_clamp) in chassis.equipment)
					var/obj/structure/ore_box/ore_box = locate(/obj/structure/ore_box) in chassis:cargo
					if(ore_box)
						for(var/obj/item/ore/ore in range(chassis,1))
							if(get_dir(chassis,ore)&chassis.dir)
								ore_box.stored_ore[ore.material]++
								qdel(ore)
			else if(isliving(target))
				drill_mob(target, chassis.occupant)
				return 1
			else if(target.loc == C)
				log_message("Drilled through [target]")
				target.ex_act(2)
	return 1

/obj/item/mecha_parts/mecha_equipment/tool/drill/proc/drill_mob(mob/living/target, mob/user)
	add_attack_logs(user, target, "attacked", "[name]", "(INTENT: [uppertext(user.a_intent)]) (DAMTYPE: [uppertext(damtype)])")
	var/drill_force = force	//Couldn't manage it otherwise.
	if(ishuman(target))
		target.apply_damage(drill_force, BRUTE)
		return

	else if(isanimal(target))
		var/mob/living/simple_mob/S = target
		if(target.stat == DEAD)
			if(S.meat_amount > 0)
				S.harvest(user)
				return
			else
				S.gib()
				return
		else
			S.apply_damage(drill_force)
			return

/obj/item/mecha_parts/mecha_equipment/tool/drill/diamonddrill
	name = "diamond drill"
	desc = "This is an upgraded version of the drill that'll pierce the heavens!"
	icon_state = "mecha_diamond_drill"
	origin_tech = list(TECH_MATERIAL = 4, TECH_ENGINEERING = 3)
	equip_cooldown = 10
	force = 15
	advanced = 1

/obj/item/mecha_parts/mecha_equipment/tool/drill/bore
	name = "depth bore"
	desc = "This is the drill that'll pierce the depths!"
	icon_state = "mecha_bore"
	equip_cooldown = 5 SECONDS
	energy_drain = 30
	force = 20
	required_type = list(/obj/mecha/working/ripley)

/obj/item/mecha_parts/mecha_equipment/tool/drill/bore/action(atom/target)
	if(!action_checks(target)) return
	if(isobj(target))
		var/obj/target_obj = target
		if(target_obj.unacidable)	return
	set_ready_state(FALSE)
	chassis.use_power(energy_drain)
	chassis.visible_message(span_danger("[chassis] starts to bore into \the [target]"), span_warning("You hear the bore."))
	occupant_message(span_danger("You start to bore into \the [target]"))
	var/T = chassis.loc
	var/C = target.loc
	if(do_after_cooldown(target))
		if(T == chassis.loc && src == chassis.selected)
			if(istype(target, /turf/simulated/wall))
				var/turf/simulated/wall/W = target
				if(W.reinf_material)
					occupant_message(span_warning("[target] is too durable to bore through."))
				else
					log_message("Bored through [target]")
					target.ex_act(2)
			else if(ismineralturf(target))
				var/turf/simulated/mineral/M = target
				if(enable_special && !M.density)
					M.ex_act(2)
					log_message("Bored into [target]")
				else
					M.GetDrilled()
					log_message("Bored through [target]")
				if(locate(/obj/item/mecha_parts/mecha_equipment/tool/hydraulic_clamp) in chassis.equipment)
					var/obj/structure/ore_box/ore_box = locate(/obj/structure/ore_box) in chassis:cargo
					if(ore_box)
						for(var/obj/item/ore/ore in range(chassis,1))
							if(get_dir(chassis,ore)&chassis.dir)
								ore.forceMove(ore_box)
			else if(target.loc == C)
				log_message("Drilled through [target]")
				target.ex_act(2)
	return 1
