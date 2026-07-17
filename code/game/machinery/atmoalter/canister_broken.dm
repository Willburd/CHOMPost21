/obj/machinery/portable_atmospherics/canister/oxygen/broken
	icon_state = "blue-1"
/obj/machinery/portable_atmospherics/canister/phoron/broken
	icon_state = "orangeps-1"
/obj/machinery/portable_atmospherics/canister/nitrogen/broken
	icon_state = "red-1"
/obj/machinery/portable_atmospherics/canister/carbon_dioxide/broken
	icon_state = "black-1"
/obj/machinery/portable_atmospherics/canister/nitrous_oxide/broken
	icon_state = "redws-1"
/obj/machinery/portable_atmospherics/canister/nitrophoric_oxide/broken
	icon_state = "purple-1"
/obj/machinery/portable_atmospherics/canister/methane/broken
	icon_state = "green-1"

/obj/machinery/portable_atmospherics/canister/oxygen/broken/process()
	if (!destroyed)
		take_damage(10000) // BANG
	. = ..()

/obj/machinery/portable_atmospherics/canister/phoron/broken/process()
	if (!destroyed)
		take_damage(10000) // BANG
	. = ..()

/obj/machinery/portable_atmospherics/canister/nitrogen/broken/process()
	if (!destroyed)
		take_damage(10000) // BANG
	. = ..()

/obj/machinery/portable_atmospherics/canister/carbon_dioxide/broken/process()
	if (!destroyed)
		take_damage(10000) // BANG
	. = ..()

/obj/machinery/portable_atmospherics/canister/nitrous_oxide/broken/process()
	if (!destroyed)
		take_damage(10000) // BANG
	. = ..()

/obj/machinery/portable_atmospherics/canister/nitrophoric_oxide/broken/process()
	if (!destroyed)
		take_damage(10000) // BANG
	. = ..()

/obj/machinery/portable_atmospherics/canister/methane/broken/process()
	if (!destroyed)
		take_damage(10000) // BANG
	. = ..()
