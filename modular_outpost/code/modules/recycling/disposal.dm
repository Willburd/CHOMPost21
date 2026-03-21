/obj/structure/disposalholder
	count = 3072 //*** can travel 3072 steps before going inactive (in case of loops)

/obj/machinery/disposal/proc/malfunction()
	mode = 3
	flush = 1
	update_icon()
	visible_message(span_warning("\The [src] sparks violently!"))
	var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
	sparks.set_up(4, 1, get_turf(src))
	sparks.start()
