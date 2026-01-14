library(data.table)
library(sf)
library(pega)

emep <- pega::ef_emep(returnfdb = T)
emep$Value <- as.numeric(emep$Value)
emep[NFR == "1.A.1.a" &
    # Pollutant == "CO" &
    Fuel == "Gas Oil"] -> ef_emep_oil

ef_emep_oil

"mdaEnergiaDespachadaGWh"
