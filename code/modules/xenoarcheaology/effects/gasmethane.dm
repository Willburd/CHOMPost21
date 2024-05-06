/datum/artifact_effect/gasch4
	name = "CH4 creation"

	effect_color = "#c9dcc3"

/datum/artifact_effect/gasch4/New()
	..()
	effect = pick(EFFECT_TOUCH, EFFECT_AURA)
	effect_type = pick(EFFECT_BLUESPACE, EFFECT_SYNTH)

/datum/artifact_effect/gasch4/DoEffectTouch(var/mob/user)
	var/atom/holder = get_master_holder()
	if(holder)
		var/turf/holder_loc = holder.loc
		if(istype(holder_loc))
			holder_loc.assume_gas("methane", rand(2, 15))

/datum/artifact_effect/gasch4/DoEffectAura()
	var/atom/holder = get_master_holder()
	if(holder)
		var/turf/holder_loc = holder.loc
		if(istype(holder_loc))
			holder_loc.assume_gas("methane", pick(0, 0, 0.1, rand()))
