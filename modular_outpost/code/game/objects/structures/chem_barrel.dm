// Expies love their jungle juice!
/obj/structure/reagent_dispensers/barrel/randomized_chem
	name = "chemical barrel"
	desc = "A barrel with warning labels painted all over it."
	icon = 'icons/obj/objects_vr.dmi'
	icon_state = "barrel2"
	var/static/list/random_allowed_chems = list(
		REAGENT_ID_BICARIDAZE,
		REAGENT_ID_BICARIDINE,
		REAGENT_ID_KELOTANE,
		REAGENT_ID_DERMALAZE,
		REAGENT_ID_DERMALINE,
		REAGENT_ID_TRICORLIDAZE,
		REAGENT_ID_TRICORDRAZINE,
		REAGENT_ID_ADRANOL,
		REAGENT_ID_MILK,
		REAGENT_ID_ANTITOXIN,
		REAGENT_ID_COFFEE,
		REAGENT_ID_ALKYSINE,
		REAGENT_ID_DEXALIN,
		REAGENT_ID_DEXALINP,
		REAGENT_ID_GRAPEJUICE,
		REAGENT_ID_GRAPESODA,
		REAGENT_ID_ORANGEJUICE,
		REAGENT_ID_ORANGESODA,
		REAGENT_ID_APPLEJUICE,
		REAGENT_ID_APPLESODA,
		REAGENT_ID_MINDBREAKER,
		REAGENT_ID_BLISS,
		REAGENT_ID_NOCTURNOL,
		REAGENT_ID_NICOTINE,
		REAGENT_ID_BERSERKMED,
		REAGENT_ID_NECROXADONE,
		REAGENT_ID_SYNAPTIZINE,
		REAGENT_ID_HYPERZINE,
		REAGENT_ID_OSTEODAXON,
		REAGENT_ID_MYELAMINE,
		REAGENT_ID_SPACOMYCAZE,
		REAGENT_ID_SPACEACILLIN,
		REAGENT_ID_IMMUNOSUPRIZINE,
		REAGENT_ID_THERMITE,
		REAGENT_ID_WATER,
		REAGENT_ID_LUBE,
		REAGENT_ID_CLEANER,
		REAGENT_ID_CLONEXADONE,
		REAGENT_ID_CHLORINE,
		REAGENT_ID_CHOCOLATEMILK,
		REAGENT_ID_HOLYWATER,
		REAGENT_ID_ASUSTENANCE,
		REAGENT_ID_TERCOZOLAM,
		REAGENT_ID_FENTHOL,
		REAGENT_ID_CHLORALHYDRATE,
		REAGENT_ID_ZOMBIEPOWDER,
		REAGENT_ID_ETHANOL,
		REAGENT_ID_MERCURY,
		REAGENT_ID_FUEL
	)

/obj/structure/reagent_dispensers/barrel/randomized_chem/Initialize(mapload)
	. = ..()
	var/max_vol = reagents.maximum_volume * 0.5 // Half tank max cause 5000u normally
	reagents.add_reagent(pick(random_allowed_chems),rand(max_vol / 12, max_vol / 5))
	if(prob(50))
		reagents.add_reagent(pick(random_allowed_chems),rand(max_vol / 12, max_vol / 5))
	if(prob(50))
		reagents.add_reagent(pick(random_allowed_chems),rand(max_vol / 12, max_vol / 5))
	if(prob(20))
		reagents.add_reagent(pick(random_allowed_chems),rand(max_vol / 12, max_vol / 5))
	if(prob(10))
		reagents.add_reagent(pick(random_allowed_chems),rand(max_vol / 12, max_vol / 5))
