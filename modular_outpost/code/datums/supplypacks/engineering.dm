/datum/supply_pack/eng/airlock_brace
	name = "Airlock Brace Crate"
	contains = list(
		/obj/item/tool/crowbar/brace_jack,
		/obj/item/airlock_brace,
		/obj/item/airlock_brace,
		/obj/item/airlock_brace,
		/obj/item/airlock_brace,
		/obj/item/airlock_brace
		)
	cost = 80
	containertype = /obj/structure/closet/crate/focalpoint
	containername = "airlock brace crate"

/datum/supply_pack/eng/engine/confinement_beam
	name = "Confinement Beam Generator crate"
	desc = "All the parts needed to set up a confinement beam generator. Requires Chief Engineer access."
	cost = 300
	contains = list(
			/obj/structure/confinement_beam_generator/control_box,
			/obj/structure/confinement_beam_generator/inductor,
			/obj/structure/confinement_beam_generator/inductor,
			/obj/structure/confinement_beam_generator/gen,
			/obj/structure/confinement_beam_generator/focus,
			/obj/machinery/atmospherics/unary/heat_exchanger,
			/obj/machinery/atmospherics/unary/heat_exchanger,
			/obj/structure/confinement_beam_generator/lens/inner_lens,
			/obj/structure/confinement_beam_generator/lens/outer_lens,
			/obj/structure/confinement_beam_generator/lens/outer_lens
			)
	containertype = /obj/structure/closet/crate/secure/einstein
	containername = "Confinement Beam Generator crate"
	access = list(access_ce)
	one_access = TRUE

/datum/supply_pack/eng/engine/confinement_beam_lens
	name = "Confinement Beam Lens crate"
	desc = "All the parts needed to set up a confinement beam lens. Requires Chief Engineer access."
	cost = 90
	contains = list(
			/obj/structure/confinement_beam_generator/focus,
			/obj/machinery/atmospherics/unary/heat_exchanger,
			/obj/machinery/atmospherics/unary/heat_exchanger,
			/obj/structure/confinement_beam_generator/lens/inner_lens,
			/obj/structure/confinement_beam_generator/lens/outer_lens,
			/obj/structure/confinement_beam_generator/lens/outer_lens,
			/obj/structure/confinement_beam_generator/lens/inner_lens,
			/obj/structure/confinement_beam_generator/lens/outer_lens,
			/obj/structure/confinement_beam_generator/lens/outer_lens
			)
	containertype = /obj/structure/closet/crate/secure/einstein
	containername = "Confinement Beam Lens crate"
	access = list(access_ce)
	one_access = TRUE

/datum/supply_pack/eng/engine/confinement_beam_collector
	name = "Confinement Beam Collector crate"
	desc = "All the parts needed to set up a confinement beam collector. Requires Chief Engineer access."
	cost = 90
	contains = list(
			/obj/structure/confinement_beam_generator/collector,
			/obj/structure/confinement_beam_generator/inductor,
			/obj/structure/confinement_beam_generator/inductor,
			/obj/structure/confinement_beam_generator/inductor,
			/obj/structure/confinement_beam_generator/inductor,
			)
	containertype = /obj/structure/closet/crate/secure/einstein
	containername = "Confinement Beam Collector crate"
	access = list(access_ce)
	one_access = TRUE
