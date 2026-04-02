#define CRITICAL_DAMAGE_THRESHOLD 18

SUBSYSTEM_DEF(terraformer)
	name = "Terraformer"
	wait = 7 SECONDS
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	dependencies = list(
		/datum/controller/subsystem/atoms
	)

	var/previous_health
	var/health
	var/total_health

	var/nutrition = 0
	var/healing_points = 500
	var/last_inhaled_mix = null

	var/list/healing_turfs = list()
	var/list/current_run = list()

/datum/controller/subsystem/terraformer/Initialize()
	// Get all flesh turfs in terraformer
	total_health = 0
	for(var/turf/simulated/flesh/meat in GLOB.areas_by_type[/area/muriki/processor])
		total_health++
	for(var/turf/simulated/floor/water/digestive_enzymes/goop in GLOB.areas_by_type[/area/muriki/processor])
		goop.linked_mob = src // This is an awful hack
	health = total_health
	previous_health = total_health
	previous_health = total_health
	if(total_health == 0)
		Shutdown()
	return SS_INIT_SUCCESS

/datum/controller/subsystem/terraformer/proc/adjust_nutrition(amount) // AWFUL HACK
	healing_points += amount

/datum/controller/subsystem/terraformer/stat_entry(msg)
	msg = "Health: [health]/[total_health]([(health/total_health) * 100]%) | REGEN: [healing_points] | HT: [length(healing_turfs)] | CR: [length(current_run)]"
	return ..()

/datum/controller/subsystem/terraformer/fire(resumed)
	if (!resumed)
		// Update health
		if(health < previous_health)
			handle_wounded_response(previous_health - health)
		previous_health = health
		// If have food, can heal
		if(nutrition > 10)
			nutrition -= 10
			healing_points++
		// Get ready for healing
		current_run = healing_turfs.Copy()
		shuffle_inplace(current_run)

	// Update healing
	while(length(current_run))
		if(MC_TICK_CHECK)
			return
		if(prob(90))
			current_run.len--
			continue
		if(healing_points <= 0)
			current_run.Cut()
			return
		if(!length(current_run))
			return
		// Heal that salami!
		healing_points--
		heal_meat(current_run[1])

/datum/controller/subsystem/terraformer/proc/handle_wounded_response(amount)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(amount >= CRITICAL_DAMAGE_THRESHOLD || (amount > 10 && prob(3)))
		Sound( 'sound/goonstation/spooky/Meatzone_Howl.ogg', using_map.station_levels)
		healing_points += 10 // Mercy
		// Quake from pain
		station_quake(using_map.station_levels)
		message_admins("Terraformer CRITICALLY wounded: [stationtime2text()] | turfs broken: [amount]")
	else
		message_admins("Terraformer wounded: [stationtime2text()] | turfs broken: [amount]")
	return

/datum/controller/subsystem/terraformer/proc/meat_broken(turf/simulated/floor/flesh/meat)
	SHOULD_NOT_OVERRIDE(TRUE)
	var/area/check_area = get_area(meat)
	if(!istype(check_area, /area/muriki/processor))
		return
	// Prep turf for healing in the future
	meat.can_heal = TRUE
	healing_turfs += meat
	health--

/datum/controller/subsystem/terraformer/proc/heal_meat(turf/simulated/floor/flesh/meat)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(!istype(meat))
		return
	healing_turfs -= meat
	meat.heal_into_wall()
	health++

/datum/controller/subsystem/terraformer/proc/Sound(var/sound, var/list/zlevels)
	if(!sound)
		return

	for(var/mob/M in GLOB.player_list)
		if(zlevels && !(M.z in zlevels))
			continue
		if(!isnewplayer(M) && !isdeaf(M))
			M << sound

#undef CRITICAL_DAMAGE_THRESHOLD
