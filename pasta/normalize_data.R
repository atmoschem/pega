library(data.table)

# Load current data
load("R/sysdata.rda")

# 1. Normalize EMEP (eea) -------------------------------------------------
message("Normalizing EMEP (eea)...")
eea <- as.data.table(sysdata$eea)
eea[, Value := as.numeric(Value)]

# Copy original units for reference if needed
eea[, Unit_orig := Unit]

# Standardize Energy Units to g/GJ
eea[Unit == "mg/GJ", `:=`(Value = Value / 1000, Unit = "g/GJ")]
eea[Unit == "µg/GJ", `:=`(Value = Value / 1e6, Unit = "g/GJ")]
eea[Unit == "ng/GJ", `:=`(Value = Value / 1e9, Unit = "g/GJ")]
eea[Unit %in% c("kg/TJ", "kg / TJ"), `:=`(Value = Value, Unit = "g/GJ")]

# Standardize Mass Units to g/Mg (Mg = Tonne)
eea[Unit %in% c("kg/Mg", "kg/tonne", "kg/ton"), `:=`(Value = Value * 1000, Unit = "g/Mg")]
eea[Unit == "mg/Mg", `:=`(Value = Value / 1000, Unit = "g/Mg")]
eea[Unit %in% c("g/t product", "g/Mg", "g/tonne"), `:=`(Value = Value, Unit = "g/Mg")]

# 2. Normalize IPCC (ipcc) -------------------------------------------------
message("Normalizing IPCC (ipcc)...")
ipcc <- as.data.table(sysdata$ipcc)
ipcc[, Value := as.numeric(Value)]
ipcc[, Unit_orig := Unit]

# Standardize Energy Units to g/GJ
# 1 kg/TJ = 1 g/GJ
# 1 g/GJ = 1 g/GJ
# 1 t/TJ = 1000 kg/TJ = 1000 g/GJ
ipcc[Unit %in% c("kg/TJ", "kg CH4/TJ", "kg N2O/TJ"), `:=`(Value = Value, Unit = "g/GJ")]
ipcc[Unit %in% c("g/GJ", "g CH4/GJ", "g N2O/GJ"), `:=`(Value = Value, Unit = "g/GJ")]
ipcc[Unit %in% c("t CO2/TJ", "tonne CO2/TJ", "t/TJ"), `:=`(Value = Value * 1000, Unit = "g/GJ")]
ipcc[Unit %in% c("tC/TJ", "tonne C/TJ", "tonne-C/Terajoule"), `:=`(Value = Value * 1000, Unit = "gC/GJ")]

# Standardize Mass Units to g/Mg
ipcc[Unit %in% c("kg/tonne", "kg/Mg", "kg/ton"), `:=`(Value = Value * 1000, Unit = "g/Mg")]
ipcc[Unit %in% c("g/Mg", "g/tonne"), `:=`(Value = Value, Unit = "g/Mg")]

# Special cases: Kt/Mth (Kilo-ton per month) - maybe leave as is or normalize to g/period?
# For now, we focus on the most common energy/mass factors.

# Update sysdata
sysdata$eea <- eea
sysdata$ipcc <- ipcc

# Save updated sysdata
message("Saving normalized sysdata.rda...")
save(sysdata, file = "R/sysdata.rda", compress = "xz")

message("Normalization complete!")
