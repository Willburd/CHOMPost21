/obj/item/slime_extract

/obj/item/slime_extract/Initialize(mapload)
	. = ..()
	// Forbids wiki-info tier descriptions on slimes, use the slime scanner to get this info.
	description_info = null
