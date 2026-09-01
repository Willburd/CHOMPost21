/datum/particle_smasher_recipe/subspace_one
	display_name = "Primed subspace catalyst crystal"
	reagents = list(REAGENT_ID_RADIUM = 20, REAGENT_ID_PHORON = 20)
	recipe_type = "item" // PS_RESULT_ITEM

	result = /obj/item/primed_subcrystal
	required_material = /obj/item/stock_parts/subspace/crystal

	required_energy_min = 500
	required_energy_max = 600

	required_atmos_temp_min = 11000
	required_atmos_temp_max = 12000
	probability = 30

/obj/item/primed_subcrystal
	name = "primed subspace catalyst crystal"
	icon_state = "telecrystal"
	desc = "A crystal made from pure glass. It has been charged with exotic subspace radiation. It's edges look fuzzy, like it is leaking out of physical space, it may react strangely if teleported. It's fading fast, so you'd better find a use for it quickly!"
	gender = PLURAL
	icon = 'icons/obj/stock_parts.dmi'
	w_class = ITEMSIZE_SMALL
	drop_sound = 'sound/items/drop/glass.ogg'
	pickup_sound = 'sound/items/pickup/glass.ogg'
	matter = list(MAT_GLASS = MATERIAL_COST(0.025))

/obj/item/primed_subcrystal/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_POST_TELEPORT, PROC_REF(handle_teleported))
	var/fade_time = rand(2,3) MINUTES
	QDEL_IN(src, fade_time)
	animate(src, time = fade_time, alpha = 90)

/obj/item/primed_subcrystal/Destroy(force, ...)
	UnregisterSignal(src, COMSIG_MOVABLE_POST_TELEPORT)
	. = ..()

/obj/item/primed_subcrystal/proc/handle_teleported(datum/source, atom/destination, channel)
	SIGNAL_HANDLER
	if(channel != TELEPORT_CHANNEL_BLUESPACE)
		explosion(get_turf(src), 1, 1, 1, 2)
		qdel(src)
		return
	new /obj/item/stable_subcrystal(loc)
	qdel(src)

/obj/item/stable_subcrystal
	name = "stablized subspace catalyst crystal"
	icon = 'icons/obj/telescience.dmi'
	icon_state = "polycrystal"
	desc = "A crystal made from pure glass. It's physical nature has been altered by bluespace travel and now contains a pocket of bluespace within it. You feel like you're back in the 2100s with this classical bluespace research experiment!"
