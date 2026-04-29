/datum/gear/accessory/internal_confinement_medal
	display_name = "internal confinement medal selection"
	path = /obj/item/clothing/accessory/medal/internal_confinement_medal
	cost = 0

/datum/gear/accessory/internal_confinement_medal/New()
	..()
	var/list/medals = list()
	for(var/obj/item/clothing/accessory/medal/internal_confinement_medal/medal_type as anything in typesof(/obj/item/clothing/accessory/medal/internal_confinement_medal))
		medals[initial(medal_type.name)] = medal_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(medals))
