# IPCC
# 1: Energy
# 1.A Fuel Combustion Activities
# 1.A.2 - Manufacturing Industries and Construction\n"

library(data.table)
library(pega)

# database
db <- ef(returnfdb = T)

db[,
  grep("1.A.2", code, value = T)
] |>
  unique()
# database final
db[
  code == "1.A.2" &
    is.na(region)
] -> dbf

# category
dbf[, unique(category)]

# type
dbf[, unique(type)]

# [1] "1996 IPCC default" "2006 IPCC default"

db[
  code == "1.A.2" &
    is.na(region) &
    type == "2006 IPCC default"
] -> dbf

# fuels
fuels <- dbf[, unique(fuel)]
cat(fuels, sep = "\n")

# fuel ####
dbf[fuel == "Brown Coal Briquettes", unique(tech), by = pol]

dbf[
  fuel == "Brown Coal Briquettes" &
    is.na(tech)
] -> db_ef

db_ef
db_ef[, .N, by = pol]

db_ef[, unique(tech2)]


activity <- data.table(
  id = 1,
  lat = -23,
  lon = -46,
  alt = 10,
  code = "1.A.2",
  activity = rnorm(n = 12, mean = 500, sd = 100),
  unit = "GJ",
  date = seq.Date(as.Date("2020-01-01"), length.out = 12, by = "month"),
  region = "HERE"
)

rbindlist(lapply(1:nrow(activity), function(i) {
  df <- db_ef
  df$id <- activity$id[i]
  df$lat <- activity$lat[i]
  df$lon <- activity$lon[i]
  df$alt <- activity$alt[i]

  df$activity <- activity$activity[i]
  df$unit_activity <- activity$unit[i]
  df$date_activity <- activity$date[i]
  df$region <- activity$region[i]
  df
})) -> dt

dt[, emissions := ef * activity]
# BC is % of PM2.5
# dt[pol == "PM2.5"]
# dt[pol == "BC"]
# dt[pol == "BC", emissions := ef / 100 * dt[pol == "PM2.5"]$emissions]
# dt[pol == "BC"]
fwrite(
  dt,
  "estimation/1/1.A/1.A.2/emissions/IPCC_1A2_brown_coal_briquettes.csv"
)

# Crude Oil
# Orimulsion
# Natural Gas
# Motor Gasoline
# Aviation Gasoline
# Jet Gasoline
# Jet Kerosene
# Other Kerosene
# Shale Oil
# Oil Gas
# Diesel Oil
# Residual Fuel Oil
# Liquefied Petroleum Gases
# Ethane
# Naphtha
# Bitumen
# Lubricants
# Petroleum Coke
# Refinery Feedstocks
# Refinery Gas
# Waxes
# White Spirit & SBP
# Other Petroleum Products
# Anthracite
# Coking Coal
# Other Bituminous Coal
# Sub-Bituminous Coal
# Lignite
# Oil Shale and Tar Sands
# Brown Coal Briquettes

# Patent Fuel
# Coke Oven Coke and Lignite Coke
# Gas Coke
# Coal Tar
# Gas Works Gas
# Coke Oven Gas
# Blast Furnace Gas
# Oxygen Steel Furnace Gas
# Municipal Wastes (non-biomass fraction)
# Industrial Wastes
# Waste Oils
# Peat
# Wood/Wood Waste
# Sulphite Lyes (Black Liquor)
# Other Primary Solid Biomass
# Charcoal
# Biogasoline
# Biodiesels
# Other Liquid Biofuels
# Landfill Gas
# Sludge Gas
# Other Biogas
# Municipal Wastes (biomass fraction)
