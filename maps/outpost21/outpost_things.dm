// This file is meant ONLY for hyper specialized items and triggers used by the Outpost21 map.
// Do not put unique items, structures, or anything else in here. Only variations of existing stuff.

//OBJECTS -------------------------------------------------------
//TODO: Move this to the same file with all the other windows. It shouldn't be in here.
/obj/structure/window/reinforced/polarized/full
	dir = SOUTHWEST
	icon_state = "fwindow"
	maxhealth = 80

/obj/machinery/smartfridge/produce/plantvator
	name = "\improper Smart plantavator - Upper"
	desc = "A refrigerated storage unit for Food and plant storage. With a nice set of hydraulic racks to move items up and down."
	var/obj/machinery/smartfridge/produce/plantvator/attached

/obj/machinery/smartfridge/produce/plantvator/down/Destroy()
	attached = null
	return ..()

/obj/machinery/smartfridge/produce/plantvator/down
	name = "\improper Smart Plantavator - Lower"

/obj/machinery/smartfridge/produce/plantvator/down/Initialize()
	. = ..()
	var/obj/machinery/smartfridge/produce/plantvator/above = locate(/obj/machinery/smartfridge/produce/plantvator,get_zstep(src,UP))
	if(istype(above))
		above.attached = src
		attached = above
		item_records = attached.item_records
	else
		to_chat(world, span_danger("[src] at [x],[y],[z] cannot find the unit above it!"))

//"Red" Armory Door
/obj/machinery/door/airlock/multi_tile/metal/red
	name = "Red Armory"
	//color = ""

/obj/machinery/door/airlock/multi_tile/metal/red/allowed(mob/user)
	if(get_security_level() in list("green","blue","yellow",/*"violet","orange"*/)) //OP edit: Violet and Orange alert levels are same status as red.
		return FALSE

	return ..(user)

/obj/machinery/door/airlock/highsecurity/red
	name = "Bridge Holdout Armory"
	desc =  "Only to be opened on Code red or greater."
	req_one_access = list(access_heads)

/obj/machinery/door/airlock/highsecurity/red/allowed(mob/user)
	if(get_security_level() in list("green","yellow"))
		return FALSE

	return ..(user)

//Again, need to be moved to a higher level in the code. These shouldn't be here, these aren't map-specific
/obj/structure/closet/secure_closet/guncabinet/excursion
	name = "expedition weaponry cabinet"
	req_one_access = list(access_explorer,access_brig)

/obj/structure/closet/secure_closet/guncabinet/excursion/New()
	..()
	for(var/i = 1 to 4)
		new /obj/item/gun/energy/locked/frontier(src)
	for(var/i = 1 to 4)
		new /obj/item/gun/energy/locked/frontier/holdout(src)

//Taken from YW, why is this not in the dance pole's file itself? Redundant code, or just their mappers dumb? TODO: Fix.
/obj/structure/dancepole/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(O.is_wrench())
		anchored = !anchored
		playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
		if(anchored)
			to_chat(user, "<font color='blue'>You secure \the [src].</font>")
		else
			to_chat(user, "<font color='blue'>You unsecure \the [src].</font>")

/obj/machinery/computer/security/exploration
	name = "head mounted camera monitor"
	desc = "Used to access the built-in cameras in helmets."
	// icon_state = "syndicam" // Outpost 21 edit - CI wants this fixed
	network = list(NETWORK_EXPLORATION)
	circuit = null
// ELEVATORS --------------------------------------------------------
//These actually DO belong here.

/obj/turbolift_map_holder/muriki/medevator
	icon = 'icons/obj/turbolift_preview_3x3.dmi'
	depth = 3
	lift_size_x = 3
	lift_size_y = 3
	dir = EAST
	name = "Medbay Elevator map placeholder"

	areas_to_use = list(
		/area/turbolift/medibasement,
		/area/turbolift/medical,
		/area/turbolift/mediupper,
		)

/obj/turbolift_map_holder/muriki/secevator
	icon = 'icons/obj/turbolift_preview_3x3.dmi'
	depth = 3
	lift_size_x = 3
	lift_size_y = 3
	dir = NORTH
	name = "Security Elevator map placeholder"

	areas_to_use = list(
		/area/turbolift/secbase,
		/area/turbolift/secmain,
		/area/turbolift/secupper,
		)

/obj/turbolift_map_holder/muriki/civevator
	icon = 'icons/obj/turbolift_preview_3x3.dmi'
	depth = 3
	lift_size_x = 3
	lift_size_y = 3
	dir = SOUTH
	name = "Civilian Elevator map placeholder"

	areas_to_use = list(
		/area/turbolift/civbase,
		/area/turbolift/civmain,
		/area/turbolift/civupper,
		)

/obj/turbolift_map_holder/muriki/scievator
	icon = 'icons/obj/turbolift_preview_3x3.dmi'
	depth = 3
	lift_size_x = 3
	lift_size_y = 3
	dir = SOUTH
	name = "Science Elevator map placeholder"

	areas_to_use = list(
		/area/turbolift/scibase,
		/area/turbolift/scimain,
		/area/turbolift/sciupper,
		)


//DATUMS -------------------------------------------------------------
/datum/turbolift
	music = list('modular_outpost/sound/music/elevator2.ogg')


//EFFECTS AND TRIGGERS -----------------------------------------
/obj/effect/landmark/map_data/muriki
    height = 4 //Height marker. Provides the map with knowledge of how many z levels connecting below.


//These 'lost in space' ones should be moved to a higher level file, not map specific. Taken from YW
/obj/effect/step_trigger/lost_in_space
	var/deathmessage = "You drift off into space, floating alone in the void until your life support runs out."

/obj/effect/step_trigger/lost_in_space/Trigger(var/atom/movable/A) //replacement for shuttle dump zones because there's no empty space levels to dump to
	if(ismob(A))
		to_chat(A, span_danger(deathmessage))
	qdel(A)

/obj/effect/step_trigger/lost_in_space/bluespace
	deathmessage = "Everything goes blue as your component particles are scattered throughout the known and unknown universe."
	var/last_sound = 0

/obj/effect/step_trigger/lost_in_space/bluespace/Trigger(A)
	if(world.time - last_sound > 5 SECONDS)
		last_sound = world.time
		playsound(get_turf(src), 'sound/effects/supermatter.ogg', 75, 1)
	if(ismob(A) && prob(5))//lucky day
		var/destturf = locate(rand(5,world.maxx-5),rand(5,world.maxy-5),pick(using_map.event_levels))
		new /datum/teleport/instant(A, destturf, 0, 1, null, null, null, 'sound/effects/phasein.ogg')
	else
		return ..()

// Just incase? I can't see these being used much.
// Invisible object that blocks z transfer to/from its turf and the turf above.
/obj/effect/ceiling
	invisibility = 101 // nope cant see this
	anchored = 1
	can_atmos_pass = ATMOS_PASS_PROC

/obj/effect/ceiling/CanZASPass(turf/T, is_zone)
	if(T == GetAbove(src))
		return FALSE // Keep your air up there, buddy
	return TRUE

/obj/effect/ceiling/CanPass(atom/movable/mover, turf/target)
	if(target == GetAbove(src))
		return FALSE
	return TRUE

/obj/effect/ceiling/Uncross(atom/movable/mover, turf/target)
	if(target == GetAbove(src))
		return FALSE
	return TRUE


//OTHER AKA: Everything else. --------------------------------------
// ### Wall Machines On Full Windows ###
// To make sure wall-mounted machines placed on full-tile windows are clickable they must be above the window
// OP edit: This should be moved >:V put it in the window file or something.
/obj/item/radio/intercom
	layer = ABOVE_WINDOW_LAYER
/obj/item/storage/secure/safe
	layer = ABOVE_WINDOW_LAYER
/obj/machinery/airlock_sensor
	layer = ABOVE_WINDOW_LAYER
/obj/machinery/alarm
	layer = ABOVE_WINDOW_LAYER
/obj/machinery/button
	layer = ABOVE_WINDOW_LAYER
/obj/machinery/access_button
	layer = ABOVE_WINDOW_LAYER
/obj/machinery/computer/guestpass
	layer = ABOVE_WINDOW_LAYER
/obj/machinery/computer/security/telescreen
	layer = ABOVE_WINDOW_LAYER
/obj/machinery/door_timer
	layer = ABOVE_WINDOW_LAYER
/obj/machinery/embedded_controller
	layer = ABOVE_WINDOW_LAYER
/obj/machinery/firealarm
	layer = ABOVE_WINDOW_LAYER
/obj/machinery/flasher
	layer = ABOVE_WINDOW_LAYER
/obj/machinery/keycard_auth
	layer = ABOVE_WINDOW_LAYER
/obj/machinery/light_switch
	layer = ABOVE_WINDOW_LAYER
/obj/machinery/mineral/processing_unit_console
	layer = ABOVE_WINDOW_LAYER
/obj/machinery/mineral/stacking_unit_console
	layer = ABOVE_WINDOW_LAYER
/obj/machinery/newscaster
	layer = ABOVE_WINDOW_LAYER
/obj/machinery/power/apc
	layer = ABOVE_WINDOW_LAYER
/obj/machinery/requests_console
	layer = ABOVE_WINDOW_LAYER
/obj/machinery/status_display
	layer = ABOVE_WINDOW_LAYER
/obj/machinery/vending/wallmed1
	layer = ABOVE_WINDOW_LAYER
/obj/machinery/vending/wallmed2
	layer = ABOVE_WINDOW_LAYER
/obj/structure/closet/fireaxecabinet
	layer = ABOVE_WINDOW_LAYER
/obj/structure/extinguisher_cabinet
	layer = ABOVE_WINDOW_LAYER
/obj/structure/mirror
	layer = ABOVE_WINDOW_LAYER
/obj/structure/noticeboard
	layer = ABOVE_WINDOW_LAYER


//I know this should be somewhere else but I can't think of where to put it right now. I'll move it later. Todo
/obj/item/paper/armorguide
	name = "Guide to Armor Choice"
	desc = "Also titled: how to not die to a spider, and become slightly more robust."
	info = "TEST"


// Showcase structures
/obj/structure/showcase/muriki
	name = "Elevator Gravity Assist"
	icon = 'icons/obj/machines/gravity_generator.dmi'
	icon_state = "on_8"
	desc = "A massive, specialized machine for assisting an even more massive freight elevator in its ascent."

/obj/structure/showcase/muriki/plaque //op edit
	name = "Commerative Plaque"
	icon = 'modular_outpost/icons/obj/structures_32x32.dmi'
	icon_state = "plaque"
	desc = "A plaque commerating the finalization of the Outpost 21 terraforming station. Site of a future paradise world."
	density = 0

/obj/structure/showcase/sign/enzyme
	name = "WARNING: ENZYMATIC ATMOSPHERE"
	icon = 'modular_outpost/icons/obj/stationobjs.dmi'
	icon_state = "enzyme"
	desc = "The sign states: 'This planet is undergoing intense terraforming. As a result, the atmosphere outside is acidic, enzymatic, and highly fatal. You will be painfully digested outside without proper protection!'"




//Freezable Airlock Door
/obj/machinery/door/airlock/glass_external/freezable
	maxhealth = 600
	var/frozen = 0
	var/freezing = 0 //see process().
	var/deiceTools[0]
	var/nextWeatherCheck

/obj/machinery/door/airlock/glass_external/freezable/New()
	//Associate objects with the number of seconds it would take to de-ice a door.
	//Most items are either more or less effecient at it.
	//For items with very specific cases (like welders using fuel, or needing to be on) see attackby().
	deiceTools[/obj/item/tool/crowbar/brace_jack] = 3 // OUR version of an Ice Pick
	deiceTools[/obj/item/tool/crowbar] = 5 //Crowbar
	deiceTools[/obj/item/pen] = 30 //Pen
	deiceTools[/obj/item/card] = 35 //Cards. (Mostly ID cards)

	//Generic weapon items. Tools are better then weapons.
	//This is for preventing "Sierra" syndrome that could result from needing very specific objects.
	deiceTools[/obj/item/tool] = 10
	deiceTools[/obj/item] = 12
	..()

/obj/machinery/door/airlock/glass_external/freezable/attackby(obj/item/I, mob/user as mob)
	//Special cases for tools that need more then just a type check.
	var/welderTime = 5 //Welder

	//debug
	//message_admins("[user] has used \the [I] of type [I.type] on [src]", R_DEBUG)

	if(frozen)

		//the welding tool is a special snowflake.
		if(istype(I, /obj/item/weldingtool))
			var/obj/item/weldingtool/welder = I
			if(welder.remove_fuel(0,user) && welder && welder.isOn())
				to_chat(user, span_notice("You start to melt the ice off \the [src]"))
				playsound(src, welder.usesound, 50, 1)
				if(do_after(user, welderTime SECONDS))
					to_chat(user, span_notice("You finish melting the ice off \the [src]"))
					unFreeze()
					return

		if(istype(I, /obj/item/pen/crayon))
			to_chat(user, span_notice("You try to use \the [I] to clear the ice, but it crumbles away!"))
			qdel(I)
			return

		//Most items will be checked in this for loop using the list in New().
		//Code for objects with specific checks (Like the welder) should be inserted above.
		for(var/IT in deiceTools)
			if(istype(I, IT))
				handleRemoveIce(I, user, deiceTools[IT])
				return

		//if we can't de-ice the door tell them what's wrong.
		to_chat(user, span_notice("\the [src] is frozen shut!"))
		return
	..()

/obj/machinery/door/airlock/glass_external/freezable/proc/handleRemoveIce(obj/item/W as obj, mob/user as mob, var/time = 15 as num)
	to_chat(user, span_notice("You start to chip at the ice covering \the [src]"))
	if(do_after(user, text2num(time SECONDS)))
		unFreeze()
		to_chat(user, span_notice("You finish chipping the ice off \the [src]"))

/obj/machinery/door/airlock/glass_external/freezable/proc/unFreeze()
	frozen = 0
	update_icon()
	return

/obj/machinery/door/airlock/glass_external/freezable/proc/freeze()
	frozen = 1
	update_icon()
	return

/obj/machinery/door/airlock/glass_external/freezable/update_icon()
	..()
	if(frozen)
		overlays += image(icon = 'icons/turf/overlays.dmi', icon_state = "snowairlock")
	return

/obj/machinery/door/airlock/glass_external/freezable/proc/handleFreezeUnfreeze()
	var/planet_temp = T20C
	var/turf/T = get_turf(src)
	var/datum/planet/P = SSplanets.z_to_planet[T.z]
	if(P)
		planet_temp = P.weather_holder.temperature
	if(planet_temp < 261.15) // -12c
		if(!frozen && density && prob(planet_temp < 253.15 ? 40 : 5)) // if under -20, way higher chance to freeze
			freeze()
	else if(planet_temp > T0C) // Above 0 to have any chance at unfreezing
		if(frozen && prob(10))
			unFreeze()
	return
/obj/machinery/door/airlock/glass_external/freezable/process()
	if(world.time >= nextWeatherCheck && !freezing)  //don't do the thing if i'm already doing it.
		freezing = 1
		var/random = rand(2,7)
		nextWeatherCheck = (world.time + ((random + 13) SECONDS))
		handleFreezeUnfreeze()
		freezing = 0
	..()

/obj/machinery/door/airlock/glass_external/freezable/examine(mob/user)
	. = ..()
	if(frozen)
		to_chat(user, "it's frozen shut!")

/obj/machinery/door/airlock/glass_external/freezable/open(var/forced = 0)
	//Frozen airlocks can't open.
	if(frozen && !forced)
		return
	else if(frozen && forced)
		unFreeze()
		return ..()
	else
		..()

/obj/machinery/door/airlock/glass_external/freezable/close(var/forced = 0)
	//Frozen airlocks can't shut either. (Though they shouldn't be able to freeze open)
	if(frozen && !forced)
		return
	else if(frozen && forced)
		unFreeze()
		return ..()
	else
		..()
//end of freezable airlock stuff.
