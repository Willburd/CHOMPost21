/datum/gas_mixture/belly_air/methane_breather
    volume = 2500
    temperature = 293.150
    total_moles = 104

/datum/gas_mixture/belly_air/methane_breather/New()
    . = ..()
    gas = list(
        GAS_CH4 = 100)
