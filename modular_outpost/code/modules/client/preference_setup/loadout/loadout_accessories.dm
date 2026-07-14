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

/datum/gear/accessory/officer_qualification_pin
	display_name = "ESHUI Officer's Qualification Pin"
	path = /obj/item/clothing/accessory/solgov/specialty/officer/eshui
	cost = 0

/datum/gear/accessory/dog_tag
	display_name = "Dogtag selection"
	path = /obj/item/accessory/dtag
	cost = 0

/datum/gear/accessory/dog_tag/New()
	..()
	var/list/tags = list()
	for(var/obj/item/accessory/dtag/tag_type as anything in typesof(/obj/item/accessory/dtag))
		tags[initial(tag_type.name)] = tag_type
	gear_tweaks += new/datum/gear_tweak/path(sortAssoc(tags))
