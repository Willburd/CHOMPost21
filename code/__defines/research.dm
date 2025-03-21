#define SHEET_MATERIAL_AMOUNT 2000

#define TECH_MATERIAL "materials"
#define TECH_ENGINEERING "engineering"
#define TECH_PHORON "phorontech"
#define TECH_POWER "powerstorage"
#define TECH_BLUESPACE "bluespace"
#define TECH_BIO "biotech"
#define TECH_COMBAT "combat"
#define TECH_MAGNET "magnets"
#define TECH_DATA "programming"
#define TECH_ILLEGAL "transgressive"
#define TECH_ARCANE "arcane"
#define TECH_PRECURSOR "precursor"

#define IMPRINTER	0x0001	//For circuits. Uses glass/chemicals.
#define PROTOLATHE	0x0002	//New stuff. Uses glass/metal/chemicals
#define MECHFAB		0x0004	//Mechfab
#define CHASSIS		0x0008	//For protolathe, but differently
#define PROSFAB		0x0010  //For prosthetics fab

// CHOMPAdd - Departmental Lathes
#define LATHE_SCIENCE			0x1
#define LATHE_ENGINEERING		0x2
#define LATHE_MEDICAL			0x4
#define LATHE_CARGO				0x8
#define LATHE_SERVICE			0x10
#define LATHE_SECURITY			0x20
#define LATHE_PUBLIC			0x40
#define LATHE_ALL 				(~0)
