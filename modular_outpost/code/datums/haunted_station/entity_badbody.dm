/datum/haunting_entity/bad_body
	name = "ENTITY - bad body"

/datum/haunting_entity/bad_body/New()
	. = ..()

	// Just call the event
	var/datum/event/badbody/forced/B = new(external_use = TRUE)
	B.setup()
	qdel(B)

/datum/haunting_entity/bad_body/process()
	qdel(src) // End instantly
