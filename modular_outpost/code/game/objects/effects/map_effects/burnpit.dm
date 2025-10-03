/obj/effect/map_effect/interval/burnpit
	name = "burnpit"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	opacity = 0

	always_run = TRUE
	interval_lower_bound = 3 SECONDS
	interval_upper_bound = 8 SECONDS

	light_color = "#eccb0d"

/obj/effect/map_effect/interval/burnpit/Crossed(atom/movable/AM as mob|obj)
	// break and delete things that are destroyed in the pit!
	var/update_falling = FALSE

	var/obj/machinery/portable_atmospherics/canister/tank = AM
	if(istype(tank,/obj/machinery/portable_atmospherics/canister) && !tank.destroyed) // rupture tanks
		tank.take_damage(10000) // BANG
		update_falling = TRUE

	if(update_falling)
		update_space_above()

/obj/effect/map_effect/interval/burnpit/proc/update_space_above()
	// fall safety... this is dumb, forces things that need to fall to do so. Because we may have been held up by something before.
	var/turf/simulated/open/OT = locate( /turf/simulated/open, get_zstep(src, UP))
	if(OT)
		OT.update()

/obj/effect/map_effect/interval/burnpit/trigger()
	#ifndef UNIT_TESTS
	var/turf/simulated/T = loc
	if(T)
		if(T.fire_protection > world.time-30)
			qdel(src) // Clear burnpit for sanity
			return
		// never put this out, reset my own air tile to FORCE combustion, should be enough to boost the other tiles too
		var/datum/gas_mixture/air_contents = T.return_air()
		if(!air_contents)
			T.make_air()
			air_contents = T.return_air()
		if(!air_contents.check_combustability())
			if(prob(15))
				T.make_air()
				air_contents = T.return_air()

		// praise zorg
		T.create_fire( 2 ) // lingering fires ( was air_contents.calculate_firelevel() )

		if(T.contents.len)
			for(var/thing in T.contents)
				if(prob(20))
					// destroy things
					var/burnedthing = FALSE
					if(istype(thing,/obj/effect/decal/cleanable/ash))
						burnedthing = TRUE
					else if(isliving(thing))
						var/mob/living/L = thing
						if(L.stat == DEAD)
							burnedthing = TRUE
					else if(istype(thing,/obj/item))
						var/obj/item/I = thing
						if(!I.hidden_uplink)
							burnedthing = TRUE
					else if(istype(thing,/obj/structure/closet))
						burnedthing = TRUE

					if(burnedthing)
						if(istype(thing,/obj/effect/decal/cleanable/ash)) // ashes to nothing~
							var/obj/effect/decal/cleanable/ash/A = thing
							qdel(A)
						else if(isliving(thing))
							var/mob/living/L = thing
							for(var/obj/item/W in L)
								L.drop_from_inventory(W)
							new /obj/effect/decal/cleanable/ash(L.loc) // Turn it to ashes!
							L.visible_message( span_warning("[L] turned to ash in the heat of the incinerator!"))
							qdel(L)
						else if(istype(thing,/obj))
							var/obj/O = thing
							new /obj/effect/decal/cleanable/ash(O.loc) // Turn it to ashes!
							O.visible_message(span_warning("[O] turned to ash in the heat of the incinerator!"))
							qdel(O)

		// random updates to the space above
		update_space_above()
	#endif
