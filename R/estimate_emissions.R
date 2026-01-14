#' Estimate Emissions
#'
#' @description Calculate emissions by combining activity data (generation) with emission factors.
#'
#' @param activity_gwh Numeric, energy generation in GWh.
#' @param ef data.table, emission factors from ef_emep or ef_ipcc.
#' @param efficiency Numeric, thermal efficiency of the plant (0 to 1), default 0.35.
#' @return A data.table with activity, EF, and calculated emissions.
#' @export
#' @importFrom data.table as.data.table copy ":="
estimate_emissions <- function(activity_gwh, ef, efficiency = 0.35) {
    if (!is.numeric(activity_gwh)) {
        stop("activity_gwh must be numeric")
    }

    if (efficiency <= 0 || efficiency > 1) {
        stop("efficiency must be between 0 and 1")
    }

    Pollutant <- Unit <- emi_ton <- fuel_energy_gj <- emi_g <- Value <- conv_factor <- `:=` <- NULL
    activity_gwh_val <- activity_gwh # Avoid name conflict in dt

    # Copy EF to avoid modifying original
    dt <- data.table::copy(data.table::as.data.table(ef))

    # Ensure Value is numeric
    dt$Value <- as.numeric(dt$Value)

    # Activity conversion: 1 GWh = 3600 GJ
    # Activity_GJ (Input Fuel) = Generation_GWh * 3600 / Efficiency
    activity_gj <- (activity_gwh_val * 3600) / efficiency

    # Unit conversion factors to g/GJ
    # We handle common energy-based units found in EMEP/IPCC
    dt[, conv_factor := 1.0] # Default
    dt[Unit == "mg/GJ", conv_factor := 1e-3]
    dt[Unit == "µg/GJ", conv_factor := 1e-6]
    dt[Unit == "ng/GJ", conv_factor := 1e-9]
    dt[Unit == "t CO2/TJ", conv_factor := 1000]
    dt[Unit == "kg/TJ", conv_factor := 1.0]

    # Calculate
    dt[, activity_gwh := activity_gwh_val]
    dt[, efficiency := efficiency]
    dt[, fuel_energy_gj := activity_gj]

    # Value is numeric EF
    dt[, emi_g := fuel_energy_gj * as.numeric(Value) * conv_factor]
    dt[, emi_ton := emi_g / 1e6]

    # Identify records with non-energy units that were not converted
    unsupported <- dt[!Unit %in% c("g/GJ", "mg/GJ", "µg/GJ", "ng/GJ", "t CO2/TJ", "kg/TJ", "g N2O/GJ", "g CH4/GJ") & conv_factor == 1.0]
    if (nrow(unsupported) > 0) {
        warning(
            "Some records have unsupported units and were treated as g/GJ: ",
            paste(unique(unsupported$Unit), collapse = ", ")
        )
    }

    return(dt)
}
