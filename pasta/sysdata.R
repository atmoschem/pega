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

# units is hell, skipping!
save(sysdata, file = "R/sysdata.rda", compress = "xz")


# checking units ####
db[, unique(unit)][1:10]

db[grepl("GJ", unit), unique(unit)]

# g GJ####
db[unit == "g/GJ"]
db[unit %in% c("g/GJ", "g CH4/GJ", "g N2O/GJ", "gC/GJ Gross"), ef2 := ef]
db[unit %in% c("g/GJ", "g CH4/GJ", "g N2O/GJ", "gC/GJ Gross"), unit2 := "g/GJ"]

# mg GJ####
db[grepl("GJ", unit), unique(unit)]
db[grepl("mg", unit), unique(unit)]
grep("GJ", db[grepl("mg", unit), unique(unit)], value = T)
db[
    unit %in% c("mg/GJ"),
    ef2 := ef / 1000
]

# mg GJ####
db[grepl("GJ", unit), unique(unit)]
db[grepl("mg", unit), unique(unit)]
grep("GJ", db[grepl("mg", unit), unique(unit)], value = T)
db[
    unit %in% c("mg/GJ"),
    ef2 := ef / 1000
]


# µg GJ####
db[grepl("µ", unit), unique(unit)]
db[
    unit %in% c("µg/GJ"),
    ef2 := ef / 1000000
]
db[
    unit %in% c("µg/GJ"),
    unit2 := "g/GJ"
]

# ng GJ####
db[grepl("ng", unit), unique(unit)]
db[
    unit %in% c("ng I-TEQ/GJ", "ng WHO-TEG/GJ", "ng/GJ"),
    ef2 := ef / 1000000000
]

db[
    unit %in% c("ng I-TEQ/GJ", "ng WHO-TEG/GJ", "ng/GJ"),
    unit2 := "g/GJ"
]

db[, unique(unit)][1:10]
