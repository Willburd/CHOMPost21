/obj/structure/prop/rock/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/climbable)

/obj/structure/prop/rock/CanPass(atom/movable/mover, turf/target)
	return mover.z > z // Allow falling from above
