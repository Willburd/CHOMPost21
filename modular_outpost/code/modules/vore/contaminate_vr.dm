//Contaminate IDs inside of PDAs
/obj/item/pda/gurgle_contaminate(atom/movable/item_storage = null, contamination_flavor = "Generic", contamination_color = "green", obj/belly/contamination_source = null)
	if(id)
		id.gurgle_contaminate(item_storage, contamination_flavor, contamination_color, contamination_source)
	return FALSE
