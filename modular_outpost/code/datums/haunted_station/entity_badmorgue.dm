/datum/haunting_entity/bad_body_morgue
	name = "ENTITY - bad body morgue"

/datum/haunting_entity/bad_body_morgue/New()
	. = ..()

	// Just call the event
	var/datum/event/badbody/morgue/forced/B = new(external_use = TRUE)
	B.setup()
	qdel(B)

/datum/haunting_entity/bad_body_morgue/process()
	qdel(src) // End instantly
