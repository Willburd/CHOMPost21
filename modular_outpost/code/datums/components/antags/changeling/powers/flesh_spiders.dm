/datum/power/changeling/fleshmend
	name = "Fleshspiders"
	desc = "Releases a flesh spiderling. While young they can crawl through vents. Can be used while dead."
	helptext = "A good distraction. Can be used while dead."
	enhancedtext = "Increases number of spiders."
	ability_icon_state = "ling_fleshspiders"
	genomecost = 2
	verbpath = /mob/proc/changeling_fleshspiders

//Starts healing you every second for 50 seconds. Can be used whilst unconscious.
/mob/proc/changeling_fleshspiders()
	set category = "Changeling"
	set name = "Fleshspiders (20)"
	set desc = "Releases a flesh spiderling. While young they can crawl through vents. Can be used while dead."

	var/datum/component/antag/changeling/changeling = changeling_power(20,0,100,DEAD)
	if(!changeling)
		return FALSE
	if(!isturf(loc))
		to_chat(src, span_warning("We have no room to release it!"))
		return FALSE

	changeling.chem_charges -= 20
	if(changeling.recursive_enhancement)
		new /obj/effect/spider/spiderling/flesh(get_turf(src))
	new /obj/effect/spider/spiderling/flesh(get_turf(src))

	feedback_add_details("changeling_powers","FS")
	return TRUE
