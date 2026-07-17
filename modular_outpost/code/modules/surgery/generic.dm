
/datum/surgery_step/generic/cut_open
	allowed_tools = list(
		/obj/item/surgical/scalpel = 100,
		/obj/item/material/knife = 95,
		/obj/item/material/shard = 80
	)

/datum/surgery_step/generic/retract_skin
	allowed_tools = list(
		/obj/item/surgical/retractor = 100,
		/obj/item/material/kitchen/utensil/fork = 90
	)

/datum/surgery_step/generic/cauterize
	allowed_tools = list(
		/obj/item/surgical/cautery = 100,
		/obj/item/clothing/mask/smokable/cigarette = 95,
		/obj/item/flame/lighter = 75,
		/obj/item/weldingtool = 60
	)
