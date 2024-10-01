///////////////////////////////////////////////////////////////
// Necrosis Surgery Step 2 - ALTERNATIVE using bioregen instead of paradaxon
///////////////////////////////////////////////////////////////
/datum/surgery_step/treat_necrosis_bioregen
	surgery_name = "Recreate Vital Structures"
	priority = 2
	allowed_tools = list(
		/obj/item/surgical/bioregen = 100
	)

	can_infect = 0
	blood_level = 0

	min_duration = 80
	max_duration = 120

/datum/surgery_step/treat_necrosis_bioregen/can_use(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	if(!hasorgans(target))
		return 0

	if (target_zone == O_MOUTH || target_zone == O_EYES)
		return 0

	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	if(coverage_check(user, target, affected, tool))
		return 0
	return affected && affected.open == 3 && (affected.status & ORGAN_DEAD)

/datum/surgery_step/treat_necrosis_bioregen/begin_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)

	user.visible_message("<span class='filter_notice'>[user] starts recreating [target]'s [affected]'s internal structures with \the [tool].</span>" , \
	"<span class='filter_notice'>You start recreating [target]'s [affected]'s internal structures with \the [tool].</span>")
	user.balloon_alert_visible("Starts recreating [target]'s [affected]'s internal structures", "Recreating [target]'s [affected]'s internal structures") // CHOMPEdit

	target.custom_pain("Something in your [affected.name] is causing you a lot of pain!", 50)

	..()

/datum/surgery_step/treat_necrosis_bioregen/end_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)

	user.visible_message("<span class='notice'>[user] carefully recreates the delicate structures of [target]'s [affected] with \the [tool].</span>", \
	"<span class='notice'>You carefully recreate the vital structures of [target]'s [affected] with \the [tool].</span>")
	user.balloon_alert_visible("Recreates vital structures in [target]'s [affected]", "Recreated a vital structure in [target]'s [affected]") // CHOMPEdit

	affected.status &= ~ORGAN_DEAD
	affected.owner.update_icons_body()

	..()

/datum/surgery_step/treat_necrosis_bioregen/fail_step(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	var/obj/item/organ/external/affected = target.get_organ(target_zone)
	user.visible_message("<span class='danger'>[user]'s hand slips, and the mesh falls, with \the [tool] scraping [target]'s body.</span>", \
	"<span class='danger'>Your hand slips, and the mesh falls, with \the [tool] scraping [target]'s body.</span>")
	user.balloon_alert_visible("Slips, and shoves \the [tool] into [target]'s body", "Your hand slips, and shoves \the [tool] into [target]'s body") // CHOMPEdit

	affected.createwound(CUT, 15)
	affected.createwound(BRUISE, 10)

	..()
