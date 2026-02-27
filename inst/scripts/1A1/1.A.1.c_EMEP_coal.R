# IPCC
# 1: Energy
# 1.A Fuel Combustion Activities
# 1.A.1.a Main Activities Electricity and Heat Production
# category:1.A.1.c Manufacture of solid fuels and other energy industries

library(data.table)
library(pega)

# database
db <- ef(returnfdb = T)

# database final
db[
  grepl("1.A.1.c", code) &
    is.na(region)
] -> dbf

# category
dbf[, unique(category)]

# fuels
fuels <- dbf[, unique(fuel)]
cat(fuels, sep = "\n")

# Coal EMEP ####
dbf[fuel == "Coal", unique(type)]

dbf[
  fuel == "Coal" &
    type == "Tier 1 Emission Factor"
] -> db_ef

db_ef
db_ef[, .N, by = pol]
# db_ef[, unique(table)]
# db_ef <- db_ef[table %in% c("Table_3-16")]

activity <- data.table(
  id = 1,
  lat = -23,
  lon = -46,
  alt = 10,
  code = "1.A.1.c",
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
#BC is % of PM2.5
fwrite(dt, "estimation/1/1.A/1.A.1/emissions/EMEP_1a1c_coal.csv")

# Coal ####
# Coking Coal ####
# Natural Gas ####
