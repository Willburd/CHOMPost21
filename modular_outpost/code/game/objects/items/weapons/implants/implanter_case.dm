/obj/item/implantcase/blood_sugar
	name = "glass case - 'bloodsugar'"
	desc = "A case containing a blood sugar monitoring implant."
	icon_state = "implantcase-r"

/obj/item/implantcase/blood_sugar/Initialize(mapload)
	. = ..()
	imp = new /obj/item/implant/blood_sugar(src)
