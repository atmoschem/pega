# IPCC
# 1: Energy
# 1.A Fuel Combustion Activities
# 1.A.1.a Main Activities Electricity and Heat Production
# category: 1.A.1.c.i - Manufacture of Solid Fuels

library(data.table)
library(pega)

# database
db <- ef(returnfdb = T)

# IPCC ####
db[
  grepl("1.A.1.c.ii", code) &
    is.na(region)
] -> dbf

# category
dbf[, unique(category)]


# fuels
fuels <- dbf[, unique(fuel)]
cat(fuels, sep = "\n")

# Coal ####
dbf[fuel == "Natural Gas", unique(type)]

dbf[
  fuel == "Natural Gas" &
    type == "Measured"
] -> db_ef

db_ef
db_ef[, .N, by = pol]

activity <- data.table(
  id = 1,
  lat = -23,
  lon = -46,
  alt = 10,
  code = "1.A.1.c.ii",
  activity = rnorm(n = 12, mean = 500, sd = 100),
  unit = "g/GJ of Fuel",
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

fwrite(dt, "estimation/1/1.A/1.A.1/emissions/IPCC_1A1cii_natural_gas.csv")

# Coal ####
# Coking Coal ####
# Natural Gas ####
