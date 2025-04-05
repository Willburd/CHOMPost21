var/global/list/outpost_rocket_pods = list()

/obj/structure/prop/war/tgmc_missile_rack/Initialize(mapload)
	. = ..()
	global.outpost_rocket_pods += src

/obj/structure/prop/war/tgmc_missile_rack/Destroy()
	global.outpost_rocket_pods -= src
	. = ..()

/obj/structure/prop/war/tgmc_missile_rack/proc/fire_rocket()
	visible_message("\The [src] fires!")
	playsound(src, 'sound/effects/smoke.ogg', 30, 1, -3)
	playsound(src, 'sound/effects/droppod.ogg', 50, 1, -3)
	playsound(src, 'sound/magic/Fireball.ogg', 76, 1)
	change_state("empty")

	var/datum/effect/effect/system/smoke_spread/smoke = new /datum/effect/effect/system/smoke_spread()
	smoke.attach(src)
	smoke.set_up(4, 0, loc)
	smoke.start()

	var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
	sparks.attach(src)
	sparks.set_up(3, 0, loc)
	sparks.start()

	global.outpost_rocket_pods -= src // Used up!
