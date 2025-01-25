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
	path = /obj/item/bikehorn
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

/datum/gear/fluff/ESHUI_bronzemedal
	display_name = "ESHUI Meritorious Defense Medal"
	path = /obj/item/clothing/accessory/medal/solgov/bronze/sol/eshui
	ckeywhitelist = list("drakefrostpaw","nadyr","ozydev","remthebold","synxplushy","wdf71","cadeTiger","niilomarvy","lowpowermia")
	character_name = list("Drake Frostpaw","Taaa","Ecise Nei","Papin Vandalia","Me Eep","Mitz","Feldam","Svatti","Nikita")

/datum/gear/fluff/ESHUI_medalval
	display_name = "ESHUI Medal of Valor"
	path = /obj/item/clothing/accessory/medal/solgov/silver/sol/eshui
	ckeywhitelist = list("darklord92","remthebold","ozydev","astraether")
	character_name = list("Tesum Shari","Trashfire","Cracker","Astra Ether")

/datum/gear/fluff/ESHUI_medaldefop
	display_name = "ESHUI Defensive Operations Medal"
	path = /obj/item/clothing/accessory/medal/solgov/iron/star/eshui
	ckeywhitelist = list("jollytjerry11","synxplushy","darklord92","niilomarvy")
	character_name = list("Ed'Reith Foley","Zeeshi","Vi'Akit","Ral'Hathamee")

/datum/gear/fluff/ESHUI_medalcomb
	display_name = "ESHUI Combat Action Medal"
	path = /obj/item/clothing/accessory/medal/solgov/silver/sword/eshui
	ckeywhitelist = list("ozydev","synxplushy","remthebold","cameron653")
	character_name = list("Raine Rattlewag","Cracker","Zeeshi","Trashfire","Diana Kuznetsova")

/datum/gear/fluff/ESHUI_rankpin
	display_name = "ESHUI Officer's Qualification Pin"
	path = /obj/item/clothing/accessory/solgov/specialty/officer/eshui
	ckeywhitelist = list("remthebold","seagha","nadyr","ozydev")
	character_name = list("Schale","Aiektaaknell","Janik Vam","Zeeshi","Ed'Reith Foley", "Taaa","Cracker")

/datum/gear/fluff/ESHUI_commanderpin //A good goal for an antag to steal
	display_name = "ESHUI Captaincy Medal"
	path = /obj/item/clothing/accessory/medal/gold/captain/eshui
	ckeywhitelist = list("seagha","remthebold")
	character_name = list("Khrutch Yizhnera","Trashfire")

/datum/gear/fluff/ESHUI_whiteheart
	display_name = "ESHUI Medical Action Award"
	path = /obj/item/clothing/accessory/medal/solgov/heart/eshui
	ckeywhitelist = list("seagha","darklord92","lumithefox")
	character_name = list("Schale","Qdel","Nach Uligo")

/datum/gear/fluff/ESHUI_servemed
	display_name = "ESHUI Service Medal"
	path = /obj/item/clothing/accessory/medal/solgov/gold/sun/eshui
	ckeywhitelist = list("seagha")
	character_name = list("Aiektaaknell")

/datum/gear/fluff/ESHUI_goldhonormelt //Awarded for being the first to retrive it from the dragon's lair
	display_name = "ESHUI Half-Melted Medal of Heroism"
	path = /obj/item/clothing/accessory/medal/gold/heroismmelted/eshui
	description = "An extremely rare golden medal awarded only by high ranking officials. To receive such a medal is the highest honor and as such, very few exist... this one looks charred and half melted."
	ckeywhitelist = list("nadyr","remthebold")
	character_name = list("Taaa","Trashfire")

//  0-9 CKEYS

//  A CKEYS

// astra: Astra
/datum/gear/fluff/astra_ritualknife
	path = /obj/item/material/knife/ritual/fluff/astra
	display_name = "Polished Ritual Knife"
	description = "A well kept strange ritual knife, There is a small tag with the name 'Astra Ether' on it. They are probably looking for this."
	ckeywhitelist = list("astraether")
	character_name = list("Astra Ether")

/datum/gear/fluff/astra_jobledger
	path = /obj/item/book/ledger/astra
	display_name = "Job Ledger"
	description = "A small book keeping track of jobs performed for the station."
	ckeywhitelist = list("astraether")
	character_name = list("Astra Ether")

//  B CKEYS

//  C CKEYS

//Cameron653: Diana Kuznetsova
/datum/gear/fluff/diana_robe
	path = /obj/item/clothing/suit/fluff/purp_robes
	display_name = "Diana's Robes"
	slot = slot_wear_suit
	ckeywhitelist = list("cameron653")
	character_name = list("Diana Kuznetsova")

/datum/gear/fluff/diana_tiara
	path = /obj/item/clothing/head/fluff/pink_tiara
	display_name = "Diana's Tiara"
	slot = slot_head
	ckeywhitelist = list("cameron653")
	character_name = list("Diana Kuznetsova")

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

//niilomarvy: Tobin
/datum/gear/fluff/tobin_morphcoin
	display_name = "Morphium Coin"
	path = /obj/item/coin/morphium
	description = "A small coin made out of some kind of exotic metal."
	ckeywhitelist = list("niilomarvy")
	character_name = list("Tobin")

//  O CKEYS

//  P CKEYS

//  Q CKEYS

//  R CKEYS
/datum/gear/fluff/trashfire_coffee
	display_name = "Trashfire's Coffee Mug"
	path = /obj/item/reagent_containers/food/drinks/bluespace_coffee
	description = "Dreamt up in a strange feverish dream, this coffee cup seems to have been heavily modified with a variety of unlikely parts and wires, and never seems to run out of coffee. Truly the differance between madmen and genius is success."
	ckeywhitelist = list("remthebold")
	character_name = list("Trashfire")

//  S CKEYS

//seagha: Khrutch Yizhnera
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
