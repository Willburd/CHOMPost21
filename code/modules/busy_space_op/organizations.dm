// TSCs
/datum/lore/organization/tsc/eshui
	name = "E-Shui incorperated"
	short_name = "Eshui "
	acronym = "ESU"
	desc = "Eshui, is and old-earth legacy corperation primarily focused on its atmospherics and terraforming divisions. \
	In modern times, research, mining, and genetics engineering divisions have been established, but due to limited marketshare, \
	and many patent disputes with rival corperations, Eshui is often religate to operations within the core regions of SolGov. \
	Due to their operational headquarters sitting near the heart of SolGov, they are often forced to follow their laws to the letter, \
	largely due to a lack of monopoly power or the monentary sway that many rival corperations have. Eshui gains a majority of its \
	income through terraforming operations, as such the company experiences large bursts of growth, before suddenly slowing over decades at a time. \
	<br><br> \
	Eshui's fleet bears the name of many proteins found in earth lifeforms."
	history = ""
	work = "terraforming and atmospherics services"
	headquarters = "Earth"
	motto = "Making better worlds."

	org_type = "corporate"
	slogans = list(
			"Eshui Atmospherics - Breathing new life into the universe.",
			"Eshui Atmospherics - When you need a breath of fresh air.",
			"Eshui Atmospherics - We're inside you, with every breath of fresh air."
			)
	ship_prefixes = list("ESU" = "a general operations", "ESX" = "a hauling", "ESH" = "a bulk transport", "ESR" = "a resupply")
	//martian mountains
	append_ship_names = TRUE
	added_ship_names = list(
			"Kdel",
			"Albumin",
			"Globulin",
			"Fibrinogen",
			"Prothrombin",
			"Thromboplastin",
			"Factor VI",
			"Factor VII",
			"Factor VIII",
			"Factor IX",
			"Fetoprotein",
			"Antitrypsin",
			"Trypsin",
			"Haptoglobin",
			"Ceruloplasmin",
			"Transthyretin",
			"Hephaestin",
			"Ferroxidase",
			"Fibrin",
			"Elastin",
			"Resilin",
			"Collagen",
			"Peptidoglycan",
			"Acetylglucosamine",
			"Keratosulfate",
			"Osteomodulin",
			"Hemagglutinin",
			"Neuraminidase",
			"Glycine",
			"Syncytin",
			)
	destination_names = list(
			"Venus",
			"Earth",
			"Luna",
			"Mars",
			"Titan",
			"Europa",
			"Outpost 19",
			"Outpost 17",
			"Outpost 15",
			"Outpost 24",
			"Gateway One above Luna",
			"SolCom Headquarters on Earth",
			"Olympus City on Mars",
			"Hermes Naval Shipyard above Mars",
			"Cairo Station above Earth",
			"Glitnir Orbital Gateway above Pluto",
			"a SolGov embassy",
			"a classified location"
			)


// Governments
/datum/lore/organization/gov/solgov
	name = "United Solar Government"
	short_name = "SolGov "
	acronym = "USG"
	desc = "The Unified Solar Government, or just \'SolGov\' to most, is a decentralized confederation of human governmental entities based on Luna, Sol, which defines top-level law for their member states. Member states receive various benefits such as defensive pacts, trade agreements, social support and funding, and being able to participate in the Colonial Assembly. The majority of human territories are members of SolGov, though there are notable groups who refuse to participate. As such, SolGov is a major power and defacto represents humanity on the galactic stage.\
	<br><br> \
	Ships on USG assignments typically carry the designations of Earth\'s largest craters, as a reminder of everything the planet has endured."
	history = "" // Todo
	work = "governing polity of humanity's Confederation"
	headquarters = "Luna, Sol"
	motto = "Nil Mortalibus Ardui Est" // Latin, because latin.  Says 'Nothing is too steep for mortals'
	autogenerate_destination_names = TRUE

	ship_prefixes = list("USG-A" = "an administrative", "USG-T" = "a transportation", "USG-D" = "a diplomatic", "USG-F" = "a freight", "USG-J" = "a prisoner transfer")
	//earth's biggest impact craters
	ship_names = list(
			"Wabar",
			"Kaali",
			"Campo del Cielo",
			"Henbury",
			"Morasko",
			"Boxhole",
			"Macha",
			"Rio Cuarto",
			"Ilumetsa",
			"Tenoumer",
			"Xiuyan",
			"Lonar",
			"Agoudal",
			"Tswaing",
			"Zhamanshin",
			"Bosumtwi",
			"Elgygytgyn",
			"Bigach",
			"Karla",
			"Karakul",
			"Vredefort",
			"Chicxulub",
			"Sudbury",
			"Popigai",
			"Manicougan",
			"Acraman",
			"Morokweng",
			"Kara",
			"Beaverhead",
			"Tookoonooka",
			"Charlevoix",
			"Siljan Ring",
			"Montagnais",
			"Araguinha",
			"Chesapeake",
			"Mjolnir",
			"Puchezh-Katunki",
			"Saint Martin",
			"Woodleigh",
			"Carswell",
			"Clearwater West",
			"Clearwater East",
			"Manson",
			"Slate",
			"Yarrabubba",
			"Keurusselka",
			"Shoemaker",
			"Mistastin",
			"Kamensk",
			"Steen",
			"Strangways",
			"Tunnunik",
			"Boltysh",
			"Nordlinger Ries",
			"Presqu'ile",
			"Haughton",
			"Lappajarvi",
			"Rochechouart",
			"Gosses Bluff",
			"Amelia Creek",
			"Logancha",
			"Obolon'",
			"Nastapoka",
			"Ishim",
			"Bedout"
			)
	destination_names = list(
			"Venus",
			"Earth",
			"Luna",
			"Mars",
			"Titan",
			"Europa",
			"the Jovian subcluster",
			"a SolGov embassy",
			"a classified location"
			)
			// autogen will add a lot of other places as well.
