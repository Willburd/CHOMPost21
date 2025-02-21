/obj/effect/mine/lasertag
	mineitemtype = /obj/item/mine/lasertag
	var/beam_types = list(/obj/item/projectile/bullet/pellet/fragment) // you fool, you baffoon, you used these, you absolute ignoramous, why did you not read this!
	var/spread_range = 3

/obj/effect/mine/lasertag/explode(var/mob/living/M)
	if(triggered) // Prevents circular mine explosions from two mines detonating eachother
		return
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread()
	triggered = 1
	s.set_up(3, 1, src)
	s.start()
	var/turf/O = get_turf(src)
	if(!O)
		return
	src.launch_many_projectiles(O, spread_range, beam_types)
	visible_message("\The [src.name] detonates!")
	spawn(0)
		qdel(s)
		qdel(src)

/obj/effect/mine/lasertag/red
	mineitemtype = /obj/item/mine/lasertag/red
	beam_types = list(/obj/item/projectile/beam/lasertag/red)

/obj/effect/mine/lasertag/blue
	mineitemtype = /obj/item/mine/lasertag/blue
	beam_types = list(/obj/item/projectile/beam/lasertag/blue)

/obj/effect/mine/lasertag/omni
	mineitemtype = /obj/item/mine/lasertag/omni
	beam_types = list(/obj/item/projectile/beam/lasertag/omni)

/obj/effect/mine/lasertag/all
	mineitemtype = /obj/item/mine/lasertag/all
	beam_types = list(/obj/item/projectile/beam/lasertag/red,/obj/item/projectile/beam/lasertag/blue,/obj/item/projectile/beam/lasertag/omni)




/obj/item/mine/lasertag
	name = "lasertag mine"
	desc = "A small mine with 'BOOM' written on top, and an optical hazard warning on the side."
	minetype = /obj/effect/mine/lasertag

/obj/item/mine/lasertag/red
	name = "red lasertag mine"
	desc = "A small red mine with 'BOOM' written on top, and an optical hazard warning on the side."
	minetype = /obj/effect/mine/lasertag/red

/obj/item/mine/lasertag/blue
	name = "blue lasertag mine"
	desc = "A small blue mine with 'BOOM' written on top, and an optical hazard warning on the side."
	minetype = /obj/effect/mine/lasertag/blue

/obj/item/mine/lasertag/omni
	name = "purple lasertag mine"
	desc = "A small purple mine with 'BOOM' written on top, and an optical hazard warning on the side."
	minetype = /obj/effect/mine/lasertag/omni

/obj/item/mine/lasertag/all
	name = "chaos lasertag mine"
	desc = "A small grey mine with 'BOOM' written on top, and an optical hazard warning on the side."
	minetype = /obj/effect/mine/lasertag/all




/obj/item/mine/spiders
	name = "spider mine"
	desc = "A small explosive mine with a spider symbol on the side."
	minetype = /obj/effect/mine/spiders

/obj/effect/mine/spiders
	mineitemtype = /obj/item/mine/spiders

/obj/effect/mine/spiders/explode(var/mob/living/M)
	if(triggered) // Prevents circular mine explosions from two mines detonating eachother
		return
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread()
	triggered = 1
	s.set_up(3, 1, src)
	s.start()
	var/i = rand(6,9)
	while(i-- > 0)
		new /obj/effect/spider/spiderling/non_growing(loc)
	if(prob(20))
		// danger
		i = rand(3,5)
		while(i-- > 0)
			new /obj/effect/spider/spiderling(loc)
	else
		// regulars
		i = rand(3,5)
		while(i-- > 0)
			new /obj/effect/spider/spiderling/varied(loc)
	visible_message("\The [src.name] detonates!")
	spawn(0)
		qdel(src)



/obj/item/mine/glue
	name = "glue mine"
	desc = "A small explosive mine with a sticky warning on the side."
	minetype = /obj/effect/mine/glue

/obj/effect/mine/glue
	mineitemtype = /obj/item/mine/glue

/obj/effect/mine/glue/explode(var/mob/living/M)
	if(triggered) // Prevents circular mine explosions from two mines detonating eachother
		return
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread()
	triggered = 1
	s.set_up(3, 1, src)
	s.start()
	for (var/turf/simulated/floor/target in range(1,src))
		if(target.density)
			continue
		if(target.blocks_air)
			continue
		if(istype(target, /turf/simulated/floor/water)) //Important to stop my_slime from filling with null entries in water.
			continue
		new /obj/effect/slug_glue(target)
	visible_message("\The [src.name] detonates!")
	spawn(0)
		qdel(src)




/obj/item/mine/portal
	name = "bluespace mine"
	desc = "A small explosive mine with a bluespace warning on the side."
	minetype = /obj/effect/mine/portal

/obj/effect/mine/portal
	mineitemtype = /obj/item/mine/portal

/obj/effect/mine/portal/explode(var/mob/living/M)
	if(triggered) // Prevents circular mine explosions from two mines detonating eachother
		return
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread()
	triggered = 1
	s.set_up(3, 1, src)
	s.start()
	// Terrible code stolen from event portals
	var/list/pick_turfs = list()
	var/list/Z_choices = list()
	var/turf/simulated/floor/enter = loc
	if( !enter || !istype(enter) )	return	//sanity
	Z_choices |= using_map.get_map_levels(1, FALSE)
	for(var/turf/simulated/floor/T in world)
		if(T.z in Z_choices)
			if(!T.block_tele)
				pick_turfs += T
	if(pick_turfs.len)
		var/wormhole_max_duration = round((2 MINUTES))
		var/wormhole_min_duration = round((30 SECONDS))
		var/turf/simulated/floor/exit = pick(pick_turfs)
		if( !exit || !istype(exit) )	return	//sanity
		//get our enter and exit locations
		if(prob(1))
			create_redspace_wormhole(enter,exit,FALSE,wormhole_min_duration,wormhole_max_duration)
		else
			create_wormhole(enter,exit,wormhole_min_duration,wormhole_max_duration)
	// Zoop
	visible_message("\The [src.name] detonates!")
	var/obj/effect/portal/P = locate(/obj/effect/portal) in loc.contents
	if(P)
		P.teleport(M)
	spawn(0)
		qdel(src)



/obj/item/mine/confetti
	name = "surprise mine"
	desc = "A small explosive mine with a birthday cake on the side."
	minetype = /obj/effect/mine/confetti

/obj/effect/mine/confetti
	mineitemtype = /obj/item/mine/confetti

/obj/effect/mine/confetti/explode(var/mob/living/M)
	if(triggered) // Prevents circular mine explosions from two mines detonating eachother
		return
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread()
	triggered = 1
	s.set_up(3, 1, src)
	s.start()
	// YAYYYYY
	playsound(src, 'sound/items/confetti.ogg', 75, 1)
	playsound(src, 'sound/effects/snap.ogg', 50, 1)
	new /obj/effect/decal/cleanable/confetti(loc)
	visible_message("\The [src.name] detonates!")
	spawn(0)
		qdel(src)



/obj/item/mine/taarainbow
	name = "surprise mine"
	desc = "A small explosive mine with a birthday cake on the side."
	minetype = /obj/effect/mine/taarainbow

/obj/effect/mine/taarainbow // same as above, but makes candy
	mineitemtype = /obj/item/mine/taarainbow

/obj/effect/mine/taarainbow/explode(var/mob/living/M)
	if(triggered) // Prevents circular mine explosions from two mines detonating eachother
		return
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread()
	triggered = 1
	s.set_up(3, 1, src)
	s.start()
	playsound(src, 'sound/items/confetti.ogg', 75, 1)
	playsound(src, 'sound/effects/snap.ogg', 50, 1)
	// candy
	var/count = rand(20,30)
	while(count-- > 0)
		var/picker = pick(/obj/item/clothing/mask/chewable/candy/gum,/obj/item/clothing/mask/chewable/candy/lolli,/obj/item/reagent_containers/food/snacks/candy/gummy,/obj/item/reagent_containers/food/snacks/candy_corn)
		var/obj/item/newcandy = new picker()
		newcandy.loc = src.loc
	// YAYYYYY
	new /obj/effect/decal/cleanable/confetti(loc)
	visible_message("\The [src.name] detonates!")
	spawn(0)
		qdel(src)



/obj/item/mine/lube
	name = "slip mine"
	desc = "A small explosive mine with a banana warning on the side."
	minetype = /obj/effect/mine/lube

/obj/effect/mine/lube
	mineitemtype = /obj/item/mine/lube

/obj/effect/mine/lube/explode(var/mob/living/M)
	if(triggered) // Prevents circular mine explosions from two mines detonating eachother
		return
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread()
	triggered = 1
	s.set_up(3, 1, src)
	s.start()
	for (var/turf/simulated/floor/target in range(3,src))
		if(target.density)
			continue
		if(target.blocks_air)
			continue
		if(istype(target, /turf/simulated/floor/water))
			continue
		target.wet_floor(2) // loob
	visible_message("\The [src.name] detonates!")
	spawn(0)
		qdel(src)
