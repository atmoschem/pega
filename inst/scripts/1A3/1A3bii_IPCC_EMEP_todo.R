# IPCC
# 1: Energy
# 1.A Fuel Combustion Activities
# 1.A.3 - IPCC Transport
# 1.A.3.a - IPCC Civil Aviation\n"
# 1.A.3.a - IPCC Civil Aviation\n1.A.3.a.i - International Aviation (International Bunkers)\n1.A.3.a.ii - Domestic Aviation\n"
# 1.A.3.a - IPCC Civil Aviation\n1.A.3.a.ii - Domestic Aviation\n
# 1.A.3.a.i - IPCC International Aviation (International Bunkers)\n
# 1.A.3.a.ii - IPCC Domestic Aviation\n
# 1.A.3.a.i.(i) - EMEP International aviation (LTO)
# 1.A.3.a.ii.(i) - EMEP "Civil aviation (domestic, LTO)
# 1.A.3.b - Road Transportation\n"
# 1.A.3.b - Road Transportation\n1.A.3.b.ii - Light-duty trucks\n1.A.3.b.iii - Heavy-duty trucks and buses\n"
# 1.A.3.b - Road Transportation\n1.A.3.b.i - Cars\n"
# "Road transport, passenger cars"
# "1.A.3.b.i - Cars\n"
# "1.A.3.b.i - Cars\n
# 1.A.3.b.ii - Light-duty trucks\n"
# "1.A.3.b.i.1 - Passenger cars with 3-way catalysts\n"
# "Road transport, light duty vehicles" "1.A.3.b.ii - Light-duty trucks\n"

library(data.table)
library(pega)

# database
db <- ef(returnfdb = T)

db[,
  grep("1.A.3.b", code, value = T)
] |>
  unique()

# database final
db[
  code == "1.A.3.b.ii"
] -> dbf

# category
dbf[, unique(category)]

# type
dbf[, unique(region), by = pol]

db[
  code == "1.A.3.b.i",
  unique(tech)
]

# TODO

# db[
#   code == "1.A.3" &
#     is.na(tech) &
#     tech2 == "Car/Taxi"
# ] -> dbf

# # fuels
# fuels <- dbf[, unique(fuel)]
# cat(fuels, sep = "\n")

# # tech ####
# dbf[, unique(tech)]

# dbf[
#   fuel == "Motor Gasoline",
# ]

# dbf[
#   fuel == "Motor Gasoline" &
#     tech2 == "Car/Taxi"
# ] -> db_ef

# db_ef

# db_ef[, unique(unit)]

# db_ef[, .N, by = pol]

# activity <- data.table(
#   id = 1,
#   lat = -23,
#   lon = -46,
#   alt = 10,
#   code = "1.A.3",
#   activity = rnorm(n = 12, mean = 500, sd = 100),
#   unit = "GJ",
#   date = seq.Date(as.Date("2020-01-01"), length.out = 12, by = "month"),
#   region = "HERE"
# )

# rbindlist(lapply(1:nrow(activity), function(i) {
#   df <- db_ef
#   df$id <- activity$id[i]
#   df$lat <- activity$lat[i]
#   df$lon <- activity$lon[i]
#   df$alt <- activity$alt[i]

#   df$activity <- activity$activity[i]
#   df$unit_activity <- activity$unit[i]
#   df$date_activity <- activity$date[i]
#   df$region <- activity$region[i]
#   df
# })) -> dt

# dt[, emissions := ef * activity]
# # BC is % of PM2.5
# # dt[pol == "PM2.5"]
# # dt[pol == "BC"]
# # dt[pol == "BC", emissions := ef / 100 * dt[pol == "PM2.5"]$emissions]
# # dt[pol == "BC"]
# fwrite(
#   dt,
#   "estimation/1/1.A/1.A.2/emissions/1A3_IPCC_motor_gasoline.csv"
# )
