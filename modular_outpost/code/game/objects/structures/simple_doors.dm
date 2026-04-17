/obj/structure/simple_door/steel

/obj/structure/simple_door/steel/Initialize(mapload,var/material_name)
	. = ..(mapload, material_name || MAT_STEEL)

/obj/structure/simple_door/marble

/obj/structure/simple_door/marble/Initialize(mapload,var/material_name)
	. = ..(mapload, material_name || MAT_MARBLE)
