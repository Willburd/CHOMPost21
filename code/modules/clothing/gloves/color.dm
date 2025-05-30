

/obj/item/clothing/gloves/yellow
	desc = "These gloves will protect the wearer from electric shock."
	name = "insulated gloves"
	icon_state = "yellow"
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	drop_sound = 'sound/items/drop/rubber.ogg'
	pickup_sound = 'sound/items/pickup/rubber.ogg'

/* Outpost 21 edit - Follow legacy behavior
// CHOMPedit start: More gloves give cold/heat protection.
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE
// CHOMPedit end.
*/

/obj/item/clothing/gloves/fyellow                             //Cheap Chinese Crap
	desc = "These gloves are cheap copies of proper insulated gloves. No way this can end badly."
	name = "budget insulated gloves"
	icon_state = "yellow"
	siemens_coefficient = 1			//Set to a default of 1, gets overridden in initialize()
	permeability_coefficient = 0.05
	drop_sound = 'sound/items/drop/rubber.ogg'
	pickup_sound = 'sound/items/pickup/rubber.ogg'

/obj/item/clothing/gloves/fyellow/Initialize(mapload)
	. = ..()
	//Picks a value between 0 and 1.25, in 5% increments // VOREStation edit
	var/shock_pick = rand(0,15) // VOREStation Edit
	siemens_coefficient = shock_pick * 0.05

/obj/item/clothing/gloves/black
	desc = "These work gloves are thick and fire-resistant."
	name = "black gloves"
	icon_state = "black"
	permeability_coefficient = 0.05
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE

/obj/item/clothing/gloves/orange
	name = "orange gloves"
	desc = "A pair of gloves. They look heat-resistant." // CHOMPedit: Updated description for temp changes.
	icon_state = "orange"

/* Outpost 21 edit - Follow legacy behavior
// CHOMPedit start: More gloves give cold/heat protection.
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE
// CHOMPedit end.
*/

/obj/item/clothing/gloves/red
	name = "red gloves"
	desc = "A pair of gloves. They look heat-resistant." // CHOMPedit: Updated description for temp changes.
	icon_state = "red"

/* Outpost 21 edit - Follow legacy behavior
// CHOMPedit start: More gloves give cold/heat protection.
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE
// CHOMPedit end.
*/

/obj/item/clothing/gloves/rainbow
	name = "rainbow gloves"
	desc = "A pair of gloves. They look heat-resistant." // CHOMPedit: Updated description for temp changes.
	icon_state = "rainbow"

/* Outpost 21 edit - Follow legacy behavior
// CHOMPedit start: More gloves give cold/heat protection.
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE
// CHOMPedit end.
*/

/obj/item/clothing/gloves/blue
	name = "blue gloves"
	desc = "A pair of gloves. They look heat-resistant." // CHOMPedit: Updated description for temp changes.
	icon_state = "blue"

/* Outpost 21 edit - Follow legacy behavior
// CHOMPedit start: More gloves give cold/heat protection.
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE
// CHOMPedit end.
*/

/obj/item/clothing/gloves/purple
	name = "purple gloves"
	desc = "A pair of gloves. They look heat-resistant." // CHOMPedit: Updated description for temp changes.
	icon_state = "purple"

/* Outpost 21 edit - Follow legacy behavior
// CHOMPedit start: More gloves give cold/heat protection.
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE
// CHOMPedit end.
*/

/obj/item/clothing/gloves/green
	name = "green gloves"
	desc = "A pair of gloves. They look heat-resistant." // CHOMPedit: Updated description for temp changes.
	icon_state = "green"

/* Outpost 21 edit - Follow legacy behavior
// CHOMPedit start: More gloves give cold/heat protection.
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE
// CHOMPedit end.
*/

/obj/item/clothing/gloves/grey
	name = "grey gloves"
	desc = "A pair of gloves. They look heat-resistant." // CHOMPedit: Updated description for temp changes.
	icon_state = "gray"

/* Outpost 21 edit - Follow legacy behavior
// CHOMPedit start: More gloves give cold/heat protection.
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE
// CHOMPedit end.
*/

/obj/item/clothing/gloves/light_brown
	name = "light brown gloves"
	desc = "A pair of gloves. They look heat-resistant." // CHOMPedit: Updated description for temp changes.
	icon_state = "lightbrown"

/* Outpost 21 edit - Follow legacy behavior
// CHOMPedit start: More gloves give cold/heat protection.
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE
// CHOMPedit end.
*/

/obj/item/clothing/gloves/brown
	name = "brown gloves"
	desc = "A pair of gloves. They look heat-resistant." // CHOMPedit: Updated description for temp changes.
	icon_state = "brown"

/* Outpost 21 edit - Follow legacy behavior
// CHOMPedit start: More gloves give cold/heat protection.
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE
// CHOMPedit end.
*/

/obj/item/clothing/gloves/evening
	desc = "A pair of gloves that reach past the elbow.  Fancy!"
	name = "evening gloves"
	icon_state = "evening_gloves"
	addblends = "evening_gloves_a"
	heat_protection = ARMS|HANDS
	cold_protection = ARMS|HANDS

/obj/item/clothing/gloves/fingerless
	desc = "A pair of gloves that don't actually cover the fingers."
	name = "fingerless gloves"
	icon_state = "fingerlessgloves"
	fingerprint_chance = 100

/obj/item/clothing/gloves/fingerless/alt
	icon_state = "fingerlessgloves_alt"

/obj/item/clothing/gloves/fingerless_recolourable
	desc = "A pair of gloves that don't actually cover the fingers."
	name = "fingerless gloves"
	icon_state = "fingerlessgloves_rc"
	fingerprint_chance = 100

/obj/item/clothing/gloves/fingerless_recolourable/alt
	icon_state = "fingerlessgloves_rc_alt"
