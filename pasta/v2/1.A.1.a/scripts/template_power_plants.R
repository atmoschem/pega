# -------------------------------------------------------------------------
# TEMPLATE: Emissions Estimation for Power Plants (1.A.1.a)
# -------------------------------------------------------------------------
# This script demonstrates how to estimate emissions for Power Plants
# using the 'pega' package with EMEP (Pollutants) and IPCC (GHG) factors.

library(pega)
library(data.table)

# 1. SETUP ACTIVITY DATA --------------------------------------------------
# Example: A power plant generated 150 GWh in a month (e.g. from ANEEL data)
plant_name <- "ThermoPower-1"
generation_gwh <- 150
fuel_type_emep <- "Natural gas"
fuel_type_ipcc <- "Natural Gas" # EMEP and IPCC use slightly different names

# 2. GET EMISSION FACTORS -------------------------------------------------

# A) EMEP Factors (Criteria Pollutants: CO, NOx, PM, etc.)
ef_pollutants <- ef_emep(
    nfr = "1.A.1.a",
    tier = 1,
    fuel = fuel_type_emep,
    pol = c("CO", "NOx", "PM10", "PM2.5", "NMVOC")
)

# B) IPCC Factors (Greenhouse Gases: CO2, CH4, N2O)
ef_ghg <- ef_ipcc(
    nfr = "1.A.1.a",
    fuel = fuel_type_ipcc,
    pol = c("CO2", "CH4", "N2O")
)

# Filtering IPCC for Energy-based Emission Factors
# This removes NCVs (MJ/m3) and other parameters
valid_units <- c("g/GJ", "mg/GJ", "µg/GJ", "ng/GJ", "t CO2/TJ", "kg/TJ", "g N2O/GJ", "g CH4/GJ")
ef_ghg <- ef_ghg[Unit %in% valid_units]

# 3. ESTIMATE EMISSIONS ---------------------------------------------------
# We assume a 35% efficiency for this older thermal plant.
efficiency <- 0.35

# Calculate Criteria Pollutants
emi_pollutants <- estimate_emissions(
    activity_gwh = generation_gwh,
    ef = ef_pollutants,
    efficiency = efficiency
)

# Calculate GHGs
# Note: ef_ipcc sometimes uses different columns, estimate_emissions
# is designed to work with the standard 'Value' column from pega.
emi_ghg <- estimate_emissions(
    activity_gwh = generation_gwh,
    ef = ef_ghg,
    efficiency = efficiency
)

# 4. RESULTS --------------------------------------------------------------
message("\n--- Results for ", plant_name, " ---")
print(emi_pollutants[, .(Pollutant, Unit, emi_ton)])
print(emi_ghg[, .(Pollutant, Unit, emi_ton)])

# Total Sum (optional)
# total_emi <- rbind(emi_pollutants, emi_ghg)
# fwrite(total_emi, "emissions_results.csv")
