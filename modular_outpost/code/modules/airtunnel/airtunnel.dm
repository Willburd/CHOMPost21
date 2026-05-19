/obj/structure/airtunnel
	name = "airtunnel"
	icon = 'modular_outpost/icons/obj/airtunnel/airtunnel.dmi'
	icon_state = "floor"
	var/deployed = FALSE
	var/obj/structure/airtunnel/next = null
	var/obj/structure/airtunnel/previous = null
	var/area/airtunnel/master = null

/obj/structure/airtunnel/process()
	if(!deployed)
		return
	. = ..()

/obj/structure/airtunnel/proc/relocate(direction_to_expand)
	var/turf/direction_turf = get_step(src, direction_to_expand)
	for(var/atom/movable/A in contents)
		A.forceMove(direction_turf)

/obj/structure/airtunnel/proc/move_left()
	relocate(WEST)
	if ((next && next.deployed))
		return next.move_left()
	return next

/obj/structure/airtunnel/proc/move_right()
	relocate(EAST)
	if ((previous && previous.deployed))
		previous.move_right()
	return previous

/obj/structure/airtunnel/proc/create(num, y_coord)

	if (y_coord == 72)
		if ((num < 7 || (num > 14 && num < 21)))
			next = new /obj/structure/airtunnel( null )
		else
			next = new /obj/structure/airtunnel/wall( null )
	else
		next = new /obj/structure/airtunnel( null )
	next.master = master
	next.previous = src
	if (num > 1)
		spawn( 0 )
			next.create(num - 1, y_coord)


///////////////////////////////////////////////////////////////////////////////////
// Wall
///////////////////////////////////////////////////////////////////////////////////
/obj/structure/airtunnel/wall
	name = "wall"
	icon_state = "wall"
	opacity = 1
	density = 1
	can_atmos_pass = ATMOS_PASS_NO

/obj/structure/airtunnel/connector/wall/create()

	current = src
	next = new /obj/structure/airtunnel/wall( null )
	next.master = master
	next.previous = src
	spawn( 0 )
		next.create(36, y)

/obj/structure/airtunnel/wall/create(num, y_coord)

	if (((num < 7 || (num > 14 && num < 21)) && y_coord == 72))
		next = new /obj/structure/airtunnel( null )
	else
		next = new /obj/structure/airtunnel/wall( null )

	next.master = master
	next.previous = src
	if (num > 1)
		spawn( 0 )
			next.create(num - 1, y_coord)

/obj/structure/airtunnel/wall/move_right()
	flick("wall-m", src)
	. = ..()

/obj/structure/airtunnel/wall/move_left()
	flick("wall-m", src)
	. = ..()

/obj/structure/airtunnel/wall/process()
	return PROCESS_KILL


///////////////////////////////////////////////////////////////////////////////////
// Connector
///////////////////////////////////////////////////////////////////////////////////
/obj/structure/airtunnel/connector
	name = "connector"
	icon_state = "floor-c"
	var/obj/structure/airtunnel/current = null
	deployed = TRUE

/obj/structure/airtunnel/connector/wall
	name = "wall"
	icon_state = "wall-c"
	opacity = 1
	density = 1
	can_atmos_pass = ATMOS_PASS_NO

/obj/structure/airtunnel/connector/create()

	current = src
	next = new /obj/structure/airtunnel( null )
	next.master = master
	next.previous = src
	spawn( 0 )
		next.create(36, y)
		return
	return

/obj/structure/airtunnel/connector/wall/process()
	return PROCESS_KILL
