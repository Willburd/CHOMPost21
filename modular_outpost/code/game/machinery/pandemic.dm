/obj/machinery/computer/pandemic/isolator
	name = "Antibody Isolator"
	desc = "Isolates antibodies from blood samples."
	circuit = /obj/item/circuitboard/pandemic_isolator
	icon = 'modular_outpost/icons/obj/pandemic.dmi'

	allow_strains = FALSE
	allow_antibodies = TRUE

/obj/machinery/computer/pandemic/admin // basically just upstream's original combined model
	allow_strains = TRUE
	allow_antibodies = TRUE
