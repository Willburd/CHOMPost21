SUBSYSTEM_DEF(departmentgoals)
	name = "Department Goals"
	wait = 5 SECONDS

	dependencies = list(
		/datum/controller/subsystem/mobs
	)
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME

	VAR_PRIVATE/list/currentrun = null
	VAR_PRIVATE/list/department_goals = list() // List of goal paths that exist for each dept
	VAR_PRIVATE/list/active_department_goals = list() // List of goal datums that were assigned on round start

/datum/controller/subsystem/departmentgoals/Initialize()
	for(var/category in list(GOAL_GENERAL, GOAL_MEDICAL, GOAL_SECURITY, GOAL_ENGINEERING, GOAL_CARGO, GOAL_RESEARCH))
		department_goals[category] = list()
		for(var/subtype in subtypesof(/datum/goal))
			var/datum/goal/goal_template = subtype
			if(goal_template.name == /datum/goal::name)
				continue
			if(goal_template.category == category)
				department_goals[category] += goal_template

	RegisterSignal(COMSIG_GLOB_ROUND_START, PROC_REF(handle_round_start))
	RegisterSignal(COMSIG_GLOB_ROUND_END, PROC_REF(handle_round_end))

	return SS_INIT_SUCCESS

/datum/controller/subsystem/departmentgoals/stat_entry(msg)
	msg = "Active Goals: [active_department_goals.len]"
	return ..()

/datum/controller/subsystem/departmentgoals/fire()
	if(!currentrun.len)
		for(var/category in active_department_goals)
			var/list/dept_goals = active_department_goals[category]
			for(var/datum/goal/dept_goal in dept_goals)
				currentrun += dept_goal
	while(currentrun.len)
		var/datum/goal/dept_goal = currentrun[1]
		dept_goal.check_completion()
		currentrun -= dept_goal
		if(MC_TICK_CHECK)
			return


///////////////////////////////////////////////////////////////////////////////////////////////
// Signals for roundstart announcements and round end praise
///////////////////////////////////////////////////////////////////////////////////////////////
/datum/controller/subsystem/departmentgoals/proc/handle_round_start()
	SIGNAL_HANDLER
	for(var/category in department_goals)
		active_department_goals[category] = list()

		var/list/cat_goals = department_goals[category]
		var/goal_count = rand(2,4)
		for(var/count = 1 to goal_count)
			var/datum/goal/rand_goal
			if(LAZYLEN(cat_goals))
				rand_goal = pick(cat_goals)
				rand_goal.active_goal = TRUE
				cat_goals -= rand_goal
				active_department_goals[category] += rand_goal

/datum/controller/subsystem/departmentgoals/proc/handle_round_end()
	SIGNAL_HANDLER
	if(!active_department_goals.len)
		return
	to_chat(world, span_world("Department goals!"))

	for(var/category in active_department_goals)
		var/list/cat_goals = active_department_goals[category]
		if(!LAZYLEN(cat_goals))
			return

		to_chat(world, span_filter_system(span_bold("[category]:")))
		for(var/datum/goal/G in cat_goals)
			var/success = G.check_completion()
			to_chat(world, span_filter_system("[success ? span_notice("[G.name]") : span_warning("[G.name]")]"))
			to_chat(world, span_filter_system("[success ? G.goal_text : G.fail_text]"))
