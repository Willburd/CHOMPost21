// This causes PoI maps to get 'checked' and compiled, when undergoing a unit test.
// This is so CI can validate PoIs, and ensure future changes don't break PoIs, as PoIs are loaded at runtime and the compiler can't catch errors.
// When adding a new PoI, please add it to this list.
#if MAP_TEST
#include "light_A.dmm"
#include "light_B.dmm"
#include "light_C.dmm"
#include "flesh_A.dmm"
#include "flesh_B.dmm"
#include "gas_pocket_A.dmm"
#include "den_A.dmm"
#include "den_B.dmm"
#endif

/datum/map_template/outpost21/muriki/caves_deepdark
	name = "Cave Content - Small"
	desc = "Used to fill extra space to explore in the deep dark."
	annihilate = TRUE

//////////////////////////////////////////////////////////////
// Generic things and structures
/datum/map_template/outpost21/muriki/caves_deepdark/light_A
	name = "Light Variant A"
	desc = "Random light."
	mappath = 'maps/submaps/outpost21/deepdark/light_A.dmm'
	allow_duplicates = TRUE
	discard_prob = 60
	cost = 5

/datum/map_template/outpost21/muriki/caves_deepdark/gas_A
	name = "Gas Pocket Variant A"
	desc = "Random gas pocket."
	mappath = 'maps/submaps/outpost21/deepdark/gas_pocket_A.dmm'
	allow_duplicates = TRUE
	discard_prob = 60
	cost = 15

/datum/map_template/outpost21/muriki/caves_deepdark/gas_B
	name = "Gas Pocket Variant B"
	desc = "Random gas pocket."
	mappath = 'maps/submaps/outpost21/deepdark/gas_pocket_B.dmm'
	allow_duplicates = TRUE
	discard_prob = 60
	cost = 15

/datum/map_template/outpost21/muriki/caves_deepdark/flesh_A
	name = "Flesh Variant A"
	desc = "flesh varient."
	mappath = 'maps/submaps/outpost21/deepdark/flesh_A.dmm'
	allow_duplicates = TRUE
	discard_prob = 80
	cost = 45

/datum/map_template/outpost21/muriki/caves_deepdark/flesh_B
	name = "Flesh Variant B"
	desc = "flesh varient."
	mappath = 'maps/submaps/outpost21/deepdark/flesh_B.dmm'
	allow_duplicates = TRUE
	discard_prob = 80
	cost = 45

/datum/map_template/outpost21/muriki/caves_deepdark/gas_C
	name = "Gas Pocket Variant C"
	desc = "Random gas pocket."
	mappath = 'maps/submaps/outpost21/deepdark/gas_pocket_C.dmm'
	allow_duplicates = TRUE
	discard_prob = 60
	cost = 15

/datum/map_template/outpost21/muriki/caves_deepdark/den_A
	name = "Den A"
	desc = "Random den."
	mappath = 'maps/submaps/outpost21/deepdark/den_A.dmm'
	allow_duplicates = TRUE
	discard_prob = 30
	cost = 15

/datum/map_template/outpost21/muriki/caves_deepdark/den_B
	name = "Den B"
	desc = "Random den."
	mappath = 'maps/submaps/outpost21/deepdark/den_B.dmm'
	allow_duplicates = TRUE
	discard_prob = 70
	cost = 15

//////////////////////////////////////////////////////////////
// Huge structures in the cave (usually one at a time...)


//////////////////////////////////////////////////////////////
// Area definitions
