/obj/structure/closet/athletic_mixed
	name = "athletic wardrobe"
	desc = "It's a storage unit for athletic wear."
	closet_appearance = /decl/closet_appearance/wardrobe/mixed

	starts_with = list(
		/obj/item/clothing/under/shorts/grey,
		/obj/item/clothing/under/shorts/black,
		/obj/item/clothing/under/shorts/red,
		/obj/item/clothing/under/shorts/blue,
		/obj/item/clothing/under/shorts/green,
		/obj/item/clothing/under/shorts/white,
		/obj/item/clothing/suit/storage/toggle/track,
		/obj/item/clothing/suit/storage/toggle/track/blue,
		/obj/item/clothing/suit/storage/toggle/track/green,
		/obj/item/clothing/suit/storage/toggle/track/red,
		/obj/item/clothing/suit/storage/toggle/track/white,
		/obj/item/clothing/under/pants/track,
		/obj/item/clothing/under/pants/track/blue,
		/obj/item/clothing/under/pants/track/green,
		/obj/item/clothing/under/pants/track/white,
		/obj/item/clothing/under/pants/track/red,
		/obj/item/clothing/shoes/athletic = 2,
		/obj/item/clothing/shoes/hitops,
		/obj/item/clothing/shoes/hitops/red,
		/obj/item/clothing/shoes/hitops/black,
		/obj/item/clothing/shoes/hitops/blue
		)

/obj/structure/closet/athletic_swimwear
	name = "athletic wardrobe"
	desc = "It's a storage unit for swimwear."
	closet_appearance = /decl/closet_appearance/wardrobe/mixed

	starts_with = list(
		/obj/item/clothing/under/shorts/grey,
		/obj/item/clothing/under/shorts/black,
		/obj/item/clothing/under/shorts/red,
		/obj/item/clothing/under/shorts/blue,
		/obj/item/clothing/under/shorts/green,
		/obj/item/clothing/under/swimsuit/red,
		/obj/item/clothing/under/swimsuit/black,
		/obj/item/clothing/under/swimsuit/blue,
		/obj/item/clothing/under/swimsuit/green,
		/obj/item/clothing/under/swimsuit/purple,
		/obj/item/clothing/under/swimsuit/striped,
		/obj/item/clothing/under/swimsuit/white,
		/obj/item/clothing/under/swimsuit/earth,
		/obj/item/clothing/mask/snorkel = 2,
		/obj/item/clothing/shoes/swimmingfins = 2)

/obj/structure/closet/boxinggloves
	name = "boxing gloves"
	desc = "It's a storage unit for gloves for use in the boxing ring."
	closet_appearance = /decl/closet_appearance/wardrobe/mixed

	starts_with = list(
		/obj/item/clothing/gloves/boxing/blue,
		/obj/item/clothing/gloves/boxing/green,
		/obj/item/clothing/gloves/boxing/yellow,
		/obj/item/clothing/gloves/boxing)

/obj/structure/closet/masks
	name = "mask closet"
	desc = "IT'S A STORAGE UNIT FOR FIGHTER MASKS OLE!"
	closet_appearance = /decl/closet_appearance/wardrobe/mixed

	starts_with = list(
		/obj/item/clothing/mask/luchador,
		/obj/item/clothing/mask/luchador/rudos,
		/obj/item/clothing/mask/luchador/tecnicos)


/obj/structure/closet/lasertag/red
	name = "red laser tag equipment"
	desc = "It's a storage unit for laser tag equipment."
	closet_appearance = /decl/closet_appearance/wardrobe/red

	starts_with = list(
		/obj/item/gun/energy/lasertag/red = 4,
		/obj/item/lasertagknife/red = 4,
		/obj/item/clothing/suit/redtag = 4,
		/obj/item/clothing/head/helmet/lasertag = 4) // Outpost 21 edit - new lasertag kits


/obj/structure/closet/lasertag/blue
	name = "blue laser tag equipment"
	desc = "It's a storage unit for laser tag equipment."
	closet_appearance = /decl/closet_appearance/wardrobe/blue

	starts_with = list(
		/obj/item/gun/energy/lasertag/blue = 4,
		/obj/item/lasertagknife/blue = 4,
		/obj/item/clothing/suit/bluetag = 4,
		/obj/item/clothing/head/helmet/lasertag = 4) // Outpost 21 edit - new lasertag kits

/obj/structure/closet/lasertag/red/laserdome
	name = "red team laserdome equipment"
	desc = "It's a storage unit for laser tag equipment."
	closet_appearance = /decl/closet_appearance/wardrobe/red

	starts_with = list(
		/obj/item/encryptionkey/ent = 3,
		/obj/item/clothing/gloves/bluespace = 3,
		/obj/item/clothing/under/color/red = 3,
		/obj/item/gun/energy/lasertag/red = 3,
		/obj/item/clothing/head/redtag = 3,
		/obj/item/clothing/suit/redtag = 3)

/obj/structure/closet/lasertag/blue/laserdome
	name = "blue team laserdome equipment"
	desc = "It's a storage unit for laser tag equipment."
	closet_appearance = /decl/closet_appearance/wardrobe/blue

	starts_with = list(
		/obj/item/encryptionkey/ent = 3,
		/obj/item/clothing/gloves/bluespace = 3,
		/obj/item/clothing/under/color/blue = 3,
		/obj/item/gun/energy/lasertag/blue = 3,
		/obj/item/clothing/head/bluetag = 3,
		/obj/item/clothing/suit/bluetag = 3)

// Outpost 21 edit begin - omni lasertag
/obj/structure/closet/lasertag/omni
	name = "omni laser tag equipment"
	desc = "It's a storage unit for laser tag equipment."
	closet_appearance = /decl/closet_appearance/wardrobe/purple

	starts_with = list(
		/obj/item/gun/energy/lasertag/omni = 4,
		/obj/item/lasertagknife = 4,
		/obj/item/clothing/suit/omnitag = 4,
		/obj/item/clothing/head/helmet/lasertag = 4)
// Outpost 21 edit end
