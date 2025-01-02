// A weaker, slower, version of spacevines
/proc/spacemoss_infestation(var/potency_min=10, var/potency_max=40, var/maturation_min=50, var/maturation_max=150)
	spawn() //to stop the secrets panel hanging
		var/turf/simulated/floor/T = pick(vinestart)
		if(T)
			var/datum/seed/seed = SSplants.create_random_seed(1)
			seed.set_trait(TRAIT_SPREAD,2)             // So it will function properly as vines.
			seed.set_trait(TRAIT_POTENCY,rand(potency_min, potency_max)) // 10 - 40 potency will keep things a bit slower
			seed.set_trait(TRAIT_MATURATION,rand(maturation_min, maturation_max))
			seed.set_trait(TRAIT_ENDURANCE,rand(5, 20)) // weak
			seed.set_trait(TRAIT_STINGS,0) // nah
			seed.set_trait(TRAIT_EXPLOSIVE,0) // nope
			seed.set_trait(TRAIT_TELEPORTING,0) // nada
			if(seed.get_trait(TRAIT_CARNIVOROUS) >= 2)
				seed.set_trait(TRAIT_CARNIVOROUS,1)
			// always fruiting, botany will love this
			seed.set_trait(TRAIT_HARVEST_REPEAT,1)
			if(prob(15))
				seed.set_trait(TRAIT_JUICY,2)
			else if(prob(50))
				seed.set_trait(TRAIT_JUICY,1)
			else
				seed.set_trait(TRAIT_JUICY,0)
			seed.display_name = "strange plants"

			//make vine zero start off fully matured
			var/obj/effect/plant/vine = new(T,seed)
			vine.health = vine.max_health
			vine.mature_time = 0
			vine.process()

			message_admins(span_notice("Event: Spacemoss spawned at [T.loc] ([T.x],[T.y],[T.z])"))
			return
		message_admins(span_notice("Event: Spacemoss failed to find a viable turf."))
