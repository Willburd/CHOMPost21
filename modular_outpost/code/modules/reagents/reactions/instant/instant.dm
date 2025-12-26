/decl/chemical_reaction/instant/hemocyanin
	name = REAGENT_HEMOCYANIN
	id = REAGENT_ID_HEMOCYANIN
	result = REAGENT_ID_HEMOCYANIN
	required_reagents = list(REAGENT_ID_NITROGEN = 5, REAGENT_ID_HYDROGEN = 3, REAGENT_ID_CARBON = 10, REAGENT_ID_COPPER = 1, REAGENT_ID_PHORON = 0.2)
	catalysts = list(REAGENT_ID_PHORON = 1)
	result_amount = 20

/decl/chemical_reaction/instant/sulphuricacid
	name = REAGENT_SACID
	id = REAGENT_ID_SACID
	result = REAGENT_ID_SACID
	required_reagents = list(REAGENT_ID_HYDROGEN = 2,REAGENT_ID_SULFUR = 1,REAGENT_ID_OXYGEN = 4)
	result_amount = 5

/decl/chemical_reaction/instant/silicon
	name = REAGENT_SILICON
	id = "reduce_silicate"
	result = REAGENT_ID_SILICON
	required_reagents = list(REAGENT_ID_SILICATE = 1, REAGENT_ID_SACID = 1,REAGENT_ID_SULFUR = 1)
	result_amount = 1

/decl/chemical_reaction/instant/riotsmoke
	name = "Riotgas"
	id = "riotsmoke"
	result = null
	required_reagents = list(REAGENT_ID_TITANIUMDIOX = 1, REAGENT_ID_CHLORINE = 4, REAGENT_ID_PHOSPHORUS= 1)
	result_amount = 0.4

/decl/chemical_reaction/instant/riotsmoke/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/location = get_turf(holder.my_atom)
	var/datum/effect/effect/system/smoke_spread/bad/S = new /datum/effect/effect/system/smoke_spread/bad
	S.attach(location)
	S.set_up(holder, created_volume, 0, location)
	playsound(location, 'sound/effects/smoke.ogg', 50, 1, -3)
	spawn(0)
		S.start()
	if(!isliving(holder.my_atom)) //No more powergaming by creating a tiny amount of this
		holder.clear_reagents()
	return

// Nukies OMEGA
/decl/chemical_reaction/instant/nukies_final
	name = REAGENT_NUKIEFINAL
	id = REAGENT_ID_NUKIEFINAL
	result = REAGENT_ID_NUKIEFINAL
	required_reagents = list(
		REAGENT_ID_ICE = 1,
		REAGENT_ID_NUKIESPECIAL = 1,
		REAGENT_ID_NUKIEMEGASIGHT = 1,
		REAGENT_ID_NUKIEMEGAHEART = 1,
		REAGENT_ID_NUKIEMEGASLEEP = 1,
		REAGENT_ID_NUKIEMEGASHOCK = 1,
		REAGENT_ID_NUKIEMEGAFAST = 1,
		REAGENT_ID_NUKIEMEGAHIGH = 1,
		REAGENT_ID_NUKIEMEGASHRINK = 1,
		REAGENT_ID_NUKIEMEGAGROWTH = 1)
	result_amount = 0.1
