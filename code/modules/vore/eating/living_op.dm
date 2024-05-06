/datum/gas_mixture/belly_air/carbon_dioxide_breather
    volume = 2500
    temperature = 293.150
    total_moles = 104

/datum/gas_mixture/belly_air/carbon_dioxide_breather/New()
    . = ..()
    gas = list(
        "carbon_dioxide" = 100)

/datum/gas_mixture/belly_air/methane_breather
    volume = 2500
    temperature = 293.150
    total_moles = 104

/datum/gas_mixture/belly_air/methane_breather/New()
    . = ..()
    gas = list(
        "methane" = 100)
