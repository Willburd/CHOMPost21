/obj/item/reagent_containers/pill/paroxetine
	name = "Paroxetine (5u)"
	desc = "Stabilizes the mind greatly, but has a chance of adverse effects. Medicate cautiously."
	icon_state = "pill2"

/obj/item/reagent_containers/pill/paroxetine/Initialize()
	. = ..()
	reagents.add_reagent(REAGENT_ID_PAROXETINE, 5)

/obj/item/reagent_containers/pill/lithium
	name = "Lithium (5u)"
	desc = "Used in the treatment of schizophrenia, Alzheimer's disease, and dementia. Medicate cautiously."
	icon_state = "pill2"

/obj/item/reagent_containers/pill/lithium/Initialize()
	. = ..()
	reagents.add_reagent(REAGENT_ID_LITHIUM, 5)

/obj/item/reagent_containers/pill/zoom_old
	name = "Zoom pill"
	desc = "Zoooom!"
	icon_state = "pill4"

/obj/item/reagent_containers/pill/zoom_old/Initialize()
	. = ..()
	if(prob(10))
		reagents.add_reagent(REAGENT_ID_EXPIREDMEDICINE, 5)
	reagents.add_reagent(REAGENT_ID_STIMM, 10)
	color = reagents.get_color()
