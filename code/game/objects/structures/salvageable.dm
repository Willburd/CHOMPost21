/obj/structure/salvageable
	name = "broken machinery"
	desc = "Broken beyond repair, but looks like you can still salvage something from this if you had a prying implement."
	icon = 'icons/obj/salvageable.dmi'
	density = TRUE
	anchored = TRUE
	var/salvageable_parts = list()

/obj/structure/salvageable/proc/dismantle()
	new /obj/structure/frame (src.loc)
	for(var/path in salvageable_parts)
		if(prob(salvageable_parts[path]))
			new path (loc)
	return

/obj/structure/salvageable/attackby(obj/item/I, mob/user)
	if(I.has_tool_quality(TOOL_CROWBAR))
		playsound(src, I.usesound, 50, 1)
		var/actual_time = I.toolspeed * 170
		user.visible_message( \
			span_infoplain(span_bold("\The [user]") + " begins salvaging from \the [src]."), \
			span_notice("You start salvaging from \the [src]."))
		if(do_after(user, actual_time, target = src))
			user.visible_message( \
				span_notice("\The [user] has salvaged \the [src]."), \
				span_notice("You salvage \the [src]."))
			dismantle()
			qdel(src)
			return TRUE
	return ..()

//Types themself, use them, but not the parent object

/obj/structure/salvageable/machine
	name = "broken machine"
	icon_state = "machine1"
	salvageable_parts = list(
		/obj/item/stock_parts/console_screen = 80,
		/obj/item/stack/cable_coil{amount = 5} = 80,
		/obj/item/trash/material/circuit = 60,
		/obj/item/trash/material/metal = 60,
		/obj/item/stock_parts/capacitor = 40,
		/obj/item/stock_parts/capacitor = 40,
		/obj/item/stock_parts/scanning_module = 40,
		/obj/item/stock_parts/scanning_module = 40,
		/obj/item/stock_parts/manipulator = 40,
		/obj/item/stock_parts/manipulator = 40,
		/obj/item/stock_parts/micro_laser = 40,
		/obj/item/stock_parts/micro_laser = 40,
		/obj/item/stock_parts/matter_bin = 40,
		/obj/item/stock_parts/matter_bin = 40,
		/obj/item/stock_parts/capacitor/adv = 20,
		/obj/item/stock_parts/scanning_module/adv = 20,
		/obj/item/stock_parts/manipulator/nano = 20,
		/obj/item/stock_parts/micro_laser/high = 20,
		/obj/item/stock_parts/matter_bin/adv = 20
	)

/obj/structure/salvageable/machine/Initialize(mapload)
	. = ..()
	icon_state = "machine[rand(0,6)]"

/obj/structure/salvageable/computer
	name = "broken computer"
	icon_state = "computer0"
	salvageable_parts = list(
		/obj/item/stock_parts/console_screen = 80,
		/obj/item/stack/cable_coil{amount = 5} = 90,
		/obj/item/stack/material/glass{amount = 5} = 90,
		/obj/item/trash/material/circuit = 60,
		/obj/item/trash/material/metal = 60,
		/obj/item/stock_parts/capacitor = 60,
		/obj/item/stock_parts/capacitor = 60,
		/* Outpost 21 edit - Removed modular computers
		/obj/item/computer_hardware/network_card = 40,
		/obj/item/computer_hardware/network_card = 40,
		/obj/item/computer_hardware/processor_unit = 40,
		/obj/item/computer_hardware/processor_unit = 40,
		/obj/item/computer_hardware/card_slot = 40,
		/obj/item/computer_hardware/card_slot = 40,
		*/
		/obj/item/stock_parts/capacitor/adv = 30
		/* Outpost 21 edit - Removed modular computers
		/obj/item/computer_hardware/network_card/advanced = 20
		*/
	)
/obj/structure/salvageable/computer/Initialize(mapload)
	. = ..()
	icon_state = "computer[rand(0,7)]"

/obj/structure/salvageable/autolathe
	name = "broken autolathe"
	icon_state = "autolathe"
	salvageable_parts = list(
		/obj/item/stock_parts/console_screen = 80,
		/obj/item/stack/cable_coil{amount = 5} = 80,
		/obj/item/trash/material/circuit = 60,
		/obj/item/trash/material/metal = 60,
		/obj/item/stock_parts/capacitor = 40,
		/obj/item/stock_parts/scanning_module = 40,
		/obj/item/stock_parts/manipulator = 40,
		/obj/item/stock_parts/micro_laser = 40,
		/obj/item/stock_parts/micro_laser = 40,
		/obj/item/stock_parts/micro_laser = 40,
		/obj/item/stock_parts/matter_bin = 40,
		/obj/item/stock_parts/matter_bin = 40,
		/obj/item/stock_parts/matter_bin = 40,
		/obj/item/stock_parts/matter_bin = 40,
		/obj/item/stock_parts/capacitor/adv = 20,
		/obj/item/stock_parts/micro_laser/high = 20,
		/obj/item/stock_parts/micro_laser/high = 20,
		/obj/item/stock_parts/matter_bin/adv = 20,
		/obj/item/stock_parts/matter_bin/adv = 20,
		/obj/item/stack/material/steel{amount = 20} = 40,
		/obj/item/stack/material/glass{amount = 20} = 40,
		/obj/item/stack/material/plastic{amount = 20} = 40,
		/obj/item/stack/material/plasteel{amount = 10} = 40,
		/obj/item/stack/material/silver{amount = 10} = 20,
		/obj/item/stack/material/gold{amount = 10} = 20,
		/obj/item/stack/material/phoron{amount = 10} = 20
	)

/obj/structure/salvageable/implant_container
	name = "old container"
	icon_state = "implant_container0"
	salvageable_parts = list(
		/obj/item/stock_parts/console_screen = 80,
		/obj/item/stack/cable_coil{amount = 5} = 80,
		/obj/item/trash/material/circuit = 60,
		/obj/item/trash/material/metal = 60,
		/obj/item/implant/death_alarm = 15,
		/obj/item/implant/explosive = 10,
		/obj/item/implant/freedom = 5,
		/obj/item/implant/tracking = 10,
		/obj/item/implant/chem = 10,
		/obj/item/implantcase = 30,
		/obj/item/implanter = 30,
		/obj/item/stack/material/steel{amount = 10} = 30,
		/obj/item/stack/material/glass{amount = 10} = 30,
		/obj/item/stack/material/silver{amount = 10} = 30
	)

/obj/structure/salvageable/implant_container/Initialize(mapload)
	. = ..()
	icon_state = "implant_container[rand(0,1)]"

/obj/structure/salvageable/data
	name = "broken data storage"
	icon_state = "data0"
	salvageable_parts = list(
		/obj/item/stock_parts/console_screen = 80,
		/obj/item/stack/cable_coil{amount = 5} = 90,
		/obj/item/stack/material/glass{amount = 5} = 90,
		/obj/item/trash/material/circuit = 60,
		/obj/item/trash/material/metal = 60
		/* Outpost 21 edit - Removed modular computers
		/obj/item/computer_hardware/network_card = 40,
		/obj/item/computer_hardware/network_card = 40,
		/obj/item/computer_hardware/processor_unit = 40,
		/obj/item/computer_hardware/processor_unit = 40,
		/obj/item/computer_hardware/hard_drive = 50,
		/obj/item/computer_hardware/hard_drive = 50,
		/obj/item/computer_hardware/hard_drive = 50,
		/obj/item/computer_hardware/hard_drive = 50,
		/obj/item/computer_hardware/hard_drive = 50,
		/obj/item/computer_hardware/hard_drive = 50,
		/obj/item/computer_hardware/hard_drive/advanced = 30,
		/obj/item/computer_hardware/hard_drive/advanced = 30,
		/obj/item/computer_hardware/network_card/advanced = 20
		*/
	)

/obj/structure/salvageable/data/Initialize(mapload)
	. = ..()
	icon_state = "data[rand(0,1)]"

/obj/structure/salvageable/server
	name = "broken server"
	icon_state = "server0"
	salvageable_parts = list(
		/obj/item/stock_parts/console_screen = 80,
		/obj/item/stack/cable_coil{amount = 5} = 90,
		/obj/item/stack/material/glass{amount = 5} = 90,
		/obj/item/trash/material/circuit = 60,
		/obj/item/trash/material/metal = 60,
		/* Outpost 21 edit - Removed modular computers
		/obj/item/computer_hardware/network_card = 40,
		/obj/item/computer_hardware/network_card = 40,
		/obj/item/computer_hardware/processor_unit = 40,
		/obj/item/computer_hardware/processor_unit = 40,
		*/
		/obj/item/stock_parts/subspace/amplifier = 40,
		/obj/item/stock_parts/subspace/amplifier = 40,
		/obj/item/stock_parts/subspace/analyzer = 40,
		/obj/item/stock_parts/subspace/analyzer = 40,
		/obj/item/stock_parts/subspace/ansible = 40,
		/obj/item/stock_parts/subspace/ansible = 40,
		/obj/item/stock_parts/subspace/transmitter = 40,
		/obj/item/stock_parts/subspace/transmitter = 40,
		/obj/item/stock_parts/subspace/crystal = 30,
		/obj/item/stock_parts/subspace/crystal = 30
		/* Outpost 21 edit - Removed modular computers
		/obj/item/computer_hardware/network_card/advanced = 20
		*/
	)

/obj/structure/salvageable/server/Initialize(mapload)
	. = ..()
	icon_state = "server[rand(0,1)]"

/obj/structure/salvageable/personal
	name = "personal terminal"
	icon_state = "personal0"
	salvageable_parts = list(
		/obj/item/stock_parts/console_screen = 90,
		/obj/item/stack/cable_coil{amount = 5} = 90,
		/obj/item/stack/material/glass{amount = 5} = 70,
		/obj/item/trash/material/circuit = 60,
		/obj/item/trash/material/metal = 60
		/* Outpost 21 edit - Removed modular computers
		/obj/item/computer_hardware/network_card = 60,
		/obj/item/computer_hardware/network_card/advanced = 40,
		/obj/item/computer_hardware/network_card/wired = 40,
		/obj/item/computer_hardware/card_slot = 40,
		/obj/item/computer_hardware/processor_unit = 60,
		/obj/item/computer_hardware/processor_unit/small = 50,
		/obj/item/computer_hardware/processor_unit/photonic = 40,
		/obj/item/computer_hardware/processor_unit/photonic/small = 30,
		/obj/item/computer_hardware/hard_drive = 60,
		/obj/item/computer_hardware/hard_drive/advanced = 40
		*/
	)

/obj/structure/salvageable/personal/Initialize(mapload)
	. = ..()
	icon_state = "personal[rand(0,12)]"
	new /obj/structure/table/reinforced (loc)

/obj/structure/salvageable/bliss
	name = "strange terminal"
	icon_state = "bliss0"
	salvageable_parts = list(
		/obj/item/stock_parts/console_screen = 90,
		/obj/item/stack/cable_coil{amount = 5} = 90
		/* Outpost 21 edit - Removed modular computers
		/obj/item/computer_hardware/processor_unit/photonic = 60,
		/obj/item/computer_hardware/hard_drive/cluster = 50
		*/
	)

/obj/structure/salvageable/bliss/Initialize(mapload)
	. = ..()
	icon_state = "bliss[rand(0,1)]"

/obj/structure/salvageable/bliss/attackby(obj/item/I, mob/user)
	if((. = ..()))
		playsound(src, 'sound/machines/shutdown.ogg', 60, 1)

///////////////////
//// COMPUTERS ////
///////////////////

/obj/structure/salvageable/console
	name = "console"
	icon_state = "console0"
	salvageable_parts = list(
		/obj/item/stack/cable_coil{amount = 5} = 90,
		/obj/item/stack/material/glass{amount = 5} = 70,
		/obj/item/trash/material/circuit = 60,
		/obj/item/trash/material/metal = 60,
		/obj/item/stock_parts/capacitor = 40,
		/obj/item/stock_parts/capacitor = 40,
		/obj/item/stock_parts/scanning_module = 40,
		/obj/item/stock_parts/scanning_module = 40
	)

/obj/structure/salvageable/personal/Initialize(mapload)
	. = ..()
	icon_state = "console[rand(0,2)]"

/obj/structure/salvageable/shuttle_console
	name = "shuttle console"
	icon_state = "shuttle"
	salvageable_parts = list(
		/obj/item/stack/cable_coil{amount = 5} = 90,
		/obj/item/stack/material/glass{amount = 5} = 70,
		/obj/item/trash/material/circuit = 60,
		/obj/item/trash/material/metal = 60,
		/obj/item/stock_parts/capacitor = 40,
		/obj/item/stock_parts/capacitor = 40,
		/obj/item/stock_parts/scanning_module = 40,
		/obj/item/stock_parts/scanning_module = 40
	)

//////////////////
//// ONE STAR ////
//////////////////

/obj/structure/salvageable/machine_os
	name = "broken machine"
	icon_state = "os-machine"
	salvageable_parts = list(
		/obj/item/stock_parts/console_screen = 80,
		/obj/item/stack/cable_coil{amount = 5} = 80,
		/obj/item/stock_parts/capacitor = 40,
		/obj/item/stock_parts/capacitor = 40,
		/obj/item/stock_parts/scanning_module = 40,
		/obj/item/stock_parts/scanning_module = 40,
		/obj/item/stock_parts/manipulator = 40,
		/obj/item/stock_parts/manipulator = 40,
		/obj/item/stock_parts/micro_laser = 40,
		/obj/item/stock_parts/micro_laser = 40,
		/obj/item/stock_parts/matter_bin = 40,
		/obj/item/stock_parts/matter_bin = 40
	)

/obj/structure/salvageable/computer_os
	name = "broken computer"
	icon_state = "os-computer"
	salvageable_parts = list(
		/obj/item/stock_parts/console_screen = 80,
		/obj/item/stack/cable_coil{amount = 5} = 90,
		/obj/item/stack/material/glass{amount = 5} = 90,
		/obj/item/stock_parts/capacitor = 60,
		/obj/item/stock_parts/capacitor = 60
		/* Outpost 21 edit - Removed modular computers
		/obj/item/computer_hardware/processor_unit/photonic = 40,
		/obj/item/computer_hardware/processor_unit/photonic = 40,
		/obj/item/computer_hardware/card_slot = 40,
		/obj/item/computer_hardware/card_slot = 40,
		/obj/item/computer_hardware/network_card/advanced = 40
		*/
	)

/obj/structure/salvageable/implant_container_os
	name = "old container"
	icon_state = "os-container"
	salvageable_parts = list(
		/obj/item/stock_parts/console_screen = 80,
		/obj/item/stack/cable_coil{amount = 5} = 80,
		/obj/item/implant/death_alarm = 30,
		/obj/item/implant/explosive = 20,
		/obj/item/implant/freedom = 20,
		/obj/item/implant/tracking = 30,
		/obj/item/implant/chem = 30,
		/obj/item/implantcase = 30,
		/obj/item/implanter = 30
	)

/obj/structure/salvageable/data_os
	name = "broken data storage"
	icon_state = "os-data"
	salvageable_parts = list(
		/obj/item/stock_parts/console_screen = 90,
		/obj/item/stack/cable_coil{amount = 5} = 90,
		/obj/item/stack/material/glass{amount = 5} = 90
		/* Outpost 21 edit - Removed modular computers
		/obj/item/computer_hardware/processor_unit/small = 60,
		/obj/item/computer_hardware/processor_unit/photonic = 50,
		/obj/item/computer_hardware/hard_drive/super = 50,
		/obj/item/computer_hardware/hard_drive/super = 50,
		/obj/item/computer_hardware/hard_drive/cluster = 50,
		/obj/item/computer_hardware/network_card/wired = 40
		*/
	)

/obj/structure/salvageable/server_os
	name = "broken server"
	icon_state = "os-server"
	salvageable_parts = list(
		/obj/item/stock_parts/console_screen = 80,
		/obj/item/stack/cable_coil{amount = 5} = 90,
		/obj/item/stack/material/glass{amount = 5} = 90,
		/* Outpost 21 edit - Removed modular computers
		/obj/item/computer_hardware/network_card/wired = 40,
		/obj/item/computer_hardware/network_card/wired = 40,
		/obj/item/computer_hardware/processor_unit = 40,
		/obj/item/computer_hardware/processor_unit/photonic = 40,
		*/
		/obj/item/stock_parts/subspace/amplifier = 40,
		/obj/item/stock_parts/subspace/amplifier = 40,
		/obj/item/stock_parts/subspace/analyzer = 40,
		/obj/item/stock_parts/subspace/analyzer = 40,
		/obj/item/stock_parts/subspace/ansible = 40,
		/obj/item/stock_parts/subspace/ansible = 40,
		/obj/item/stock_parts/subspace/transmitter = 40,
		/obj/item/stock_parts/subspace/transmitter = 40,
		/obj/item/stock_parts/subspace/crystal = 30,
		/obj/item/stock_parts/subspace/crystal = 30
		/* Outpost 21 edit - Removed modular computers
		/obj/item/computer_hardware/network_card/wired = 20
		*/
	)

/obj/structure/salvageable/console_os
	name = "pristine console"
	desc = "Despite being in pristine condition this console doesn't respond to anything, but looks like you can still salvage something from this."
	icon_state = "os_console"
	salvageable_parts = list(
		/obj/item/stack/cable_coil{amount = 5} = 90,
		/obj/item/stock_parts/console_screen = 80,
		/obj/item/stock_parts/capacitor = 60,
		/obj/item/stock_parts/capacitor = 60
		/* Outpost 21 edit - Removed modular computers
		/obj/item/computer_hardware/processor_unit/small = 40,
		/obj/item/computer_hardware/processor_unit/photonic = 40,
		/obj/item/computer_hardware/card_slot = 40,
		/obj/item/computer_hardware/card_slot = 40,
		/obj/item/computer_hardware/network_card/advanced = 40
		*/
	)

/obj/structure/salvageable/console_broken_os
	name = "broken console"
	icon_state = "os_console_broken"
	salvageable_parts = list(
		/obj/item/stack/cable_coil{amount = 5} = 90,
		/obj/item/stock_parts/console_screen = 80,
		/obj/item/stock_parts/capacitor = 60,
		/obj/item/stock_parts/capacitor = 60
		/* Outpost 21 edit - Removed modular computers
		/obj/item/computer_hardware/processor_unit = 40,
		/obj/item/computer_hardware/processor_unit/photonic = 40,
		/obj/item/computer_hardware/card_slot = 40,
		/obj/item/computer_hardware/card_slot = 40,
		/obj/item/computer_hardware/network_card/advanced = 40
		*/
	)

/obj/structure/salvageable/slotmachine1
	name = "broken slot machine"
	icon_state = "slot1"
	salvageable_parts = list(
		/obj/item/stack/cable_coil{amount = 5} = 90,
		/obj/item/stock_parts/console_screen = 90,
		/obj/item/stack/cable_coil{amount = 5} = 90,
		/obj/item/stack/material/glass{amount = 5} = 90,
		/obj/item/stock_parts/capacitor = 60,
		/obj/item/stock_parts/capacitor = 60
		/* Outpost 21 edit - Removed modular computers
		/obj/item/computer_hardware/network_card/advanced = 40
		*/
	)

/obj/structure/salvageable/slotmachine2
	name = "broken slot machine"
	icon_state = "slot2"
	salvageable_parts = list(
		/obj/item/stack/cable_coil{amount = 5} = 90,
		/obj/item/stock_parts/console_screen = 90,
		/obj/item/stack/cable_coil{amount = 5} = 90,
		/obj/item/stack/material/glass{amount = 5} = 90,
		/obj/item/stock_parts/capacitor = 60,
		/obj/item/stock_parts/capacitor = 60
		/* Outpost 21 edit - Removed modular computers
		/obj/item/computer_hardware/network_card/advanced = 40
		*/
	)
