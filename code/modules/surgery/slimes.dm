//////////////////////////////////////////////////////////////////
//				SLIME CORE EXTRACTION							//
//////////////////////////////////////////////////////////////////

/datum/surgery_step/slime
	surgery_name = "Slime Surgery"
	is_valid_target(mob/living/simple_mob/slime/target)
		return istype(target, /mob/living/simple_mob/slime/)

/datum/surgery_step/slime/can_use(mob/living/user, mob/living/simple_mob/slime/target, target_zone, obj/item/tool)
	return target.stat == 2



/datum/surgery_step/slime/cut_flesh
	surgery_name = "Cut Flesh"
	allowed_tools = list(
	/obj/item/surgical/scalpel = 100,		\
	/obj/item/material/knife = 95,	\
	/obj/item/material/shard = 60, 		\
	) // Outpost 21 edit - Buffing ghetto surgery

	min_duration = 30
	max_duration = 50

/datum/surgery_step/slime/cut_flesh/can_use(mob/living/user, mob/living/simple_mob/slime/target, target_zone, obj/item/tool)
	return ..() && istype(target) && target.core_removal_stage == 0

/datum/surgery_step/slime/cut_flesh/begin_step(mob/user, mob/living/simple_mob/slime/target, target_zone, obj/item/tool)
	user.visible_message("[user] starts cutting through [target]'s flesh with \the [tool].", \
	"You start cutting through [target]'s flesh with \the [tool].")

/datum/surgery_step/slime/cut_flesh/end_step(mob/living/user, mob/living/simple_mob/slime/target, target_zone, obj/item/tool)
	user.visible_message(span_notice("[user] cuts through [target]'s flesh with \the [tool]."),	\
	span_notice("You cut through [target]'s flesh with \the [tool], revealing its silky innards."))
	target.core_removal_stage = 1

/datum/surgery_step/slime/cut_flesh/fail_step(mob/living/user, mob/living/simple_mob/slime/target, target_zone, obj/item/tool)
	user.visible_message(span_danger("[user]'s hand slips, tearing [target]'s flesh with \the [tool]!"), \
	span_danger("Your hand slips, tearing [target]'s flesh with \the [tool]!"))



/datum/surgery_step/slime/cut_innards
	surgery_name = "Cut Innards"
	allowed_tools = list(
	/obj/item/surgical/scalpel = 100,		\
	/obj/item/material/knife = 95,	\
	/obj/item/material/shard = 60, 		\
	) // Outpost 21 edit - Buffing ghetto surgery

	min_duration = 30
	max_duration = 50

/datum/surgery_step/slime/cut_innards/can_use(mob/living/user, mob/living/simple_mob/slime/target, target_zone, obj/item/tool)
	return ..() && istype(target) && target.core_removal_stage == 1

/datum/surgery_step/slime/cut_innards/begin_step(mob/user, mob/living/simple_mob/slime/target, target_zone, obj/item/tool)
	user.visible_message("[user] starts cutting [target]'s silky innards apart with \the [tool].", \
	"You start cutting [target]'s silky innards apart with \the [tool].")

/datum/surgery_step/slime/cut_innards/end_step(mob/living/user, mob/living/simple_mob/slime/target, target_zone, obj/item/tool)
	user.visible_message(span_notice("[user] cuts [target]'s innards apart with \the [tool], exposing the cores."),	\
	span_notice("You cut [target]'s innards apart with \the [tool], exposing the cores."))
	target.core_removal_stage = 2

/datum/surgery_step/slime/cut_innards/fail_step(mob/living/user, mob/living/simple_mob/slime/target, target_zone, obj/item/tool)
	user.visible_message(span_danger("[user]'s hand slips, tearing [target]'s innards with \the [tool]!"), \
	span_danger("Your hand slips, tearing [target]'s innards with \the [tool]!"))



/datum/surgery_step/slime/saw_core
	surgery_name = "Remove Core"
	allowed_tools = list(
	/obj/item/surgical/circular_saw = 100, \
	/obj/item/material/knife/machete/hatchet = 65
	) // Outpost 21 edit - Buffing ghetto surgery

	min_duration = 50
	max_duration = 70

/datum/surgery_step/slime/saw_core/can_use(mob/living/user, mob/living/simple_mob/slime/target, target_zone, obj/item/tool)
	return ..() && (istype(target) && target.core_removal_stage == 2 && target.cores > 0) //This is being passed a human as target, unsure why.

/datum/surgery_step/slime/saw_core/begin_step(mob/user, mob/living/simple_mob/slime/target, target_zone, obj/item/tool)
	user.visible_message("[user] starts cutting out one of [target]'s cores with \the [tool].", \
	"You start cutting out one of [target]'s cores with \the [tool].")

/datum/surgery_step/slime/saw_core/end_step(mob/living/user, mob/living/simple_mob/slime/target, target_zone, obj/item/tool)
	target.cores--
	user.visible_message(span_notice("[user] cuts out one of [target]'s cores with \the [tool]."),,	\
	span_notice("You cut out one of [target]'s cores with \the [tool]. [target.cores] cores left."))

	if(target.cores >= 0)
		new target.coretype(target.loc)
	if(target.cores <= 0)
		target.icon_state = "slime extracted"


/datum/surgery_step/slime/saw_core/fail_step(mob/living/user, mob/living/simple_mob/slime/target, target_zone, obj/item/tool)
	var/datum/gender/T = gender_datums[user.get_visible_gender()]
	user.visible_message(span_danger("[user]'s hand slips, causing [T.him] to miss the core!"), \
	span_danger("Your hand slips, causing you to miss the core!"))
