/datum/power/changeling/rapid_regen
	name = "Rapid Regeneration"
	desc = "We quickly heal ourselves, removing most advanced injuries, at a high chemical cost."
	helptext = "This will heal a significant amount of brute, fire, oxy, clone, and brain damage, and heal broken bones, internal bleeding, low blood, \
	and organ damage.  The process is fast, but anyone who sees us do this will likely realize we are not what we seem."
	enhancedtext = "Healing increased to heal up to maximum health."
	ability_icon_state = "ling_rapid_regeneration"
	genomecost = 2
	verbpath = /mob/proc/changeling_rapid_regen

//Gives a big heal, removing various injuries that might shut down normal people, like IB or fractures.
/mob/proc/changeling_rapid_regen()
	set category = "Changeling"
	set name = "Rapid Regeneration (50)"
	set desc = "Heal ourselves of most injuries instantly."

	var/datum/component/antag/changeling/changeling = changeling_power(50,0,100,UNCONSCIOUS)
	if(!changeling)
		return 0
	changeling.chem_charges -= 50

	if(ishuman(src))
		var/mob/living/carbon/human/C = src
		var/healing_amount = 40
		if(changeling.recursive_enhancement)
			healing_amount = C.getMaxHealth()
			to_chat(src, span_notice("We completely heal ourselves."))
		spawn(0)
			C.adjustBruteLoss(-healing_amount)
			C.adjustFireLoss(-healing_amount)
			C.adjustOxyLoss(-healing_amount)
			C.adjustCloneLoss(-healing_amount)
			C.adjustBrainLoss(-healing_amount)
			C.restore_blood()
			C.species.create_organs(C)
			C.restore_all_organs()
			C.blinded = 0
			C.SetBlinded(0)
			C.eye_blurry = 0
			C.ear_deaf = 0
			C.ear_damage = 0

			// make the icons look correct
			C.regenerate_icons()
			C.UpdateAppearance()

			// now make it obvious that we're not human (or whatever xeno race they are impersonating)
			playsound(src, 'sound/effects/blobattack.ogg', 30, 1)
			var/T = get_turf(src)
			new /obj/effect/gibspawner/human(T)
			visible_message(span_warning("With a sickening squish, [src] reforms their whole body, casting their old parts on the floor!"),
			span_notice("We reform our body.  We are whole once more."),
			span_warningplain("You hear organic matter ripping and tearing!"))

	feedback_add_details("changeling_powers","RR")
	return 1
