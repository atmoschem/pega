
# PEGA <img src="man/figures/logo.png" align="right" alt="" width="220" />

- Poluentes, Emissões e Gases de Atmosfera.
- Pollutants Emissions and Gaseous of the Atmosphere.

## Installation

Using git bash/powershell

``` bash
git clone https://github.com/atmoschem/pega
R CMD INSTALL pega
```

Using remotes R package

``` r
remotes::install_github("atmoschem/pega")
```

``` r
library(pega)
library(data.table)
utils::packageVersion("pega")
```

    ## [1] '0.6.0'

## Emission factors

### EMEP

``` r
library(pega)
ef_emep(tier = 1, fuel = "Natural gas", pol = "PM2.5")
```

    ##        NFR                                 Sector     Table
    ##     <char>                                 <char>    <char>
    ## 1: 1.A.1.a Public electricity and heat production Table_3-4
    ##                      Type Technology        Fuel Abatement Region Pollutant
    ##                    <char>     <char>      <char>    <char> <char>    <char>
    ## 1: Tier 1 Emission Factor       <NA> Natural gas             <NA>     PM2.5
    ##     Value   Unit CI_lower CI_upper                  Reference tiers
    ##    <char> <char>    <num>    <num>                     <char> <num>
    ## 1:   0.89   g/GJ    0.445     1.33 US EPA (1998), chapter 1.4     1

### IPCC

``` r
ef_ipcc(fuel = "Natural Gas", pol = "CH4")
```

    ##      EF_ID
    ##     <char>
    ##  1:  17190
    ##  2:  18401
    ##  3:  18402
    ##  4:  18403
    ##  5: 117696
    ##  6: 120947
    ##  7: 120948
    ##  8: 120951
    ##  9: 120952
    ## 10: 120955
    ##                                                                                                                                                                            IPCC_1996_SourceSink_Category
    ##                                                                                                                                                                                                   <char>
    ##  1:                                                                                                                                                                            1A1 - Energy Industries\n
    ##  2: 1A1 - Energy Industries\n1A1a - Public Electricity and Heat Production\n1A1a1 - Public Electricity Generation\n1A1a2 - Public Combined Heat and Power Generation (CHP)\n1A1a3 - Public Heat Plants\n
    ##  3: 1A1 - Energy Industries\n1A1a - Public Electricity and Heat Production\n1A1a1 - Public Electricity Generation\n1A1a2 - Public Combined Heat and Power Generation (CHP)\n1A1a3 - Public Heat Plants\n
    ##  4: 1A1 - Energy Industries\n1A1a - Public Electricity and Heat Production\n1A1a1 - Public Electricity Generation\n1A1a2 - Public Combined Heat and Power Generation (CHP)\n1A1a3 - Public Heat Plants\n
    ##  5:                                                                                                                                                                            1A1 - Energy Industries\n
    ##  6:                                                                                                                    1A1 - Energy Industries\n1A2 - Manufacturing Industries and Construction (ISIC)\n
    ##  7:                                                                                                                    1A1 - Energy Industries\n1A2 - Manufacturing Industries and Construction (ISIC)\n
    ##  8:                                                                                                                    1A1 - Energy Industries\n1A2 - Manufacturing Industries and Construction (ISIC)\n
    ##  9:                                                                                                                    1A1 - Energy Industries\n1A2 - Manufacturing Industries and Construction (ISIC)\n
    ## 10:                                                                                                                    1A1 - Energy Industries\n1A2 - Manufacturing Industries and Construction (ISIC)\n
    ##                                                                                                                                                                                  IPCC_2006_SourceSink_Category
    ##                                                                                                                                                                                                         <char>
    ##  1:                                                                                                                                                                                1.A.1 - Energy Industries\n
    ##  2: 1.A.1 - Energy Industries\n1.A.1.a - Main Activity Electricity and Heat Production\n1.A.1.a.i - Electricity Generation\n1.A.1.a.ii - Combined Heat and Power Generation (CHP)\n1.A.1.a.iii - Heat Plants\n
    ##  3: 1.A.1 - Energy Industries\n1.A.1.a - Main Activity Electricity and Heat Production\n1.A.1.a.i - Electricity Generation\n1.A.1.a.ii - Combined Heat and Power Generation (CHP)\n1.A.1.a.iii - Heat Plants\n
    ##  4: 1.A.1 - Energy Industries\n1.A.1.a - Main Activity Electricity and Heat Production\n1.A.1.a.i - Electricity Generation\n1.A.1.a.ii - Combined Heat and Power Generation (CHP)\n1.A.1.a.iii - Heat Plants\n
    ##  5:                                                                                                                                                                                1.A.1 - Energy Industries\n
    ##  6:                                                                                                                             1.A.1 - Energy Industries\n1.A.2 - Manufacturing Industries and Construction\n
    ##  7:                                                                                                                             1.A.1 - Energy Industries\n1.A.2 - Manufacturing Industries and Construction\n
    ##  8:                                                                                                                             1.A.1 - Energy Industries\n1.A.2 - Manufacturing Industries and Construction\n
    ##  9:                                                                                                                             1.A.1 - Energy Industries\n1.A.2 - Manufacturing Industries and Construction\n
    ## 10:                                                                                                                             1.A.1 - Energy Industries\n1.A.2 - Manufacturing Industries and Construction\n
    ##           Gas   Fuel_1996   Fuel_2006 C_pool     Type_of_parameter
    ##        <char>      <char>      <char> <lgcl>                <char>
    ##  1: METHANE\n Natural Gas Natural Gas     NA     1996 IPCC default
    ##  2: METHANE\n Natural Gas Natural Gas     NA     1996 IPCC default
    ##  3: METHANE\n Natural Gas Natural Gas     NA     1996 IPCC default
    ##  4: METHANE\n Natural Gas Natural Gas     NA     1996 IPCC default
    ##  5: METHANE\n Natural Gas Natural Gas     NA     2006 IPCC default
    ##  6: METHANE\n Natural Gas Natural Gas     NA Other (e.g. compiled)
    ##  7: METHANE\n Natural Gas Natural Gas     NA Other (e.g. compiled)
    ##  8: METHANE\n Natural Gas Natural Gas     NA Other (e.g. compiled)
    ##  9: METHANE\n Natural Gas Natural Gas     NA Other (e.g. compiled)
    ## 10: METHANE\n Natural Gas Natural Gas     NA Other (e.g. compiled)
    ##                                                                        Description
    ##                                                                             <char>
    ##  1:                                     CH4 Default (Uncontrolled) emisson factors
    ##  2:                          Emission factors for utility boiler source perfomance
    ##  3:                          Emission factors for utility boiler source perfomance
    ##  4:                          Emission factors for utility boiler source perfomance
    ##  5: CH4 Emission Factor for Stationary Combustion (kg/TJ on a net calorific basis)
    ##  6:                                      Emission Factor for Stationary Combustion
    ##  7:                                      Emission Factor for Stationary Combustion
    ##  8:                                      Emission Factor for Stationary Combustion
    ##  9:                                      Emission Factor for Stationary Combustion
    ## 10:                                      Emission Factor for Stationary Combustion
    ##                            TechnologiesPractices
    ##                                           <char>
    ##  1:                                         <NA>
    ##  2:                                      Boilers
    ##  3:             Large Gas-Fired Gas Turbines>3MW
    ##  4:                      Large Dual-Fuel Engines
    ##  5:                                         <NA>
    ##  6:                             Gas fired boiler
    ##  7:                             Gas fired boiler
    ##  8: Gas turbine plant/Combined cycle power plant
    ##  9: Gas turbine plant/Combined cycle power plant
    ## 10:                        Otto or diesel engine
    ##                                                                                                                                                        ParametersConditions
    ##                                                                                                                                                                      <char>
    ##  1:                                                                                                                                                                    <NA>
    ##  2:                                                                                                                                                                    <NA>
    ##  3:                                                                                                                                                                    <NA>
    ##  4:                                                                                                                                                                    <NA>
    ##  5:                                                                                                                                                                    <NA>
    ##  6: Co-firing when gas is the main fuel (greater than 80% gas) and (50%-80% gas). In Finland, co-firing of different types of fuels is very common in, e.g. fluidized beds.
    ##  7: Co-firing when gas is the main fuel (greater than 80% gas) and (50%-80% gas). In Finland, co-firing of different types of fuels is very common in, e.g. fluidized beds.
    ##  8:                                                                                                                                                                    <NA>
    ##  9:                                                                                                                                                                    <NA>
    ## 10:                                                                                                                                                                    <NA>
    ##     RegionRegional_Conditions AbatementControl_Technologies
    ##                        <char>                        <char>
    ##  1:                      <NA>                          <NA>
    ##  2:                      <NA>                          <NA>
    ##  3:                      <NA>                          <NA>
    ##  4:                      <NA>                          <NA>
    ##  5:                      <NA>                          <NA>
    ##  6:                   Finland                          <NA>
    ##  7:                   Finland                          <NA>
    ##  8:                   Finland                          <NA>
    ##  9:                   Finland                          <NA>
    ## 10:                   Finland                          <NA>
    ##                Other_properties  Value   Unit
    ##                          <char> <char> <char>
    ##  1:                        <NA>      1  KG/TJ
    ##  2:                        <NA>    0.1  KG/TJ
    ##  3:                        <NA>      6  KG/TJ
    ##  4:                        <NA>    240  KG/TJ
    ##  5:                        <NA>      1  kg/TJ
    ##  6: Capacity greater than  1 MW      1  kg/TJ
    ##  7: Capacity smaller than  1 MW      5  kg/TJ
    ##  8: Capacity smaller than  5 MW      3  kg/TJ
    ##  9: Capacity greater than  5 MW      1  kg/TJ
    ## 10:               not specified    240  kg/TJ
    ##                                                                                                                                                                                                                                                   Equation
    ##                                                                                                                                                                                                                                                     <char>
    ##  1:                                                                                                                                                                                                                                                   <NA>
    ##  2:                                                                                                                                                                                                                                                   <NA>
    ##  3:                                                                                                                                                                                                                                                   <NA>
    ##  4:                                                                                                                                                                                                                                                   <NA>
    ##  5:                                                                                                                                                           Equation 2.1 in Volume 2 of the 2006 IPCC Guidelines for National Greenhouse Gas Inventories
    ##  6: Emissions of installation  = sum (Fuel [TJ] * EFTechnology [t/TJ]), where Fuel = each fuel batch of installation in TJ,  (Technology) is a combination of installation type+combustion technique, fuel capacity and main fuel. (Bottom-up calculation)
    ##  7: Emissions of installation  = sum (Fuel [TJ] * EFTechnology [t/TJ]), where Fuel = each fuel batch of installation in TJ,  (Technology) is a combination of installation type+combustion technique, fuel capacity and main fuel. (Bottom-up calculation)
    ##  8: Emissions of installation  = sum (Fuel [TJ] * EFTechnology [t/TJ]), where Fuel = each fuel batch of installation in TJ,  (Technology) is a combination of installation type+combustion technique, fuel capacity and main fuel. (Bottom-up calculation)
    ##  9: Emissions of installation  = sum (Fuel [TJ] * EFTechnology [t/TJ]), where Fuel = each fuel batch of installation in TJ,  (Technology) is a combination of installation type+combustion technique, fuel capacity and main fuel. (Bottom-up calculation)
    ## 10: Emissions of installation  = sum (Fuel [TJ] * EFTechnology [t/TJ]), where Fuel = each fuel batch of installation in TJ,  (Technology) is a combination of installation type+combustion technique, fuel capacity and main fuel. (Bottom-up calculation)
    ##                                                                                                        IPCC_Worksheet
    ##                                                                                                                <char>
    ##  1:                                                                                          Worksheet 1-3; Sheet 1-3
    ##  2:                                                                                                    Not Applicable
    ##  3:                                                                                                    Not Applicable
    ##  4:                                                                                                    Not Applicable
    ##  5: 1A, Sheet 3 of 4 (page A1.8) in Annex 1 of Volume 2, 2006 IPCC Guidelines for National Greenhouse Gas Inventories
    ##  6:                                                                                                              <NA>
    ##  7:                                                                                                              <NA>
    ##  8:                                                                                                              <NA>
    ##  9:                                                                                                              <NA>
    ## 10:                                                                                                              <NA>
    ##                                                                                                                                                                                                                                                                                                                   Technical_Reference
    ##                                                                                                                                                                                                                                                                                                                                <char>
    ##  1: These CH4 default emission factors are based on CORINAIR90 database, the CORINAIR1994 default emissionf actors, EDGAR Version 2.0 database, National Communications to the UNFCCC,Berdowski, et al(1993 ),Radian Corporation (1990) and USEPA(1995). Additional research is needed to improve the quality of the emission factors
    ##  2:                                                                                                                                                                                                                 US EPA (1995) Compilation of Air Pollutant Emission Factors. Vol 1 Stationary Point and Area Sources, 5th Edition
    ##  3:                                                                                                                                                                                                                 US EPA (1995) Compilation of Air Pollutant Emission Factors. Vol 1 Stationary Point and Area Sources, 5th Edition
    ##  4:                                                                                                                                                                                                                 US EPA (1995) Compilation of Air Pollutant Emission Factors. Vol 1 Stationary Point and Area Sources, 5th Edition
    ##  5:                                                                                                                                                            Expert judgement by the authors of Chapter 2, Volume 2 of the 2006 IPCC Guidelines. For details, see Section 2.3.2.1, Chapter 2, Volume 2 of the 2006 IPCC Guidelines.
    ##  6:                                                        Finnish NIR 2008. Expert estimates by Statistics Finland based mainly on the VTT studies (Tsupari et. al., 2005, Tsupari et. al., 2006 and Tsupari et al., 2007); http://www.vtt.fi/inf/pdf/tiedotteet/2005/T2321.pdf http://www.vtt.fi/inf/pdf/workingpapers/2006/W43.pdf
    ##  7:                                                        Finnish NIR 2008. Expert estimates by Statistics Finland based mainly on the VTT studies (Tsupari et. al., 2005, Tsupari et. al., 2006 and Tsupari et al., 2007); http://www.vtt.fi/inf/pdf/tiedotteet/2005/T2321.pdf http://www.vtt.fi/inf/pdf/workingpapers/2006/W43.pdf
    ##  8:                                                        Finnish NIR 2008. Expert estimates by Statistics Finland based mainly on the VTT studies (Tsupari et. al., 2005, Tsupari et. al., 2006 and Tsupari et al., 2007); http://www.vtt.fi/inf/pdf/tiedotteet/2005/T2321.pdf http://www.vtt.fi/inf/pdf/workingpapers/2006/W43.pdf
    ##  9:                                                        Finnish NIR 2008. Expert estimates by Statistics Finland based mainly on the VTT studies (Tsupari et. al., 2005, Tsupari et. al., 2006 and Tsupari et al., 2007); http://www.vtt.fi/inf/pdf/tiedotteet/2005/T2321.pdf http://www.vtt.fi/inf/pdf/workingpapers/2006/W43.pdf
    ## 10:                                                        Finnish NIR 2008. Expert estimates by Statistics Finland based mainly on the VTT studies (Tsupari et. al., 2005, Tsupari et. al., 2006 and Tsupari et al., 2007); http://www.vtt.fi/inf/pdf/tiedotteet/2005/T2321.pdf http://www.vtt.fi/inf/pdf/workingpapers/2006/W43.pdf
    ##                                                                                                              Source_of_data
    ##                                                                                                                      <char>
    ##  1:   Revised 1996 IPCC Guidelines for National Greenhouse Gas Inventories (Table 1-7 on Page 1.35 of the Reference Manual)
    ##  2: Revised 1996 IPCC Guidelines for National Greenhouse Gas Inventories ( Table 1-15 on Page 1.53) of the Reference Manual
    ##  3: Revised 1996 IPCC Guidelines for National Greenhouse Gas Inventories ( Table 1-15 on Page 1.53) of the Reference Manual
    ##  4: Revised 1996 IPCC Guidelines for National Greenhouse Gas Inventories ( Table 1-15 on Page 1.53) of the Reference Manual
    ##  5:                               2006 IPCC Guidelines for National Greenhouse Gas Inventories, Volume 2: Energy, Table 2.2
    ##  6:                                                                                     National Inventory Report (Annex I)
    ##  7:                                                                                     National Inventory Report (Annex I)
    ##  8:                                                                                     National Inventory Report (Annex I)
    ##  9:                                                                                     National Inventory Report (Annex I)
    ## 10:                                                                                     National Inventory Report (Annex I)
    ##                              Data_provider           NF    NFR Pollutant
    ##                                     <char>       <char> <char>    <char>
    ##  1:                                   IPCC 1.A.1 - Ener  1.A.1       CH4
    ##  2:                                   IPCC 1.A.1 - Ener  1.A.1       CH4
    ##  3:                                   IPCC 1.A.1 - Ener  1.A.1       CH4
    ##  4:                                   IPCC 1.A.1 - Ener  1.A.1       CH4
    ##  5:                                   IPCC 1.A.1 - Ener  1.A.1       CH4
    ##  6: Finnish Environment Institute, Finland 1.A.1 - Ener  1.A.1       CH4
    ##  7: Finnish Environment Institute, Finland 1.A.1 - Ener  1.A.1       CH4
    ##  8: Finnish Environment Institute, Finland 1.A.1 - Ener  1.A.1       CH4
    ##  9: Finnish Environment Institute, Finland 1.A.1 - Ener  1.A.1       CH4
    ## 10: Finnish Environment Institute, Finland 1.A.1 - Ener  1.A.1       CH4
