/obj/structure/prop/rock/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/climbable)

/obj/structure/prop/rock/CanPass(atom/movable/mover, turf/target)
	return !density || (mover.z > z) // Allow falling from above

/obj/structure/prop/rock/small/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/climbable) // don't climb these ones
