/obj/item/device/juke_remote
	var/area/autolinkareajuke_onspawn = null // mostly for the radiohost

/obj/item/device/juke_remote/Initialize()
	return INITIALIZE_HINT_LATELOAD

/obj/item/device/juke_remote/LateInitialize()
	// autopair if uses a area link
	if(!isnull(autolinkareajuke_onspawn))
		for(var/obj/machinery/M in global.machines)
			if(istype(M,/obj/machinery/media/jukebox) && istype( get_area(M.loc), autolinkareajuke_onspawn))
				pair_juke( M, null)
				unanchor()
				anchor()
				name = "\improper BoomTown cordless micro speaker"
				icon = 'icons/obj/device_op.dmi' // Use smaller icon. kinda hacky, but I'd rather not make this a whole new object.
				break
	return ..()