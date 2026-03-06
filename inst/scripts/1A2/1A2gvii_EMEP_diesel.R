# IPCC
# 1: Energy
# 1.A Fuel Combustion Activities
# 1.A.2 - Manufacturing Industries and Construction\n"
# 1.A.2.a - EMEP Iron and steel
# 1.A.2.b - EMEP Non-ferrous metals
# 1.A.2.c - EMEP Chemicals
# 1.A.2.d - EMEP Pulp, paper and print
# 1.A.2.e - EMEP Food processing, beverages and tobacco
# 1.A.2.f - IPCC Non-Metallic Minerals
# 1.A.2.g - IPCC Transport Equipment
# 1.A.2.g.vii - EMEP Mobile combustion in manufacturing industries and construction: Other (Please specify in your IIR)

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
  code == "1.A.2.g.vii"
] -> dbf

# category
dbf[, unique(category)]

# type
dbf[, unique(region), by = pol]

# [1] "1996 IPCC default" "2006 IPCC default"

db[
  code == "1.A.2.g.vii" &
    is.na(region)
] -> dbf

# fuels
fuels <- dbf[, unique(fuel)]
cat(fuels, sep = "\n")

# fuel ####
dbf[, unique(tech), by = pol]

dbf[
  fuel == "Diesel",
  unique(tech)
]
"Stage IIIB"
"Stage IV"
"Stage V"
"Stage I"
"Stage II"
"Stage IIIA"
"< 1981"
"1981-1990"
"1991-Stage I"
# NA
# must add other tech
dbf[
  fuel == "Diesel" &
    is.na(tech)
] -> db_ef

db_ef

db_ef[, unique(unit), by = pol] -> xx

setorderv(xx, "V1")

xx

db_ef[, .N, by = pol]

activity <- data.table(
  id = 1,
  lat = -23,
  lon = -46,
  alt = 10,
  code = "1.A.2.g.vii",
  activity = rnorm(n = 12, mean = 500, sd = 100),
  unit = "tonnes fuel",
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
  df$unit_activity <- ifelse(
    df$pol %in%
      c(
        "Ni",
        "Cr",
        "Cu",
        "Cd",
        "Benzo(b)fluoranthene",
        "Se",
        "Zn",
        "Benzo(a)pyrene"
      ),
    "g/kg fuel",
    "g/tonnes fuel"
  )
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
  "estimation/1/1.A/1.A.2/emissions/1A2gvii_EMEP_diesel.csv"
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

# EMEP
# Biomass
# 'Other' Liquid Fuels
# Solid Fuels
# Gaseous Fuels

# IPCC 1A2f
# Industrial Wastes
# Natural Gas
# Other Bituminous Coal
# Anthracite
# Residual Fuel Oil
# Liquefied Petroleum Gases
