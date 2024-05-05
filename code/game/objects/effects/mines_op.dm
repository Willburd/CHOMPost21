/obj/effect/mine/lasertag
	mineitemtype = /obj/item/weapon/mine/lasertag
	var/beam_types = list(/obj/item/projectile/bullet/pellet/fragment) // you fool, you baffoon, you used these, you absolute ignoramous, why did you not read this!
	var/spread_range = 3

/obj/effect/mine/lasertag/explode(var/mob/living/M)
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
	mineitemtype = /obj/item/weapon/mine/lasertag/red
	beam_types = list(/obj/item/projectile/beam/lasertag/red)

/obj/effect/mine/lasertag/blue
	mineitemtype = /obj/item/weapon/mine/lasertag/blue
	beam_types = list(/obj/item/projectile/beam/lasertag/blue)

/obj/effect/mine/lasertag/omni
	mineitemtype = /obj/item/weapon/mine/lasertag/omni
	beam_types = list(/obj/item/projectile/beam/lasertag/omni)

/obj/effect/mine/lasertag/all
	mineitemtype = /obj/item/weapon/mine/lasertag/all
	beam_types = list(/obj/item/projectile/beam/lasertag/red,/obj/item/projectile/beam/lasertag/blue,/obj/item/projectile/beam/lasertag/omni)




/obj/item/weapon/mine/lasertag
	name = "lasertag mine"
	desc = "A small mine with 'BOOM' written on top, and an optical hazard warning on the side."
	minetype = /obj/effect/mine/lasertag

/obj/item/weapon/mine/lasertag/red
	name = "red lasertag mine"
	desc = "A small red mine with 'BOOM' written on top, and an optical hazard warning on the side."
	minetype = /obj/effect/mine/lasertag/red

/obj/item/weapon/mine/lasertag/blue
	name = "blue lasertag mine"
	desc = "A small blue mine with 'BOOM' written on top, and an optical hazard warning on the side."
	minetype = /obj/effect/mine/lasertag/blue

/obj/item/weapon/mine/lasertag/omni
	name = "purple lasertag mine"
	desc = "A small purple mine with 'BOOM' written on top, and an optical hazard warning on the side."
	minetype = /obj/effect/mine/lasertag/omni

/obj/item/weapon/mine/lasertag/all
	name = "chaos lasertag mine"
	desc = "A small grey mine with 'BOOM' written on top, and an optical hazard warning on the side."
	minetype = /obj/effect/mine/lasertag/all
