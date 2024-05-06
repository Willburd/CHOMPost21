// Detects reagents inside most containers, and acts as an infinite identification system for reagent-based unidentified objects.

/obj/machinery/chemical_analyzer
	name = "chem analyzer"
	desc = "Used to precisely scan chemicals and other liquids inside various containers. \
	It may also identify the liquid contents of unknown objects."
	description_info = "This machine will try to tell you what reagents are inside of something capable of holding reagents. \
	It is also used to 'identify' specific reagent-based objects with their properties obscured from inspection by normal means."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "chem_analyzer"
	density = TRUE
	anchored = TRUE
	use_power = TRUE
	idle_power_usage = 20
	clicksound = "button"
	var/analyzing = FALSE

/obj/machinery/chemical_analyzer/update_icon()
	icon_state = "chem_analyzer[analyzing ? "-working":""]"

/obj/machinery/chemical_analyzer/attackby(obj/item/I, mob/living/user)
	if(!istype(I))
		return ..()

	if(default_deconstruction_screwdriver(user, I))
		return
	if(default_deconstruction_crowbar(user, I))
		return

	if(istype(I,/obj/item/weapon/reagent_containers))
		analyzing = TRUE
		update_icon()
		to_chat(user, span("notice", "Analyzing \the [I], please stand by..."))

		if(!do_after(user, 2 SECONDS, src))
			to_chat(user, span("warning", "Sample moved outside of scan range, please try again and remain still."))
			analyzing = FALSE
			update_icon()
			return

		// First, identify it if it isn't already.
		if(!I.is_identified(IDENTITY_FULL))
			var/datum/identification/ID = I.identity
			if(ID.identification_type == IDENTITY_TYPE_CHEMICAL) // This only solves chemical-based mysteries.
				I.identify(IDENTITY_FULL, user)

		// Now tell us everything that is inside.
		if(I.reagents && I.reagents.reagent_list.len)
			to_chat(user, "<br>") // To add padding between regular chat and the output.
			for(var/datum/reagent/R in I.reagents.reagent_list)
				if(!R.name)
					continue
				to_chat(user, span("notice", "Contains [R.volume]u of <b>[R.name]</b>.<br>[R.description]<br><br>"))
				var/list/products = SSchemistry.chemical_reactions_by_product[R.id]
				if(products != null && products.len > 0)
					var/segment = 1
					var/list/display_reactions = list()
					for(var/decl/chemical_reaction/CR in products)
						if(!CR.spoiler)
							display_reactions.Add(CR)
					for(var/decl/chemical_reaction/CR in display_reactions)
						if(display_reactions.len == 1)
							to_chat(user, span("notice", "Potential Chemical breakdown: <br>"))
						else
							to_chat(user, span("notice", "Potential Chemical breakdown [segment]: <br>"))
						segment += 1

						for(var/RQ in CR.required_reagents)
							var/decl/chemical_reaction/r_RQ = SSchemistry.chemical_reagents[RQ]
							to_chat(user, span("notice", " -parts [r_RQ.name]<br>"))
						for(var/IH in CR.inhibitors)
							var/decl/chemical_reaction/r_IH = SSchemistry.chemical_reagents[IH]
							to_chat(user, span("notice", " -inhbi [r_IH.name]<br>"))
						for(var/CL in CR.catalysts)
							var/decl/chemical_reaction/r_CL = SSchemistry.chemical_reagents[CL]
							to_chat(user, span("notice", " -catyl [r_CL.name]<br>"))
						to_chat(user, span("notice", "<br>"))
				else
					to_chat(user, span("notice", "Potential Chemical breakdown: <br>UNKNOWN OR BASE-REAGENT<br><br>"))

				var/list/distilled_products = SSchemistry.distilled_reactions_by_product[R.id]
				if(distilled_products != null && distilled_products.len > 0)
					var/segment = 1

					var/list/display_reactions = list()
					for(var/decl/chemical_reaction/distilling/CR in distilled_products)
						if(!CR.spoiler)
							display_reactions.Add(CR)

					for(var/decl/chemical_reaction/distilling/CR in display_reactions)
						if(display_reactions.len == 1)
							to_chat(user, span("notice", "Potential Chemical Distillation: <br>"))
						else
							to_chat(user, span("notice", "Potential Chemical Distillation [segment]: <br>"))
						segment += 1

						to_chat(user, span("notice", " -temps [CR.temp_range[1]] - [CR.temp_range[2]]<br>"))

						for(var/RQ in CR.required_reagents)
							var/decl/chemical_reaction/r_RQ = SSchemistry.chemical_reagents[RQ]
							to_chat(user, span("notice", " -parts [r_RQ.name]<br>"))
						for(var/IH in CR.inhibitors)
							var/decl/chemical_reaction/r_IH = SSchemistry.chemical_reagents[IH]
							to_chat(user, span("notice", " -inhbi [r_IH.name]<br>"))
						for(var/CL in CR.catalysts)
							var/decl/chemical_reaction/r_CL = SSchemistry.chemical_reagents[CL]
							to_chat(user, span("notice", " -catyl [r_CL.name]<br>"))
					to_chat(user, span("notice", "<br>"))

		// Last, unseal it if it's an autoinjector.
		if(istype(I,/obj/item/weapon/reagent_containers/hypospray/autoinjector/biginjector) && !(I.flags & OPENCONTAINER))
			I.flags |= OPENCONTAINER
			to_chat(user, span("notice", "Sample container unsealed.<br>"))

		to_chat(user, span("notice", "Scanning of \the [I] complete."))
		analyzing = FALSE
		update_icon()
		return
