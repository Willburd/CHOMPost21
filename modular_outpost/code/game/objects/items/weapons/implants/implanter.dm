/obj/item/implanter/blood_sugar
	name = "implanter-bloodsugar"

/obj/item/implanter/blood_sugar/Initialize(mapload)
	. = ..()
	imp = new /obj/item/implant/blood_sugar( src )
	update()
