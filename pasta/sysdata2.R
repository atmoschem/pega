library(data.table)

emep <- fread("db/EMEP_20260207.csv")
emep

ipcc <- readxl::read_excel("db/IPCC_EFDB_output_20260207.xlsx")
setDT(ipcc)
ipcc

# checking names of columns to merge one data.table

names(emep)
names(ipcc)
emep$source <- "EMEP"
ipcc$source <- "IPCC"

emep$category <- emep$Sector
ipcc$category <- ipcc$`IPCC 2006 Source/Sink Category`

emep$type <- emep$Type
ipcc$type <- ipcc$`Type of parameter`

emep$tech <- emep$Technology
ipcc$tech <- ipcc$`Technologies / Practices`

emep$table <- emep$Table
ipcc$table <- ipcc$`Technical Reference`

emep$code <- emep$NFR
ipcc$code <- ipcc$`IPCC 2006 Source/Sink Category`

emep$codetype <- "NFR"
ipcc$codetype <- "IPCC 2006"

emep$fuel <- emep$Fuel
ipcc$fuel <- ipcc$`Fuel 2006`

emep$tech2 <- emep$Abatement
ipcc$tech2 <- ipcc$`Parameters / Conditions`


emep$ef <- emep$Value
ipcc$ef <- ipcc$Value

emep$unit <- emep$Unit
ipcc$unit <- ipcc$Unit

emep$reference <- emep$Reference
ipcc$reference <- ipcc$`Technical Reference`

emep$pol <- emep$Pollutant
ipcc$pol <- ipcc$Gas

emep$region <- emep$Region
ipcc$region <- ipcc$`Region / Regional Conditions`

emep$other <- emep$Abatement
ipcc$other <- ipcc$`Other properties`


ipcc[, unique(code)]

ipcc[, code := substr(x = code, start = 0, 15)]

ipcc[,
  c("code", "borrar", "bo") := tstrsplit(code, "-", fixed = TRUE, fill = NA)
]

ipcc$borrar <- NULL
ipcc$bo <- NULL

nx <- intersect(names(emep), names(ipcc))

sysdata <- rbind(
  emep[, nx, with = F],
  ipcc[, nx, with = F]
)
sysdata[, unique(code)]
sysdata[, code := gsub(" ", "", code)]

sysdata[, unique(ef)]
sysdata$ef <- as.numeric(sysdata$ef)

sysdata[, unique(pol)]

sysdata[, pol := gsub("\n", " ", pol)]

sysdata[, pol := gsub("NON METHANE VOLATILE ORGANIC COMPOUNDS", "NMVOC", pol)]

sysdata[, pol := gsub("NITROUS OXIDE ", "N2O", pol)]
sysdata[, pol := gsub("NITROUS OXIDE", "N2O", pol)]

sysdata[, pol := gsub("CARBON DIOXIDE ", "CO2", pol)]
sysdata[, pol := gsub("CARBON DIOXIDE", "CO2", pol)]

sysdata[, pol := gsub("CARBON MONOXIDE ", "CO", pol)]
sysdata[, pol := gsub("CARBON MONOXIDE", "CO", pol)]

sysdata[, pol := gsub("METHANE ", "CH4", pol)]
sysdata[, pol := gsub("METHANE", "CH4", pol)]

sysdata[, pol := gsub("NITROGEN OXIDES (NO+NO2) ", "NOx", pol)]

sysdata[, pol := gsub("NITROGEN OXIDES (NO+NO2)", "NOx", pol)]

sysdata[, pol := gsub("SULPHUR DIOXIDE (SO2+SO3) ", "SOx", pol)]

sysdata[, pol := gsub("SULPHUR DIOXIDE (SO2+SO3)", "SOx", pol)]

sysdata[, pol := gsub("Nitrogen Trifluoride ", "NF3", pol)]

sysdata[, pol := gsub("NF3", "NF3", pol)]

sysdata[, pol := gsub("a ", "a", pol)]

sysdata[, pol := gsub("Total PAHs", "PAH", pol)]

sysdata[, pol := gsub("Sulphur Hexafluoride ", "SF6", pol)]

sysdata[, pol := gsub("4 ", "4", pol)]
sysdata[, pol := gsub("6 ", "6", pol)]
sysdata[, pol := gsub("2 ", "2", pol)]
sysdata[, pol := gsub("5 ", "5", pol)]
sysdata[, pol := gsub("1 ", "1", pol)]
sysdata[, pol := gsub("0 ", "0", pol)]
sysdata[, pol := gsub("c ", "c", pol)]

sysdata[, pol := gsub("AMMONIA ", "NH3", pol)]

sysdata[, pol := gsub("CH4CO2 ", "CH4 CO2", pol)]

sysdata[, pol := gsub("CH4CO2", "CH4 CO2", pol)]

sysdata[, unique(pol)]

names(sysdata)

# category
sysdata[, unique(category)]

sysdata[, unique(type)]

sysdata[, unique(tech)]

sysdata[, unique(table)]

sysdata[, unique(code)]

sysdata[, unique(codetype)]

sysdata[, unique(fuel)]

sysdata[, unique(tech2)]

sysdata[grep("Natural", fuel), unique(fuel)]

sysdata[grep("Natural", fuel), fuel := "Natural Gas"]

sysdata[grep("il", fuel), unique(fuel)]
sysdata[
  fuel %in% c("Gas Oil", "Gas/Oil", "Gas Oil/Diesel", "Gas oil", "Oil/gas"),
  unique(fuel)
]

sysdata[
  fuel %in% c("Gas Oil", "Gas/Oil", "Gas Oil/Diesel", "Gas oil", "Oil/gas"),
  fuel := "Oil Gas"
]

sysdata[grepl("GJ", unit), unique(unit)]
sysdata[unit %in% c("g N2O/GJ", "g CH4/GJ")]
sysdata[
  unit %in% c("g N2O/GJ", "g CH4/GJ", "ng/J of Fuel"),
  unit := "g/GJ"
]


sysdata[unit == "mg/GJ", unique(unit)]
sysdata[unit == "mg/GJ", ef := ef / 1000]
sysdata[unit == "mg/GJ", unit := "g/GJ"]

sysdata[unit %in% c("ng/GJ", "ng I-TEQ/GJ", "I-Teq ng/GJ")]
sysdata[
  unit %in% c("ng/GJ", "ng I-TEQ/GJ", "I-Teq ng/GJ"),
  ef := ef / 1000000000
]
sysdata[
  unit %in% c("ng/GJ", "ng I-TEQ/GJ", "I-Teq ng/GJ", "ng WHO-TEG/GJ"),
  unit := "g/GJ"
]

sysdata[unit %in% c("µg/GJ", "ug/GJ")]
sysdata[unit %in% c("µg/GJ", "ug/GJ"), ef := ef / 1000000]
sysdata[unit %in% c("µg/GJ", "ug/GJ"), unit := "g/GJ"]

sysdata[unit %in% c("kg/GJ", "kg CO2/GJ", "CO2 kg/GJ", "Mg/TJ")]
sysdata[
  unit %in% c("kg/GJ", "kg CO2/GJ", "CO2 kg/GJ", "Mg/TJ"),
  ef := ef * 1000
]
sysdata[unit %in% c("kg/GJ", "kg CO2/GJ", "CO2 kg/GJ", "Mg/TJ"), unit := "g/GJ"]

sysdata[unit %in% c("kg/TJ", "KG/TJ"), unit := "g/GJ"]

sysdata[grepl("GJ", unit), unique(unit)]

# crude
sysdata[grepl("crude", unit), unique(unit)]
sysdata[
  unit %in%
    c(
      "kg/Mg crude oil input",
      "kg/Mg crude oil throughput",
      "kg/Mg crude oil throughput",
      "kg/Mg crude oil"
    )
]

sysdata[
  unit %in%
    c(
      "kg/Mg crude oil input",
      "kg/Mg crude oil throughput",
      "kg/Mg crude oil throughput",
      "kg/Mg crude oil"
    ),
  ef := ef * 1000
]

sysdata[
  unit %in%
    c(
      "kg/Mg crude oil input",
      "kg/Mg crude oil throughput",
      "kg/Mg crude oil throughput",
      "kg/Mg crude oil"
    ),
  unit := "g/Mg crude oil"
]

sysdata[grepl("crude", unit), unique(unit)]

sysdata[unit %in% c("mg/Mg crude oil input")]
sysdata[
  unit %in% c("mg/Mg crude oil input"),
  ef := ef / 1000
]
sysdata[
  unit %in% c("mg/Mg crude oil input"),
  unit := "g/Mg crude oil"
]

sysdata[grepl("crude", unit), unique(unit)]

sysdata[unit %in% c("µg/Mg crude oil input", "μg/Mg crude oil input")]
sysdata[
  unit %in% c("µg/Mg crude oil input", "μg/Mg crude oil input"),
  ef := ef / 1000000
]
sysdata[
  unit %in% c("µg/Mg crude oil input", "μg/Mg crude oil input"),
  unit := "g/Mg crude oil"
]
sysdata[grepl("crude", unit), unique(unit)]

sysdata[
  unit %in% c("g/Mg crude oil input", "g/MG crude oil input"),
  unit := "g/Mg crude oil"
]


sysdata[grepl("crude", unit), unique(unit)]

sysdata[unit %in% c("t CO2/TJ")]
sysdata[
  unit %in% c("t CO2/TJ"),
  ef := ef * 1000
]
sysdata[
  unit %in% c("t CO2/TJ"),
  unit := "g/GJ"
]
sysdata[grepl("crude", unit), unique(unit)]

sysdata[
  unit %in% c("g/Mg crude oil input", "g/MG crude oil input"),
  unit := "g/Mg crude oil"
]

save(sysdata, file = "R/sysdata.rda", compress = "xz")
