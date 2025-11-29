library(data.table)
load("R/sysdata.rda")
ipcc <- sysdata$ipcc
names(ipcc) <- gsub("  ", "", names(ipcc))
names(ipcc) <- gsub(" ", "_", names(ipcc))
ipcc[, unique(IPCC_2006_SourceSink_Category)]

ipcc[, NFR := substr(x = IPCC_2006_SourceSink_Category, start = 0, stop = 12)]

ipcc[, unique(NFR)]

ipcc[, NFR := tstrsplit(NFR, " - ", keep = 1)]

ipcc[NFR == "1"]

ipcc[NFR == "1", unique(IPCC_2006_SourceSink_Category)]

ipcc[NFR == "1", NFR := "1.A"]

ipcc[, unique(NFR)]

ipcc[, NFR := gsub(" -", "", NFR)]

#ipcc$Nf <- NULL
ipcc$pol <- NULL

sysdata$ipcc <- ipcc

unique(ipcc$NFR)

ipcc[is.na(NFR), unique(IPCC_1996_SourceSink_Category)]

ipcc[
  is.na(NFR),
  NFR := tstrsplit(IPCC_1996_SourceSink_Category, " - ", keep = 1)
]

unique(ipcc$NFR)

ipcc[, unique(Gas)]

ipcc[, Pollutant := gsub("\n", " ", Gas)]

ipcc[,
  Pollutant := gsub("NON METHANE VOLATILE ORGANIC COMPOUNDS", "NMHC", Pollutant)
]

ipcc[, Pollutant := gsub("AMONIA", "NM3", Pollutant)]

ipcc[, Pollutant := gsub("AMMONIA", "NM3", Pollutant)]

ipcc[, Pollutant := gsub("METHANE", "CH4", Pollutant)]

ipcc[, Pollutant := gsub("CARBON DIOXIDE", "CO2", Pollutant)]

ipcc[, Pollutant := gsub("SULPHUR DIOXIDE", "SO2", Pollutant)]

ipcc[, Pollutant := gsub("NITROGEN OXIDES", "NOX", Pollutant)]

ipcc[, Pollutant := gsub("CARBON MONOXIDE", "CO", Pollutant)]

ipcc[, Pollutant := gsub("Nitrogen Trifluoride ", "NF3", Pollutant)]

ipcc[, Pollutant := gsub("Sulphur Hexafluoride ", "SH6", Pollutant)]

ipcc[, Pollutant := gsub("NITROUS OXIDE ", "N2O", Pollutant)]

ipcc[, Pollutant := gsub("  ", " ", Pollutant)]

ipcc[, unique(Pollutant)]

ipcc[, Pollutant := trimws(Pollutant, which = "both")]

save(sysdata, file = "R/sysdata.rda", compress = "xz")
