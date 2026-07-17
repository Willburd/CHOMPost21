/obj/machinery/mecha_part_fabricator_tg/prosthetics/Initialize(mapload)
	species_types = GLOB.playable_species.Copy() // We want to skip species design disks
	. = ..()
