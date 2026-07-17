/datum/haunting_entity/angel_statue
	name = "ENTITY - Angel statue"

/datum/haunting_entity/angel_statue/New()
	. = ..()

	// Just call the event
	var/datum/event/weeping_statue/W = new(external_use = TRUE)
	W.start()
	qdel(W)

/datum/haunting_entity/angel_statue/process()
	qdel(src) // End instantly
