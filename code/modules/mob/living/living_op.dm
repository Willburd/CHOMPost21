/mob/living/proc/handle_dripping()
	if(prob(95))
		return
	if(!isturf(src.loc))
		return
	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		if(H.species && H.species.drippy)
			// drip body color if human
			var/obj/effect/decal/cleanable/blood/B
			var/decal_type = /obj/effect/decal/cleanable/blood/splatter
			var/turf/T = get_turf(src.loc)

			// Are we dripping or splattering?
			var/list/drips = list()
			// Only a certain number of drips (or one large splatter) can be on a given turf.
			for(var/obj/effect/decal/cleanable/blood/drip/drop in T)
				drips |= drop.drips
				qdel(drop)
			if(drips.len < 6)
				decal_type = /obj/effect/decal/cleanable/blood/drip

			// Find a blood decal or create a new one.
			B = locate(decal_type) in T
			if(!B)
				B = new decal_type(T)

			var/obj/effect/decal/cleanable/blood/drip/drop = B
			if(istype(drop) && drips && drips.len)
				drop.add_overlay(drips)
				drop.drips |= drips

			// Update appearance.
			B.customname = "drips of something"
			B.customdesc = "It's thick and gooey. Perhaps it's the chef's cooking?"
			B.dryname = "dried something"
			B.drydesc = "It's dry and crusty. The janitor isn't doing their job."
			B.basecolor = rgb(H.r_skin,H.g_skin,H.b_skin)
			B.update_icon()
			B.fluorescent  = 0
			B.invisibility = 0
	//else
		// come up with drips for other mobs someday

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
