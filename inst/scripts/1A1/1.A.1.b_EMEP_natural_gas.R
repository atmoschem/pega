# IPCC
# 1: Energy
# 1.A Fuel Combustion Activities
# 1.A.1.a Main Activities Electricity and Heat Production
# category: "1.A.1.b - Petroleum Refining"

library(data.table)
library(pega)

# database
db <- ef(returnfdb = T)

# database final
db[
  grepl("1.A.1.b", code) &
    is.na(region)
] -> dbf

# category
dbf[, unique(category)]

# fuels
fuels <- dbf[, unique(fuel)]
cat(fuels, sep = "\n")

# Natural Gas ####
dbf[fuel == "Natural Gas", unique(type)]

dbf[fuel == "Natural Gas", unique(tech)]

dbf[
  fuel == "Natural Gas" &
    tech == "Process Furnaces, Heaters and Boilers"
] -> db_ef

db_ef
db_ef[, .N, by = pol]

activity <- data.table(
  id = 1,
  lat = -23,
  lon = -46,
  alt = 10,
  code = "1.A.1.b",
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
dt[, emissions_units := "g"]
#  BC is % of PM2.5
# dt[pol == "PM2.5"]
# dt[pol == "BC"]
# dt[pol == "BC", emissions := ef / 100 * dt[pol == "PM2.5"]$emissions]
# dt[pol == "BC"]
f
fwrite(dt, "estimation/1/1.A/1.A.1/emissions/EMEP_1A1b_natural_gas.csv")

# Natural Gas
# Oil Gas
# Residual Oil
# Refinery Gas
# Residual Oil (Refinery Fuel Oil)
# Residual Fuel Oil
