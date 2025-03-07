/datum/power/changeling/cryo_sting
	name = "Cryogenic Sting"
	desc = "We silently sting a biological with a cocktail of chemicals that freeze them."
	helptext = "Does not provide a warning to the victim, though they will likely realize they are suddenly freezing.  Has \
	a three minute cooldown between uses."
	enhancedtext = "Increases the amount of chemicals injected."
	ability_icon_state = "ling_sting_cryo"
	genomecost = 1
	verbpath = /mob/proc/changeling_cryo_sting

/mob/proc/changeling_cryo_sting()
	set category = "Changeling"
	set name = "Cryogenic Sting (20)"
	set desc = "Chills and freezes a biological creature."

	var/mob/living/carbon/T = changeling_sting(20,/mob/proc/changeling_cryo_sting)
	if(!T)
		return 0
	add_attack_logs(src,T,"Cryo sting (changeling)")
	var/inject_amount = 10
	if(src.mind.changeling.recursive_enhancement)
		inject_amount = inject_amount * 1.5
		to_chat(src, span_notice("We inject extra chemicals."))
	if(T.reagents)
		T.reagents.add_reagent(REAGENT_ID_CRYOTOXIN, inject_amount)
	feedback_add_details("changeling_powers","CS")
	remove_verb(src, /mob/proc/changeling_cryo_sting)
	spawn(3 MINUTES)
		to_chat(src, span_notice("Our cryogenic string is ready to be used once more."))
		add_verb(src, /mob/proc/changeling_cryo_sting)
	return 1
