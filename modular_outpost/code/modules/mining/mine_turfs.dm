/turf/simulated/mineral/alt/ignore_cavegen
	ignore_cavegen = TRUE

/turf/simulated/mineral/alt/ignore_mapgen
	ignore_cavegen = TRUE

/turf/simulated/mineral/crystal/ignore_cavegen
	ignore_cavegen = TRUE

/turf/simulated/mineral/crystal/ignore_mapgen
	ignore_cavegen = TRUE

/turf/simulated/mineral/crystal_shiny/ignore_cavegen
	ignore_cavegen = TRUE

/turf/simulated/mineral/crystal_shiny/ignore_mapgen
	ignore_cavegen = TRUE


// Natural tunneler trait
/turf/simulated/mineral/attack_hand(mob/user)
	if(HAS_TRAIT(user, TRAIT_NATURALTUNNELER) && density)
		if(!istype(user.loc, /turf))
			return

		//prevents message spam
		if(last_act + /obj/item/pickaxe::digspeed > world.time)
			return
		last_act = world.time

		// Our claws are pretty gentle compared to a pick or drill
		playsound(user, "pickaxe", 15, 1)
		if(LAZYLEN(finds))
			wreckfinds(FALSE)
		user.balloon_alert(user, "you start digging.")

		// Mine or release artifacts in rubble
		if(do_after(user, 20 SECONDS, target = src))
			if(LAZYLEN(finds))
				var/datum/find/F = finds[1]
				excavate_find(prob(70), F)
			user.balloon_alert(user, "you finish digging \the [src].")
			excavate_turf()
		return
	. = ..()

/obj/item/strangerock/attack_hand(mob/living/user)
	if(HAS_TRAIT(user, TRAIT_NATURALTUNNELER))
		if(do_after(user, 2 SECONDS, target = src))
			var/obj/item/inside = locate() in src
			if(inside)
				inside.loc = get_turf(src)
				visible_message(span_info("\The [src] is dug away, revealing \the [inside]."))
			else
				visible_message(span_info("\The [src] is dug away into nothing."))
			qdel(src)
		return
	. = ..()

/obj/structure/boulder/attack_hand(mob/living/user)
	if(HAS_TRAIT(user, TRAIT_NATURALTUNNELER))
		if(do_after(user, 2 SECONDS, target = src))
			//success
			if(artifact_find)
				var/spawn_type = artifact_find.artifact_find_type
				var/obj/O = new spawn_type(get_turf(src))
				if(istype(O, /obj/machinery/artifact))
					var/obj/machinery/artifact/X = O
					if(X.artifact_master)
						X.artifact_master.artifact_id = artifact_find.artifact_id
				O.anchored = FALSE	// Anchored finds are lame.
				src.visible_message(span_warning("\The [src] suddenly crumbles away."))
			else
				user.visible_message(span_warning("\The [src] suddenly crumbles away."), span_notice("\The [src] has been whittled away under your careful digging, but there was nothing of interest inside."))
			qdel(src)
		return
	. = ..()
