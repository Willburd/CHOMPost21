/datum/particle_smasher_recipe/platinum_lead
	display_name = MAT_LEAD + " from " + MAT_PLATINUM
	reagents = list(REAGENT_ID_TUNGSTEN = 10)

	result = /obj/item/stack/material/lead
	required_material = /obj/item/stack/material/platinum

	required_energy_min = 100
	required_energy_max = 300

	required_atmos_temp_min = 2000
	required_atmos_temp_max = 6000
	probability = 50

/datum/particle_smasher_recipe/uranium_lead
	display_name = MAT_LEAD + " from " + MAT_URANIUM
	reagents = list(REAGENT_ID_TUNGSTEN = 10)

	result = /obj/item/stack/material/lead
	required_material = /obj/item/stack/material/uranium

	required_energy_min = 50
	required_energy_max = 600

	required_atmos_temp_min = 1000
	required_atmos_temp_max = 10000
	probability = 70

/datum/particle_smasher_recipe/uranium_platinum
	display_name = MAT_PLATINUM + " from " + MAT_URANIUM
	reagents = list(REAGENT_ID_TUNGSTEN = 10)

	result = /obj/item/stack/material/platinum
	required_material = /obj/item/stack/material/uranium

	required_energy_min = 600
	required_energy_max = 650

	required_atmos_temp_min = 6000
	required_atmos_temp_max = 10000
	probability = 30

/datum/particle_smasher_recipe/platinum_uranium
	display_name = MAT_URANIUM + " from " + MAT_PLATINUM
	reagents = list(REAGENT_ID_SILICON = 10)

	result = /obj/item/stack/material/uranium
	required_material = /obj/item/stack/material/platinum

	required_energy_min = 600
	required_energy_max = 700

	required_atmos_temp_min = 8000
	required_atmos_temp_max = 12000
	probability = 40

/datum/particle_smasher_recipe/iron_copper
	display_name = MAT_COPPER + " from " + MAT_IRON
	reagents = list(REAGENT_ID_LITHIUM = 10)

	result = /obj/item/stack/material/copper
	required_material = /obj/item/stack/material/iron

	required_energy_min = 100
	required_energy_max = 300

	required_atmos_temp_min = 2000
	required_atmos_temp_max = 6000
	probability = 40

/datum/particle_smasher_recipe/copper_gold
	display_name = MAT_GOLD + " from " + MAT_COPPER
	reagents = list(REAGENT_ID_TIN = 10)

	result = /obj/item/stack/material/gold
	required_material = /obj/item/stack/material/copper

	required_energy_min = 200
	required_energy_max = 400

	required_atmos_temp_min = 5000
	required_atmos_temp_max = 8000
	probability = 40

/datum/particle_smasher_recipe/hydrogen_deuterium
	display_name = MAT_DEUTERIUM + " from " + MAT_GRAPHITE
	reagents = list(REAGENT_ID_HYDROGEN = 10)

	result = /obj/item/stack/material/deuterium
	required_material = /obj/item/stack/material/graphite

	required_energy_min = 0
	required_energy_max = 100

	required_atmos_temp_min = 1000
	required_atmos_temp_max = 3000
	probability = 20

/datum/particle_smasher_recipe/carbon_titanium
	display_name = MAT_TITANIUM + " from " + MAT_GRAPHITE
	reagents = list(REAGENT_ID_SULFUR = 10)

	result = /obj/item/stack/material/titanium
	required_material = /obj/item/stack/material/graphite

	required_energy_min = 300
	required_energy_max = 600

	required_atmos_temp_min = 3000
	required_atmos_temp_max = 8000
	probability = 40

/datum/particle_smasher_recipe/tritium_mhydrogen
	display_name = MAT_METALHYDROGEN + " from " + MAT_TRITIUM
	reagents = list(REAGENT_ID_RADIUM = 300)

	result = /obj/item/stack/material/mhydrogen
	required_material = /obj/item/stack/material/tritium

	required_energy_min = 500
	required_energy_max = 550

	required_atmos_temp_min = 7000
	required_atmos_temp_max = 12000
	probability = 20

/datum/particle_smasher_recipe/osmium_platinum
	display_name = MAT_PLATINUM + " from " + MAT_OSMIUM
	reagents = list(REAGENT_ID_TUNGSTEN = 10)

	result = /obj/item/stack/material/platinum
	required_material = /obj/item/stack/material/osmium

	required_energy_min = 400
	required_energy_max = 500

	required_atmos_temp_min = 8000
	required_atmos_temp_max = 10000
	probability = 20

/datum/particle_smasher_recipe/aluminium_iron
	display_name = MAT_IRON + " from " + MAT_ALUMINIUM
	reagents = list(REAGENT_ID_ALUMINIUM = 50)

	result = /obj/item/stack/material/iron
	required_material = /obj/item/stack/material/aluminium

	required_energy_min = 200
	required_energy_max = 300

	required_atmos_temp_min = 1000
	required_atmos_temp_max = 5000
	probability = 30

/datum/particle_smasher_recipe/lead_silver
	display_name = MAT_SILVER + " from " + MAT_LEAD
	reagents = list(REAGENT_ID_RADIUM = 50)

	result = /obj/item/stack/material/silver
	required_material = /obj/item/stack/material/lead

	required_energy_min = 600
	required_energy_max = 700

	required_atmos_temp_min = 8000
	required_atmos_temp_max = 10000
	probability = 30
