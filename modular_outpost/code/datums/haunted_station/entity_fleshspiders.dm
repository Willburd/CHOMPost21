/datum/haunting_entity/flesh_spiders
	name = "ENTITY - Flesh Spiders"

/datum/haunting_entity/flesh_spiders/New()
	. = ..()

	var/list/vents = list()
	for(var/obj/machinery/atmospherics/unary/vent_pump/temp_vent in GLOB.machines)
		if(!temp_vent.welded && temp_vent.network && (temp_vent.loc.z in using_map.event_levels))
			if(temp_vent.network.normal_members.len > 20)
				for(var/mob/living/L in range(12,temp_vent))
					if((ishuman(L) || issilicon(L)) && L.stat != DEAD)
						continue // skip... Too close to player
				var/area/A = get_area(temp_vent)
				if(!(A.flag_check(AREA_FORBID_EVENTS)))
					vents += temp_vent

	if(!vents.len)
		return
	for(var/i = 1 to rand(1,3))
		var/obj/machinery/atmospherics/unary/vent_pump/check_vent = pick(vents)
		for(var/i = 1 to rand(10,15))
			new /obj/effect/spider/spiderling/flesh(get_turf(check_vent))

/datum/haunting_entity/flesh_spiders/process()
	qdel(src) // End instantly
