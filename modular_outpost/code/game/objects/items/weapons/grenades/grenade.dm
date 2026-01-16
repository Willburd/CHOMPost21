/// Adminbus, planned for mapping, but it would result in horrible active edges in unit test. so mostly for aghost smiting.
/obj/item/grenade/concussion/primed/Initialize(mapload)
	. = ..()
	det_time = 5 SECONDS
	if(!mapload)
		activate(null)

/obj/item/grenade/empgrenade/primed/Initialize(mapload)
	. = ..()
	det_time = 5 SECONDS
	if(!mapload)
		activate(null)

/obj/item/grenade/explosive/frag/primed/Initialize(mapload)
	. = ..()
	det_time = 5 SECONDS
	if(!mapload)
		activate(null)

/obj/item/grenade/flashbang/primed/Initialize(mapload)
	. = ..()
	det_time = 5 SECONDS
	if(!mapload)
		activate(null)

/obj/item/grenade/supermatter/primed/Initialize(mapload)
	. = ..()
	det_time = 5 SECONDS
	if(!mapload)
		activate(null)

/obj/item/grenade/chem_grenade/incendiary/primed/Initialize(mapload)
	. = ..()
	det_time = 5 SECONDS
	if(!mapload)
		activate(null)

/obj/item/grenade/chem_grenade/metalfoam/primed/Initialize(mapload)
	. = ..()
	det_time = 5 SECONDS
	if(!mapload)
		activate(null)

/obj/item/grenade/dephasing/primed/Initialize(mapload)
	. = ..()
	det_time = 5 SECONDS
	if(!mapload)
		activate(null)
