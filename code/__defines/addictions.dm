#define ADDICT_NICOTINE 	0x1
#define ADDICT_PAINKILLER 	0x2
#define ADDICT_BLISS		0x4
#define ADDICT_OXY			0x8
#define ADDICT_HYPER		0x10
#define ADDICT_ALCOHOL		0x20
#define ADDICT_SUSTENANCE	0x40
#define ADDICT_COFFEE		0x80

#define CE_WITHDRAWL "withdrawl" // Withdrawl symptoms

var/list/addictives	    = list("oxycodone","nicotine","hyperzine","bliss","ambrosia_extract","talum_quem","methylphenidate","paracetamol","tricordrazine","ethanol","coffee","a_sustenance")
var/list/fast_addictives= list("oxycodone","hyperzine","bliss","methylphenidate") // needs to be in above list too
var/list/slow_addictives= list("paracetamol","tricordrazine","a_sustenance","ethanol","nicotine","coffee") // needs to be in above list too
