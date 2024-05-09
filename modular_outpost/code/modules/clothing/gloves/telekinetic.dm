/obj/item/clothing/gloves/telekinetic
	desc = "Gloves with a built in telekinesis module, allows for remote interaction with small objects."
	name = "kinesis assistance module"
	icon_state = "regen"
	item_state = "graygloves"

/obj/item/clothing/gloves/telekinetic/Initialize()
	. = ..()
	cell = new(src)

/obj/item/clothing/gloves/telekinetic/proc/has_grip_power()
	if(cell && cell.charge > 0)
		return TRUE
	return FALSE

/obj/item/clothing/gloves/telekinetic/proc/use_grip_power()
	// TODO - call this when using GRIP
	if(cell)
		cell.charge -= 4
	if(cell.charge < 0)
		cell.charge = 0
