SUBSYSTEM_DEF(departmentgoals)
	name = "Department Goals"
	wait = 5 SECONDS

	dependencies = list(
		/datum/controller/subsystem/mobs
	)
	runlevels = RUNLEVEL_GAME

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

	RegisterSignal(SSdcs, COMSIG_GLOB_ROUND_START, PROC_REF(handle_round_start))
	RegisterSignal(SSdcs, COMSIG_GLOB_ROUND_END, PROC_REF(handle_round_end))
	return SS_INIT_SUCCESS

/datum/controller/subsystem/departmentgoals/Shutdown()
	UnregisterSignal(SSdcs, COMSIG_GLOB_ROUND_START)
	UnregisterSignal(SSdcs, COMSIG_GLOB_ROUND_END)
	. = ..()

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
	show_goal_status_to(world)

/datum/controller/subsystem/departmentgoals/proc/show_goal_status_to(user)
	to_chat(user, span_world("Department goals are:"))

	for(var/category in active_department_goals)
		var/list/cat_goals = active_department_goals[category]
		if(!LAZYLEN(cat_goals))
			return

		to_chat(user, span_filter_system(span_bold("[category]:")))
		for(var/datum/goal/G in cat_goals)
			to_chat(user, span_filter_system("[G.get_completed() ? span_notice("[G.name]") : span_danger("[G.name]")]"))
			to_chat(user, span_filter_system("[G.goal_text]"))

// Move this helper when upported or make a tgui instead
/mob/verb/check_round_goals()
	set name = "Check Round Goals"
	set desc = "View currently active round goals, and if they have been completed."
	set category = "IC.Notes"

	SSdepartmentgoals.show_goal_status_to(usr)

/datum/admins/proc/add_department_goal()
	set category = "Debug.Events"
	set name = "Add Department Goal"
	set desc = "Adds a goal for the station to reach."

	if(!check_rights(R_EVENT))
		return
	var/choice = tgui_input_list(usr,"Choose goal to add:","New Goal", subtypesof(/datum/goal))
	if(!choice)
		return

	var/datum/goal/template = choice
	var/list/dept_goals = active_department_goals[template.category]
	dept_goals += new template()

/datum/admins/proc/remove_department_goal()
	set category = "Debug.Events"
	set name = "Remote Department Goal"
	set desc = "Remove a goal from the station's current department goals."

	if(!check_rights(R_EVENT))
		return

	var/list/all_goals = list()
	for(var/category in active_department_goals)
		all_goals += active_department_goals[category]
	if(!all_goals.len)
		to_chat(usr, span_warning("There are no station goals."))
		return

	var/choice = tgui_input_list(usr,"Choose goal to remove:","Remove Goal", all_goals)
	if(!choice)
		return

	active_department_goals -= choice
	qdel(choice)
