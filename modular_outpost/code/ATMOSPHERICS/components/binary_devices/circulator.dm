/obj/machinery/atmospherics/binary/circulator
	var/reverse_pipes = FALSE

/obj/machinery/atmospherics/binary/circulator/atmos_init()
	if(node1 && node2)
		return

	var/cur_dur = dir
	if(reverse_pipes)
		cur_dur = turn(dir, 180)
	var/node2_connect = cur_dur
	var/node1_connect = turn(cur_dur, 180)

	STANDARD_ATMOS_CHOOSE_NODE(1, node1_connect)
	STANDARD_ATMOS_CHOOSE_NODE(2, node2_connect)

	update_icon()
	update_underlays()

/obj/machinery/atmospherics/binary/circulator/proc/reverse_circulator()
	reverse_pipes = !reverse_pipes
	if(!anchored)
		return
	// Disconnect and reconnect to pipe network now that we've flipped
	if(node1)
		node1.disconnect(src)
		qdel(network1)
		node1 = null
	if(node2)
		node2.disconnect(src)
		qdel(network2)
		node2 = null
	atmos_init() // handles the swapped directions
	build_network()
	if (node1)
		node1.atmos_init()
		node1.build_network()
	if (node2)
		node2.atmos_init()
		node2.build_network()
	// THUNK
	if(reverse_pipes)
		playsound(loc, 'sound/effects/contactor_on.ogg', 50, FALSE)
	else
		playsound(loc, 'sound/effects/contactor_off.ogg', 50, FALSE)
