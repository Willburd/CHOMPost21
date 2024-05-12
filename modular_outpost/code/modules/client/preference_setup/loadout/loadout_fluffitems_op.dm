// Note for newly added fluff items: Ckeys should not contain any spaces, underscores or capitalizations,
// or else the item will not be usable.
// Example: Someone whose username is "Master Pred_Man" should be written as "masterpredman" instead
// Note: Do not use characters such as # in the display_name. It will cause the item to be unable to be selected.

/datum/gear/fluff
	path = /obj/item
	sort_category = "Fluff Items"
	display_name = "If this item can be chosen or seen, ping a coder immediately!"
	ckeywhitelist = list("This entry should never be choosable with this variable set.") //If it does, then that means somebody fucked up the whitelist system pretty hard
	character_name = list("This entry should never be choosable with this variable set.")
	cost = 0

/*
/datum/gear/fluff/testhorn
	path = /obj/item/weapon/bikehorn
	display_name = "Airhorn - Example Item" //Don't use the same as another item
	description = "An example item that you probably shouldn't see!"
	ckeywhitelist = list("broman2000")
	allowed_roles = list("Engineer")   //Don't include this if the item is not role restricted
	character_name = list("shitfacemcgee")  //Character name. this variable is required, or the item doesn't show in loadout. Change to "character_name = null" if not character restricted.
*/

/datum/gear/fluff/collar //Use this as a base path for collars if you'd like to set tags in loadout. Make sure you don't use apostrophes in the display name or this breaks!
	slot = slot_tie

/datum/gear/fluff/collar/New()
	..()
	gear_tweaks += gear_tweak_collar_tag

// global fluff medals
/datum/gear/fluff/ESHUI_surveypatch
	display_name = "ESHUI Survey Corps Patch"
	path = /obj/item/clothing/accessory/solgov/ec_patch/eshui
	ckeywhitelist = list("buckwildwolf","darklord92","drakefrostpaw","jademanique","nadyr","remthebold","seagha","wdf71","synxplushy")
	character_name = null

/datum/gear/fluff/ESHUI_medalval
	display_name = "ESHUI Medal of Valor"
	path = /obj/item/clothing/accessory/medal/solgov/silver/sol/eshui
	ckeywhitelist = list("darklord92","remthebold")
	character_name = list("Tesum Shari","Trashfire")

/datum/gear/fluff/ESHUI_ironstar
	display_name = "ESHUI Station Expeditionary Medal"
	path = /obj/item/clothing/accessory/medal/solgov/iron/star/eshui
	ckeywhitelist = list("drakefrostpaw","nadyr","Ozydev","remthebold","synxplushy","wdf71")
	character_name = list("Drake Frostpaw","Taaa","Ecise Nei","Papin Vandalia","Me Eep","Mitz")

/datum/gear/fluff/ESHUI_flightpin
	display_name = "ESHUI Pilot's Qualification Pin"
	path = /obj/item/clothing/accessory/solgov/specialty/pilot
	ckeywhitelist = list("remthebold","seagha","synxplushy","darklord92")
	character_name = list("Trashfire","Schale Vam","Khrutch Yizhnera","Aiektaaknell","Fynli","Drake Frostpaw","Sitka Niteshade","Tretch Qet")

/datum/gear/fluff/ESHUI_rankpin
	display_name = "ESHUI Officer's Qualification Pin"
	path = /obj/item/clothing/accessory/solgov/specialty/officer/eshui
	ckeywhitelist = list("remthebold","seagha")
	character_name = list("Trashfire","Schale Vam","Aiektaaknell","Khrutch Yizhnera","Qrill", "Janik Vam")

/datum/gear/fluff/ESHUI_whiteheart
	display_name = "ESHUI Medical Medal"
	path = /obj/item/clothing/accessory/medal/solgov/heart/eshui
	ckeywhitelist = list("seagha")
	character_name = list("Schale Vam")

/datum/gear/fluff/ESHUI_goldhonor //Awarded for being the first to retrive it from the dragon's lair
	display_name = "ESHUI Half-Melted Medal of Heroism"
	path = /obj/item/clothing/accessory/medal/gold/heroism
	description = "An extremely rare golden medal awarded only by high ranking officials. To receive such a medal is the highest honor and as such, very few exist... this one looks charred and half melted."
	ckeywhitelist = list("nadyr")
	character_name = list("Taaa")

//  0-9 CKEYS

//  A CKEYS

//  B CKEYS

//  C CKEYS

//  D CKEYS

//  E CKEYS

//  F CKEYS

//  G CKEYS

//  H CKEYS

//  I CKEYS

//  J CKEYS

//  K CKEYS

//  L CKEYS

//  M CKEYS

//  N CKEYS

//  O CKEYS

//  P CKEYS

//  Q CKEYS

//  R CKEYS

//  S CKEYS

/datum/gear/fluff/eshui_ds_hat
	display_name = "Army Campaign Cover"
	path = /obj/item/clothing/head/service/army/campaign
	description = "An intimidating hat bearing the crest of the USDF Army Crest. Typically only found on the heads of Drill Sergeants."
	ckeywhitelist = list("seagha")
	character_name = list("Khrutch Yizhnera")

//  T CKEYS

//  U CKEYS

//  V CKEYS

//  W CKEYS

//  X CKEYS

//  Y CKEYS

//  Z CKEYS
