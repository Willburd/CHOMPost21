/obj/structure/prop/rock/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/climbable)

/obj/structure/prop/rock/CanPass(atom/movable/mover, turf/target)
	if(mover.z > z) // Allow falling from above
		return TRUE
	. = ..()

/obj/structure/prop/rock/small/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/climbable) // don't climb these ones
