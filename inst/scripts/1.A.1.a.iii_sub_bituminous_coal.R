# IPCC
# 1: Energy
# 1.A Fuel Combustion Activities
# 1.A.1.a Main Activities Electricity and Heat Production
# category: 1.A.1.a.iii - Heat Plants

library(data.table)
library(pega)

# database
db <- ef(returnfdb = T)

# database final
db[,
  grep("1.A.1.a", code, value = T),
] |>
  unique()

db[
  code == "1.A.1.a.iii"
] -> dbf

# fuels
fuels <- dbf[, unique(fuel)]
cat(fuels, sep = "\n")

dbf[fuel == "Sub-Bituminous Coal"]

# Sub-Bituminous Coal ####
dbf[fuel == "Sub-Bituminous Coal", unique(tech)]

dbf[
  fuel == "Sub-Bituminous Coal" &
    tech == "Coal-fired power plants"
] -> db_ef


db_ef
db_ef[, .N, by = pol]

activity <- data.table(
  id = 1,
  lat = -23,
  lon = -46,
  alt = 10,
  code = "1.A.1.a.iii",
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
  "estimation/1/1.A/1.A.1/emissions/IPCC_1A1aiii_sub_bituminous_coal.csv"
)

# Other Bituminous Coal
# Sub-Bituminous Coal
# Anthracite
# Residual Fuel Oil
