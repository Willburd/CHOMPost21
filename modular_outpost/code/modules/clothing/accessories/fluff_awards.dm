/*****
medals - Ordered by importance
*****/

/obj/item/clothing/accessory/medal/solgov/bronze/sol/eshui
	name = "\improper Meritorious Defense Medal"
	desc = "A bronze medallion awarded to crew members by Command Staff for meritorious achievement or service to the station. While the lowest medal one can achieve, it is still a notable achievement."

/obj/item/clothing/accessory/medal/solgov/bronze/heart/eshui
	name = "\improper Bronze Heart Medal"
	desc = "A bronze heart awarded to crew members by Command Staff for permanent injury or death in the line of duty, sadly resleeving tech has made this nearly impossible to get.."

/obj/item/clothing/accessory/medal/solgov/iron/star/eshui
	name = "\improper Defensive Operations Medal"
	desc = "An iron star awarded to crew members by Heads of Staff for exemplary service in defense of the station and crew."
	icon = 'modular_outpost/icons/inventory/accessory/fluff_awards.dmi'
	icon_state = "iron_star"

/obj/item/clothing/accessory/medal/solgov/silver/sword/eshui
	name = "\improper Combat Action Medal"
	desc = "A silver medal awarded by the Station Commander to crew members for honorable service while under enemy fire. Normally only seen on security forces, it typically means one is notably robust."

/obj/item/clothing/accessory/medal/solgov/silver/sol/eshui
	name = "\improper Medal of Valor"
	icon = 'modular_outpost/icons/inventory/accessory/fluff_awards.dmi'
	desc = "A silver medal awarded by the Station Commander for crew members for acts of exceptional valor."

/obj/item/clothing/accessory/medal/solgov/heart/eshui
	name = "\improper Medical Action Award"
	icon = 'modular_outpost/icons/inventory/accessory/fluff_awards.dmi'
	desc = "A white heart emblazoned with a red cross awarded to crew members for service as a medical professional in a combat zone."
	icon_state = "white_heart"

/obj/item/clothing/accessory/medal/solgov/gold/sun/eshui
	name = "\improper ESHUI Service Medal"
	desc = "A gold medal awarded to crew members by Central Command for significant contributions to the station, and its crew."

/obj/item/clothing/accessory/medal/solgov/gold/crest/eshui
	name = "\improper ESHUI Medal of Honor"
	desc = "A gold medal awarded to crew members by Central Command for personal acts of valor above and beyond the call of duty."

/obj/item/clothing/accessory/medal/solgov/gold/star/eshui
	name = "\improper ESHUI Medal of Heroism"
	desc = "A gold star awarded to crew members by Central Command for acts of incredible heroism in a combat situation."

/obj/item/clothing/accessory/medal/gold/heroism/eshui
	name = "\improper ESHUI Medal of Exceptional Heroism"
	desc = "An extremely rare golden medal awarded only by high ranking officials. To receive such a medal is the highest honor and as such, very few exist. This medal is almost never awarded to anybody but distinguished veteran staff."

/obj/item/clothing/accessory/medal/solgov/gold/sol/eshui
	name = "\improper ESHUI Sol Sapientarian medal"
	desc = "A gold medal awarded by Central Command to crew members for significant contributions to sapient rights."

/obj/item/clothing/accessory/medal/gold/captain/eshui
	name = "\improper ESHUI Captaincy Medal"
	desc = "A golden medal awarded exclusively to those promoted to the rank of captain. It signifies the codified responsibilities of a captain, and their undisputable authority over their crew."

/*****
Specialty/event medals
*****/

/obj/item/clothing/accessory/medal/gold/heroismmelted/eshui //Awarded for besting the dragon.
	name = "damaged medal of exceptional heroism"
	desc = "An extremely rare golden medal awarded only by high ranking officials. To receive such a medal is the highest honor and as such, very few exist... this one looks charred and half melted."

/*****
patches
*****/
/obj/item/clothing/accessory/solgov/ec_patch/eshui
	name = "\improper Survey Corps patch"
	icon = 'modular_outpost/icons/inventory/accessory/fluff_awards.dmi'
	desc = "A laminated shoulder patch, depicting a spyglass amongst stars, awarded by E-Shui to those who founded stations and planets, or discovered new ones."
	icon_state = "ecpatch1"
	on_rolled = list("down" = "none")
	slot = ACCESSORY_SLOT_INSIGNIA

/******
ribbons
******/

/*************
specialty pins
*************/
/obj/item/clothing/accessory/solgov/specialty/officer/eshui
	name = "officer's qualification pin"
	icon = 'modular_outpost/icons/inventory/accessory/fluff_awards.dmi'
	desc = "A golden pin denoting high level leadership positions, and authority on the station."
	icon_state = "fleetpin_officer"

/*****
badges
*****/
/obj/item/clothing/accessory/badge/solgov/tags/eshui
	name = "dog tags"
	desc = "Plain identification tags made from a durable metal. They are stamped with a variety of informational details."
	badge_string = "E-Shui Central Command"
	slot_flags = SLOT_MASK | SLOT_TIE

/obj/item/clothing/accessory/badge/solgov/tags/eshui/Initialize()
	. = ..()
	var/mob/living/carbon/human/H
	H = get_holder_of_type(src, /mob/living/carbon/human)
	if(H)
		set_name(H.real_name)
		set_desc(H)

/obj/item/clothing/accessory/badge/solgov/tags/eshui/set_desc(var/mob/living/carbon/human/H)
	if(!istype(H))
		return
	var/religion = "Unset"
	desc = "[initial(desc)]\nName: [H.real_name] ([H.get_species()])\nReligion: [religion]\nBlood type: [H.b_type]"

/obj/item/clothing/accessory/badge/solgov/representative/eshui
	name = "representative's badge"
	desc = "A leather-backed plastic badge with a variety of information printed on it. Belongs to a representative of E-Shui Central Command."
	badge_string = "E-Shui Central Command"