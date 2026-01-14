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

    Pollutant <- Unit <- emi_ton <- fuel_energy_gj <- emi_g <- Value <- `:=` <- NULL
    activity_gwh_val <- activity_gwh # Avoid name conflict in dt

    # Copy EF to avoid modifying original
    dt <- data.table::copy(data.table::as.data.table(ef))

    # Ensure Value is numeric
    dt$Value <- as.numeric(dt$Value)

    # Activity conversion: 1 GWh = 3600 GJ
    # Activity_GJ (Input Fuel) = Generation_GWh * 3600 / Efficiency
    activity_gj <- (activity_gwh_val * 3600) / efficiency

    # Calculate
    dt[, activity_gwh := activity_gwh_val]
    dt[, efficiency := efficiency]
    dt[, fuel_energy_gj := activity_gj]

    # Value is already normalized to g/GJ or g/Mg in sysdata
    # If Unit is energy-based (g/GJ), we use activity_gj
    # If Unit is mass-based (g/Mg), we would need a different activity input,
    # but for now we focus on energy-based generation.

    dt[, emi_g := fuel_energy_gj * as.numeric(Value)]
    dt[, emi_ton := emi_g / 1e6]

    # Check for non-energy units
    non_energy <- dt[!Unit %in% c("g/GJ", "gC/GJ")]
    if (nrow(non_energy) > 0) {
        warning(
            "Some records use non-energy units (e.g. g/Mg) but were calculated using energy activity: ",
            paste(unique(non_energy$Unit), collapse = ", ")
        )
    }

    return(dt)
}
