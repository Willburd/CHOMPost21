// Adminspawn only, do not let anyone get this.
/datum/material/alienalloy
	name = MAT_ALIENALLOY
	display_name = "durable alloy"
	stack_type = null
	flags = MATERIAL_UNMELTABLE
	icon_colour = "#6C7364"
	integrity = 1200
	melting_point = 46000 // Hull plating. Outpost 21 edit - was 6000
	explosion_resistance = 200 // Hull plating.
	hardness = 500
	weight = 500
	protectiveness = 80 // 80%
	wiki_flag = WIKI_SPOILER

/datum/material/alienalloy/elevatorium
	name = "elevatorium"
	display_name = "elevator panelling"
	table_icon_base = "stone"
	icon_colour = "#666666"

/datum/material/alienalloy/dungeonium
	name = "dungeonium"
	display_name = "ultra-durable"
	icon_base = "dungeon"
	table_icon_base = "stone"
	icon_colour = "#FFFFFF"

/datum/material/alienalloy/bedrock
	name = "bedrock"
	display_name = "impassable rock"
	icon_base = "rock"
	table_icon_base = "stone"
	icon_colour = "#FFFFFF"

/datum/material/alienalloy/alium
	name = "alium"
	display_name = "alien"
	icon_base = "alien"
	table_icon_base = "alien"
	icon_colour = "#FFFFFF"
