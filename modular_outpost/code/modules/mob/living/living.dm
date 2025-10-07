/mob/living/Initialize(mapload)
	. = ..()

	if(!mapload)
		return

	// don't care about sizes, this will be funny when a jillioth is in a closet at map load
	var/obj/structure/closet/C = locate( /obj/structure/closet, loc)
	if(C && !C.opened)
		src.forceMove(C)

/mob/living/proc/slam_grabbed_mob_against_thing(var/obj/item/grab/G)
	// null checking for my own sanity, only aggressive grabs headsmash
	var/mob/living/throw_mob = G.throw_held()
	if(throw_mob && a_intent == I_HURT && G.state >= GRAB_NECK)
		// if not selecting the head, treat it like a body throw into the wall instead! otherwise a headslam
		var/hit_zone = zone_sel.selecting
		if(zone_sel.selecting != BP_HEAD)
			zone_sel.selecting = BP_TORSO

		// check if not on same turf (nearby check!)
		if(loc != throw_mob.loc)
			to_chat(src, span_danger("Couldn't slam [throw_mob] into the wall! They are too far away!"))
			return -1

		// check if head is gone... otherwise torso should always exist? Would check anyway...
		var/obj/item/organ/external/affecting = throw_mob.get_organ(hit_zone)
		if(!affecting || affecting.is_stump())
			to_chat(src, span_danger("Couldn't slam [throw_mob] into the wall! They are missing the limb targeted!"))
			return -1

		// BAM
		var/rand_damage = rand(3, 8)
		var/datum/unarmed_attack/attack = new /datum/unarmed_attack // just a default attack...
		var/real_damage = rand_damage
		var/hit_dam_type = attack.damage_type
		real_damage += attack.get_unarmed_damage(src)
		if(ishuman(src))
			var/mob/living/carbon/human/H = src
			real_damage *= H.damage_multiplier
			rand_damage *= H.damage_multiplier
		if(HULK in mutations)
			real_damage *= 2 // Hulks do twice the damage
			rand_damage *= 2
		real_damage = max(1, real_damage)

		var/armour = throw_mob.run_armor_check(hit_zone, "melee")
		var/soaked = throw_mob.get_armor_soak(hit_zone, "melee")

		attack.apply_effects(src, throw_mob, armour, rand_damage, hit_zone)
		throw_mob.apply_damage(real_damage, hit_dam_type, hit_zone, armour, soaked)

		// sound and logging
		playsound(src, attack.attack_sound, 25, 1, -1)
		add_attack_logs(src,throw_mob,"Melee attacked with wall smash (miss/block)")
		qdel(attack) // cleanup
		return real_damage

	// failed
	return -1
