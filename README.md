
# PEGA <img src="man/figures/logo.png" align="right" alt="" width="220" />

- Poluentes, Emissões e Gases de Atmosfera.
- Pollutants Emissions and Gaseous of the Atmosphere.

## Installation

Using remotes R package

``` r
remotes::install_github("atmoschem/pega")
```

``` r
library(pega)
library(data.table)
utils::packageVersion("pega")
```

    ## [1] '0.9.2'

## Emission factors

``` r
library(pega)
ef()
```

    ##        Value   Unit source
    ##       <char> <char> <char>
    ##   1:   0.281   g/GJ   EMEP
    ##   2: 0.00076  mg/GJ   EMEP
    ##   3:    0.12  mg/GJ   EMEP
    ##   4:     0.1  mg/GJ   EMEP
    ##   5: 0.00025  mg/GJ   EMEP
    ##  ---                      
    ## 342:     1.6   g/GJ   IPCC
    ## 343:     1.2   g/GJ   IPCC
    ## 344:     1.1   g/GJ   IPCC
    ## 345:    0.83   g/GJ   IPCC
    ## 346:     309  kg/TJ   IPCC
    ##                                                       category
    ##                                                         <char>
    ##   1:                    Public electricity and heat production
    ##   2:                    Public electricity and heat production
    ##   3:                    Public electricity and heat production
    ##   4:                    Public electricity and heat production
    ##   5:                    Public electricity and heat production
    ##  ---                                                          
    ## 342: 1.A.1.a - Main Activity Electricity and Heat Production\n
    ## 343: 1.A.1.a - Main Activity Electricity and Heat Production\n
    ## 344: 1.A.1.a - Main Activity Electricity and Heat Production\n
    ## 345: 1.A.1.a - Main Activity Electricity and Heat Production\n
    ## 346: 1.A.1.a - Main Activity Electricity and Heat Production\n
    ##                        type     tech     table    code  codetype
    ##                      <char>   <char>    <char>  <char>    <char>
    ##   1: Tier 1 Emission Factor     <NA> Table_3-4 1.A.1.a       NFR
    ##   2: Tier 1 Emission Factor     <NA> Table_3-4 1.A.1.a       NFR
    ##   3: Tier 1 Emission Factor     <NA> Table_3-4 1.A.1.a       NFR
    ##   4: Tier 1 Emission Factor     <NA> Table_3-4 1.A.1.a       NFR
    ##   5: Tier 1 Emission Factor     <NA> Table_3-4 1.A.1.a       NFR
    ##  ---                                                            
    ## 342:  Other (e.g. compiled) CHP<25MW      <NA> 1.A.1.a IPCC 2006
    ## 343:  Other (e.g. compiled) CHP<25MW      <NA> 1.A.1.a IPCC 2006
    ## 344:  Other (e.g. compiled) CHP<25MW      <NA> 1.A.1.a IPCC 2006
    ## 345:  Other (e.g. compiled) CHP<25MW      <NA> 1.A.1.a IPCC 2006
    ## 346:  Other (e.g. compiled)     <NA>      <NA> 1.A.1.a IPCC 2006
    ##                                     fuel     tech2       ef   unit
    ##                                   <char>    <char>    <num> <char>
    ##   1:                         Natural Gas US Region 2.81e-01   g/GJ
    ##   2:                         Natural Gas           7.60e-07   g/GJ
    ##   3:                         Natural Gas           1.20e-04   g/GJ
    ##   4:                         Natural Gas           1.00e-04   g/GJ
    ##   5:                         Natural Gas           2.50e-07   g/GJ
    ##  ---                                                              
    ## 342:                        Other Biogas      <NA> 1.60e+00   g/GJ
    ## 343: Municipal Wastes (biomass fraction)      <NA> 1.20e+00   g/GJ
    ## 344:         Other Primary Solid Biomass      <NA> 1.10e+00   g/GJ
    ## 345:                     Wood/Wood Waste      <NA> 8.30e-01   g/GJ
    ## 346:                         Natural Gas      <NA> 3.09e+02   g/GJ
    ##                           reference    pol  region     other
    ##                              <char> <char>  <char>    <char>
    ##   1:     US EPA (1998), chapter 1.4    SOx    <NA> US Region
    ##   2:           Nielsen et al., 2012     Cr    <NA>          
    ##   3: Nielsen et al., 2012; DBI 2014     As    <NA>          
    ##   4:           Nielsen et al., 2010     Hg    <NA>          
    ##   5:           Nielsen et al., 2012     Cd    <NA>          
    ##  ---                                                        
    ## 342:                           <NA>    N2O Denmark      <NA>
    ## 343:                           <NA>    N2O Denmark      <NA>
    ## 344:                           <NA>    N2O Denmark      <NA>
    ## 345:                           <NA>    N2O Denmark      <NA>
    ## 346:                           <NA>    CH4 Germany      <NA>
