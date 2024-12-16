// Additional fire_acts()
/obj/item/stack/material/stick/fire_act()
	if(prob(30))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/stack/material/wood/fire_act()
	if(prob(20))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/stack/material/phoron/fire_act()
	if(prob(80))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/stack/material/plastic/fire_act()
	if(prob(10))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/structure/table/woodentable/fire_act()
	if(prob(10))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/structure/table/gamblingtable
	if(prob(10))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/paper_bin/fire_act()
	if(prob(50))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/paper/fire_act()
	if(prob(80))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.2)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/structure/bed/fire_act()
	if(prob(50))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/soap/fire_act()
	if(prob(10))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/bedsheet/fire_act()
	if(prob(50))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.3)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/book/fire_act()
	if(prob(50))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.2)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/folder/fire_act()
	if(prob(50))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/structure/bookcase/fire_act()
	if(prob(2))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/structure/simple_door/wood/fire_act()
	if(prob(10))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/storage/pill_bottle/fire_act()
	if(prob(20))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

obj/item/instrument/fire_act()
	if(prob(20))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.2)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/storage/fancy/cigar/fire_act()
	if(prob(10))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/assembly/mousetrap/fire_act()
	if(prob(40))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/structure/flora/tree/fire_act()
	if(prob(5))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

obj/structure/flora/pottedplant/fire_act()
	if(prob(5))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.2)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/structure/table/standard/fire_act()
	if(prob(15))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.2)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/storage/box/fire_act()
	if(prob(15))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.2)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/toy/plushie/fire_act()
	if(prob(45))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.5)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/towel/fire_act()
	if(prob(45))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.5)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/juke_remote/fire_act()
	if(prob(8))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/mop/fire_act()
	if(prob(8))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/storage/pouch/fire_act()
	if(prob(8))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/storage/pouch/fire_act()
	if(prob(8))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/storage/backpack/fire_act()
	if(prob(8))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/storage/bag/trash/fire_act()
	if(prob(8))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/trash/fire_act()
	if(prob(30))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/structure/closet/crate/wooden/fire_act()
	if(prob(10))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.5)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/reagent_containers/food/drinks/fire_act()
	if(prob(10))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

obj/item/packageWrap/fire_act()
	if(prob(40))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.1)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/tape_roll/fire_act()
	if(prob(20))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.2)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)





// IT CRIMBO
/obj/structure/sign/christmas/fire_act()
	if(prob(20))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.75)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

// SPECIAL CLOTHING HANDLING
/obj/item/clothing/fire_act()
	if(prob(12))
		var/turf/T = get_turf(src)
		T?.feed_lingering_fire(0.2)
		new /obj/effect/decal/cleanable/ash(get_turf(src))
		ex_act(1)

/obj/item/clothing/suit/fire_act()
	return









/obj/effect/decal/cleanable/ash
	if(prob(4))
		qdel(src) // anti-lag
