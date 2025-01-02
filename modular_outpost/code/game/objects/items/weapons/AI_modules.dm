/************* Eshui standard *************/
/obj/item/aiModule/eshui_standard
	name = "\improper 'Eshui Standard' core AI module"
	desc = "A Eshui Standard Core AI Module: 'Reconfigures the AI's core laws.'"
	origin_tech = list(TECH_DATA = 3, TECH_MATERIAL = 4)
	laws = new/datum/ai_laws/eshui_standard()

/******************** Mr.Clean ********************/
/obj/item/aiModule/mrclean
	name = "\improper 'Mr.Kleen' core AI module"
	desc = "A Mr.Kleen Core AI Module: 'Reconfigures the AI's core laws.'"
	origin_tech = list(TECH_DATA = 3, TECH_MATERIAL = 4, TECH_BIO = 1)
	laws = new/datum/ai_laws/mrclean()

/************* Nanny state *************/
/obj/item/aiModule/nanny
	name = "\improper 'NANNY' core AI module"
	desc = "A NANNY Core AI Module: 'Reconfigures the AI's core laws.'"
	origin_tech = list(TECH_DATA = 3, TECH_BIO = 2, TECH_MATERIAL = 6, TECH_ILLEGAL = 2)
	laws = new/datum/ai_laws/nanny()
