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


# tonnes fuel
sysdata[grepl("tonnes fuel", unit), unique(unit)]
sysdata[
  unit %in%
    "kg/tonnes fuel"
]

sysdata[
  unit %in%
    "kg/tonnes fuel",
  ef := ef * 1000
]

sysdata[
  unit %in%
    "kg/tonnes fuel",
  unit := "g/tonnes fuel"
]

sysdata[grepl("tonnes fuel", unit), unique(unit)]

# fuel
sysdata[grepl("kg fuel", unit), unique(unit)]

sysdata[unit %in% "kg/kg fuel"]
sysdata[unit %in% "kg/kg fuel", ef := ef * 1000]
sysdata[unit %in% "kg/kg fuel", unit := "g/kg fuel"]

sysdata[unit %in% c("mg/kg fuel", "mg/ kg fuel")]
sysdata[unit %in% c("mg/kg fuel", "mg/ kg fuel"), ef := ef / 1000]
sysdata[unit %in% c("mg/kg fuel", "mg/ kg fuel"), unit := "g/kg fuel"]

sysdata[unit %in% "µg/kg fuel"]
sysdata[unit %in% "µg/kg fuel", ef := ef / 1000000]
sysdata[unit %in% "µg/kg fuel", unit := "g/kg fuel"]

sysdata[grepl("kg fuel", unit), unique(unit)]
"mg/ kg fuel"
"mg/kg fuel"
"µg/kg fuel"


# clink
sysdata[grepl("clinker", unit), unique(unit)]

sysdata[unit %in% "µg/te clinker"]
sysdata[unit %in% "µg/te clinker", ef := ef * 1e-6]
sysdata[unit %in% "µg/te clinker", unit := "g/te clinker"]

sysdata[unit %in% c("ng I-TEQ/te clinker")]
sysdata[unit %in% c("ng I-TEQ/te clinker"), ef := ef * 1e-9]
sysdata[unit %in% c("ng I-TEQ/te clinker"), unit := "g I-TEQ/te clinker"]


sysdata[unit %in% "tonne CO2/tonne clinker produced"]
sysdata[unit %in% "tonne CO2/tonne clinker produced", ef := ef * 1e6]
sysdata[unit %in% "tonne CO2/tonne clinker produced", unit := "g/te clinker"]

sysdata[,
  unit := gsub(pattern = "te clinker", replacement = "Mg clinker", x = unit)
]

# clink
sysdata[grepl("J", unit), unique(unit)]
# g/MJ
# "tC/TJ"
# "gC/GJ Gross"
# "gC/MJ"
sysdata[unit %in% c("g/MJ", "tC/TJ", "gC/GJ Gross", "gC/MJ")]
sysdata[unit %in% c("g/MJ", "tC/TJ", "gC/GJ Gross", "gC/MJ"), ef := ef * 1e-3]
sysdata[unit %in% c("g/MJ", "tC/TJ", "gC/GJ Gross", "gC/MJ"), unit := "g/GJ"]

# "kg CH4/TJ"
# "kgN2O/TJ"
sysdata[unit %in% c("kg CH4/TJ", "kgN2O/TJ")]
sysdata[unit %in% c("kg CH4/TJ", "kgN2O/TJ"), unit := "g/GJ"]

# "tonne C / GJ feedstock"
# "tonnes N2O / GJ BFG flared"
# "tonnes N2O / GJ LDG flared"
sysdata[
  unit %in%
    c(
      "tonne C / GJ feedstock",
      "tonnes N2O / GJ BFG flared",
      "tonnes N2O / GJ LDG flared"
    )
]
sysdata[
  unit %in%
    c(
      "tonne C / GJ feedstock",
      "tonnes N2O / GJ BFG flared",
      "tonnes N2O / GJ LDG flared"
    ),
  ef := ef * 1e6
]
sysdata[
  unit %in%
    c(
      "tonne C / GJ feedstock",
      "tonnes N2O / GJ BFG flared",
      "tonnes N2O / GJ LDG flared"
    ),
  unit := "g/GJ"
]

# tonne
sysdata[grepl("/tonne", unit), unique(unit)]
sysdata[
  unit %in%
    c(
      "g/tonne sinter",
      "g/tonne sinter",
      "g/tonne pig iron",
      "g/tonne pellet",
      "g/tonnes fuel",
      "g N2O /tonne waste",
      "g CH4/tonne coke produced",
      "gCH4/tonne waste",
      "gCH4/tonne",
      "g/tonne RE metal",
      "g CH4/tonne waste",
      "g N2O /tonne wet waste",
      "g/tonnes steel produced",
      "g/tonne fuel"
    ),
  unit := "g/tonne"
]

sysdata[grepl("/tonne", unit), unique(unit)]

sysdata[
  unit %in%
    c(
      "kg/tonne fuel",
      "kg/tonne",
      "kg/tonne carbon black",
      "kg/tonne Al",
      "kg CF4 /tonne Al",
      "kg CH4/tonne of coke produced",
      "kg CH4/tonne of sinter produced",
      "kg/tonne ore",
      "kg CO2-eq./tonne wet waste",
      "kg CO2-eq./tonne ww",
      "kg CH4/tonne sinter produced",
      "kg CH4/tonne ferroalloy produced",
      "kg C2F6 /tonne Al",
      "kg SF6/tonne magnesium casting",
      "kg CH4/tonne of ethylene oxide produced",
      "kg CH4/tonne of acrylonitrile produced",
      "kg acetonitrile/tonne acrylonitrile",
      "kg hydrogen cyanide/tonne acrylonitrile",
      "kg CH4/tonne of carbon black produced",
      "[kg CF4/tonne Al] / [AE-Mins/cell-day]",
      "kg CH4/tonne of ethylene produced",
      "kg CH4/tonne of methanol produced",
      "kg CO2/tonnes steel produced",
      "kg/tonne adipic acid produced",
      "kg/tonnes metal",
      "kg/tonnes product",
      "kg C2F6/tonne Al",
      "kg SF6/tonnes magnesium produced or smelted",
      "kg N2O/tonne adipic acid production",
      "kg N2O/tonne nitric acid produced",
      "kg SO2/tonne cement produced",
      "kg CO2/tonne limestone",
      "kg CO2/tonne dolomite",
      "kg CO2/tonne of soda ash used",
      "kg NMVOC/tonne of asphalt roofing produced",
      "kg CO/tonne of asphalt roofing produced",
      "kg CO/tonne of asphalt",
      "kg SO2/tonne of asphalt",
      "kg NO2/tonne of asphalt",
      "kg NMVOC/tonne of asphalt",
      "kg NMVOC/tonne of glass produced",
      "kg SO2/tonne of concrete pumice stone produced",
      "kg SO2/tonne NH3 produced",
      "kg CO/tonne NH3 produced",
      "kg NOx/tonne nitric acid produced",
      "kg NOx/tonne adipic acid produced",
      "kg CO/tonne adipic acid produced",
      "kg NMVOC/tonne adipic acid produced",
      "kg CH4/tonne petrol coke consumed",
      "kg CH4/tonne silicon carbide produced",
      "kg/tonne Sulphur",
      "kg CH4/tonne of vinyl chloride monomer produced",
      "kg N2O/tonne caprolactam produced"
    ),
  unit := "kg/tonne"
]
sysdata[unit %in% c("kg/tonne"), ef := ef * 1e3]
sysdata[unit %in% c("kg/tonne"), unit := "g/tonne"]

sysdata[grepl("/tonne", unit), unique(unit)] |> cat(sep = "\n")

sysdata[grepl("/tonne", unit), unique(unit)]

sysdata[
  unit %in%
    c(
      "tonnes CO2/tonnes quicklime produced",
      "tonnes CO2/tonnes dolomitic lime",
      "Tonne CO2/tonne NH3 produced",
      "tonne CO2/tonne carbide produced",
      "tonne CO2/tonne carbide used",
      "tonne CO2/tonne Al",
      "tonne CO2/tonne high calcium lime produced",
      "tonne CO2/tonne lime produced",
      "tonne CO2/tonne cement produced",
      "tonnes CO2/tonne of trona",
      "tonne CO2/tonne petrol coke consumed",
      "tonne CO2/tonne carbonate",
      "tonne CO2/tonne glass",
      "tonne CO2/tonne titanium dioxide produced",
      "tonne CO2/tonne of soda ash produced",
      "tonne CO2/tonne of methanol produced",
      "tonne CO2/tonne of ethylene produced",
      "tonne CO2/tonne of ethylene dichloride produced",
      "tonne CO2/tonne of vinyl chloride monomer produced",
      "tonne ethylene/tonne of ethylene dichloride produced",
      "tonne ethylene/tonne of vinyl chloride monomer produced",
      "tonne CO2/tonne of ethylene oxide produced",
      "tonne CO2/tonne coke produced",
      "tonne CO2/tonne sinter produced",
      "tonne CO2/tonne pig iron produced",
      "tonne CO2/tonne DRI produced",
      "tonne CO2/tonne pellet produced",
      "tonne CO2/tonne steel produced",
      "tonne CO2/tonne primary Mg produced",
      "tonne CO2/tonne lead produced",
      "tonne CO2/tonne zinc produced",
      "tonnes C/tonne dry matter",
      "tonne root d.m./tonne shoot d.m.",
      "tonnes C/tonne air-dry peat",
      "tonne/tonne waste",
      "tonnes biomass/tonne stem biomass",
      "t CH4/tonne of material processed",
      "t N2O/tonne of material processed",
      "tonne/tonne",
      "tonne of CO2/tonne of sinter",
      "tonne CO2/tonne of hot metal",
      "tonne CO2/tonne of steel produced",
      "tonnes C/tonne",
      "tonnes CO2/tonne RE metal",
      "tonne CO2/tonne of acrylonitrile produced",
      "tonne CO2/tonne of carbon black produced",
      "tonne CO2/tonne ferroalloy produced"
    ),
  unit := "Mg/tonne"
]
sysdata[unit %in% c("Mg/tonne"), ef := ef * 1e6]
sysdata[unit %in% c("Mg/tonne"), unit := "g/tonne"]


sysdata[unit %in% "mg/tonne fuel", ef := ef * 1e-3]
sysdata[unit %in% "mg/tonne fuel", unit := "g/tonne"]


sysdata[
  unit %in% c("ug I-TEQ/tonne", "ug I-TEQ/tonne fuel"),
  unit := "ug/tonne"
]
sysdata[unit %in% "ug/tonne", ef := ef * 1e-6]
sysdata[unit %in% "ug/tonne", unit := "g/tonne"]

sysdata[grepl("/tonne", unit), unique(unit)]

save(sysdata, file = "R/sysdata.rda", compress = "xz")
