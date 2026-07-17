/datum/component/health_hud_blocker
	var/tick = 0
	var/tick_max = 150

/datum/component/health_hud_blocker/Initialize()
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	START_PROCESSING(SSfastprocess, src)

/datum/component/health_hud_blocker/Destroy(force)
	var/mob/living/owner = parent
	if(owner?.healths)
		owner.healths.alpha = 255
	STOP_PROCESSING(SSfastprocess, src)
	. = ..()

/datum/component/health_hud_blocker/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOB_HANDLE_HUD_HEALTH_ICON, PROC_REF(handle_health_hud))

/datum/component/health_hud_blocker/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_MOB_HANDLE_HUD_HEALTH_ICON)

/datum/component/health_hud_blocker/process()
	if(tick_max < 100)
		tick_max = 100
	if(tick >= tick_max)
		qdel(src)
		return
	tick++
	var/mob/living/owner = parent
	if(!owner?.healths)
		return
	// Fade it out
	if(tick < 20)
		owner.healths.alpha = rand(200,255)
	if(tick < 40)
		owner.healths.alpha = rand(100,160)
	if(tick < 60)
		owner.healths.alpha = rand(10,50)
	if(tick > 80)
		owner.healths.alpha = 0
	// Restore it at the end
	if(tick > tick_max - 10)
		owner.healths.alpha = rand(128,255)

/datum/component/health_hud_blocker/proc/handle_health_hud()
	var/mob/living/owner = parent
	if(!owner?.healths)
		return
	if(owner.healths.alpha < 10)
		return COMSIG_COMPONENT_HANDLED_HEALTH_ICON
	return 0


/datum/component/health_hud_blocker/minor
	tick_max = 200

/datum/component/health_hud_blocker/moderate
	tick_max = 500

/datum/component/health_hud_blocker/major
	tick_max = 1000
