/datum/experiment/scanning/points/engineered_organ
	name = "Engineered Organ Analysis"
	description = "Scan an chemical producing organ grown from an organ lattice."
	required_points = 1

/datum/experiment/scanning/points/engineered_organ/New(datum/techweb/techweb)
	. = ..()
	for(var/path in subtypesof(/obj/item/organ/internal/malignant/engineered/chemorgan))
		required_atoms[path] = 1
