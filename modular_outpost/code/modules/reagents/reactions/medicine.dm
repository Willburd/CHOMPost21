// Allow making burnpacks
/datum/reagent/dermaline/topical/touch_obj(obj/O)
	..()
	if(istype(O, /obj/item/stack/medical) && round(volume) >= 1)
		var/obj/item/stack/medical/C = O
		if(C.upgrade_to != /obj/item/stack/medical/advanced/bruise_pack)
			return

		var/packname = C.name
		var/to_produce = min(C.get_amount(), round(volume))

		C.upgrade_to = /obj/item/stack/medical/advanced/ointment // Hack to do this
		var/obj/item/stack/medical/M = C.upgrade_stack(to_produce)
		C.upgrade_to = /obj/item/stack/medical/advanced/bruise_pack // Restore it for future checks

		if(M && M.get_amount())
			holder.my_atom.visible_message(span_infoplain(span_bold("\The [packname]") + " bubbles."))
			remove_self(to_produce)
