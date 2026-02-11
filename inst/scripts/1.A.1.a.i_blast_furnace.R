# IPCC
# 1: Energy
# 1.A Fuel Combustion Activities
# 1.A.1.a Main Activities Electricity and Heat Production
# 1.A.1.a.i Electricity Generation

library(data.table)
library(pega)

# database
db <- ef(returnfdb = T)

# database final
db[
  grepl("1.A.1.a", code) &
    is.na(region)
] -> dbf

# fuels
fuels <- dbf[, unique(fuel)]
cat(fuels, sep = "\n")

# Blast furnace/Basic O2 furnace gas ####
dbf[fuel == "Blast furnace/Basic O2 furnace gas", unique(type)]

dbf[
  fuel == "Blast furnace/Basic O2 furnace gas" &
    type == "Tier 1 Emission Factor"
] -> db_ef

db_ef
db_ef[, .N, by = pol]

activity <- data.table(
  id = 1,
  lat = -23,
  lon = -46,
  alt = 10,
  code = "1.A.1.a",
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
fwrite(dt, "estimation/1/1.A/1.A.1/emissions/blast_furnace.csv")

# Natural Gas ####
# Heavy Fuel Oil ####
# Brown Coal ####
# Hard Coal ####
# Biomass ####
# Blast furnace/Basic O2 furnace gas ####
# Biogas ####
# Coking Coal, Steam Coal & Sub-Bituminous Coal ####
# Oil Gas ####
# Wood and wood waste (clean wood waste) ####
# Brown Coal/Lignite ####
# Residual Oil ####
# Gaseous Fuels ####
