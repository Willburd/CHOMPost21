/obj/item/weapon/reagent_containers/pill/paroxetine
	name = "Paroxetine (5u)"
	desc = "Stabilizes the mind greatly, but has a chance of adverse effects. Medicate cautiously."
	icon_state = "pill2"

/obj/item/weapon/reagent_containers/pill/paroxetine/Initialize()
	. = ..()
	reagents.add_reagent("paroxetine", 5)

/obj/item/weapon/reagent_containers/pill/lithium
	name = "Lithium (5u)"
	desc = "Used in the treatment of schizophrenia, Alzheimer's disease, and dementia. Medicate cautiously."
	icon_state = "pill2"

/obj/item/weapon/reagent_containers/pill/lithium/Initialize()
	. = ..()
	reagents.add_reagent("lithium", 5)
