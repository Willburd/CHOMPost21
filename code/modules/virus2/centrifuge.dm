/obj/machinery/computer/centrifuge
	name = "isolation centrifuge"
	desc = "Used to separate things with different weight. Spin 'em round, round, right round."
	icon = 'icons/obj/virology_vr.dmi' //VOREStation Edit
	icon_state = "centrifuge"
	var/curing
	var/isolating

	var/obj/item/reagent_containers/glass/beaker/vial/sample = null
	var/datum/disease2/disease/virus2 = null

/obj/machinery/computer/centrifuge/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(O.has_tool_quality(TOOL_SCREWDRIVER))
		return ..(O,user)

	if(default_unfasten_wrench(user, O, 20))
		return

	if(istype(O,/obj/item/reagent_containers/glass/beaker/vial))
		if(sample)
			to_chat(user, "\The [src] is already loaded.")
			return

		sample = O
		user.drop_item()
		O.loc = src

		user.visible_message("[user] adds \a [O] to \the [src]!", "You add \a [O] to \the [src]!")
		SStgui.update_uis(src)

	src.attack_hand(user)

/obj/machinery/computer/centrifuge/update_icon()
	..()
	if(! (stat & (BROKEN|NOPOWER)) && (isolating || curing))
		icon_state = "centrifuge_moving"

/obj/machinery/computer/centrifuge/attack_hand(var/mob/user as mob)
	if(..())
		return
	tgui_interact(user)

/obj/machinery/computer/centrifuge/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "IsolationCentrifuge", name)
		ui.open()

/obj/machinery/computer/centrifuge/tgui_data(mob/user)
	var/list/data = list()
	data["antibodies"] = null
	data["pathogens"] = list()
	data["is_antibody_sample"] = null
	data["busy"] = null
	data["sample_inserted"] = !!sample

	if(curing)
		data["busy"] = "Isolating antibodies..."
	else if(isolating)
		data["busy"] = "Isolating pathogens..."
	else
		if(sample)
			var/datum/reagent/blood/B = locate(/datum/reagent/blood) in sample.reagents.reagent_list
			if(B)
				data["antibodies"] = antigens2string(B.data["antibodies"], none=null)

				var/list/pathogens[0]
				var/list/virus = B.data["virus2"]
				for (var/ID in virus)
					var/datum/disease2/disease/V = virus[ID]
					pathogens.Add(list(list("name" = V.name(), "spread_type" = V.spreadtype, "reference" = "\ref[V]")))

				data["pathogens"] = pathogens

			else
				var/datum/reagent/antibodies/A = locate(/datum/reagent/antibodies) in sample.reagents.reagent_list
				if(A)
					data["antibodies"] = antigens2string(A.data["antibodies"], none=null)
				data["is_antibody_sample"] = 1

	return data

/obj/machinery/computer/centrifuge/process()
	..()
	if(stat & (NOPOWER|BROKEN)) return

	if(curing)
		curing -= 1
		if(curing == 0)
			cure()

	if(isolating)
		isolating -= 1
		if(isolating == 0)
			isolate()

/obj/machinery/computer/centrifuge/tgui_act(action, params)
	if(..())
		return TRUE

	var/mob/user = usr
	add_fingerprint(user)


	switch(action)
		if("print")
			print(user)
			. = TRUE
		if("isolate")
			var/datum/reagent/blood/B = locate(/datum/reagent/blood) in sample.reagents.reagent_list
			if(B)
				var/datum/disease2/disease/virus = locate(params["isolate"])
				virus2 = virus.getcopy()
				isolating = 40
				update_icon()
			. = TRUE
		if("antibody")
			var/delay = 20
			var/datum/reagent/blood/B = locate(/datum/reagent/blood) in sample.reagents.reagent_list
			if(!B)
				state("\The [src] buzzes, \"No antibody carrier detected.\"", "blue")
				return TRUE

			var/has_toxins = locate(/datum/reagent/toxin) in sample.reagents.reagent_list
			var/has_radium = sample.reagents.has_reagent(REAGENT_ID_RADIUM)
			if(has_toxins || has_radium)
				state("\The [src] beeps, \"Pathogen purging speed above nominal.\"", "blue")
				if(has_toxins)
					delay = delay/2
				if(has_radium)
					delay = delay/2

			curing = round(delay)
			playsound(src, 'sound/machines/juicer.ogg', 50, 1)
			update_icon()
			. = TRUE
		if("sample")
			if(sample)
				sample.loc = src.loc
				sample = null
			. = TRUE


/obj/machinery/computer/centrifuge/proc/cure()
	if(!sample) return
	var/datum/reagent/blood/B = locate(/datum/reagent/blood) in sample.reagents.reagent_list
	if(!B) return

	var/list/data = list("antibodies" = B.data["antibodies"])
	var/amt= sample.reagents.get_reagent_amount(REAGENT_ID_BLOOD)
	sample.reagents.remove_reagent(REAGENT_ID_BLOOD, amt)
	sample.reagents.add_reagent(REAGENT_ID_ANTIBODIES, amt, data)

	SStgui.update_uis(src)
	update_icon()
	ping("\The [src] pings, \"Antibody isolated.\"")

/obj/machinery/computer/centrifuge/proc/isolate()
	if(!sample) return
	var/obj/item/virusdish/dish = new/obj/item/virusdish(loc)
	dish.virus2 = virus2
	virus2 = null

	SStgui.update_uis(src)
	update_icon()
	ping("\The [src] pings, \"Pathogen isolated.\"")

/obj/machinery/computer/centrifuge/proc/print(var/mob/user)
	var/obj/item/paper/P = new /obj/item/paper(loc)
	P.name = "paper - Pathology Report"
	P.info = {"
		[virology_letterhead("Pathology Report")]
		<large><u>Sample:</u></large> [sample.name]<br>
"}

	if(user)
		P.info += "<u>Generated By:</u> [user.name]<br>"

	P.info += "<hr>"

	var/datum/reagent/blood/B = locate(/datum/reagent/blood) in sample.reagents.reagent_list
	if(B)
		P.info += "<u>Antibodies:</u> "
		P.info += antigens2string(B.data["antibodies"])
		P.info += "<br>"

		var/list/virus = B.data["virus2"]
		P.info += "<u>Pathogens:</u> <br>"
		if(virus.len > 0)
			for (var/ID in virus)
				var/datum/disease2/disease/V = virus[ID]
				P.info += "stamm #[add_zero("[V.uniqueID]", 4)]<br>" // CHOMPEdit - Making sure to not show the name at first!
		else
			P.info += "None<br>"

	else
		var/datum/reagent/antibodies/A = locate(/datum/reagent/antibodies) in sample.reagents.reagent_list
		if(A)
			P.info += "The following antibodies have been isolated from the blood sample: "
			P.info += antigens2string(A.data["antibodies"])
			P.info += "<br>"

	P.info += {"
	<hr>
	<u>Additional Notes:</u> <field>
"}

	state("The nearby computer prints out a pathology report.")
