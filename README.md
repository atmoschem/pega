
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

    ## [1] '0.7.0'

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

    ##     EF_ID                   IPCC_1996_SourceSink_Category
    ##    <char>                                          <char>
    ## 1: 122122 1A1a - Public Electricity and Heat Production\n
    ## 2: 122123 1A1a - Public Electricity and Heat Production\n
    ## 3: 122135 1A1a - Public Electricity and Heat Production\n
    ##                                IPCC_2006_SourceSink_Category       Gas
    ##                                                       <char>    <char>
    ## 1: 1.A.1.a - Main Activity Electricity and Heat Production\n METHANE\n
    ## 2: 1.A.1.a - Main Activity Electricity and Heat Production\n METHANE\n
    ## 3: 1.A.1.a - Main Activity Electricity and Heat Production\n METHANE\n
    ##      Fuel_1996   Fuel_2006 C_pool     Type_of_parameter
    ##         <char>      <char> <lgcl>                <char>
    ## 1: Natural Gas Natural Gas     NA Other (e.g. compiled)
    ## 2: Natural Gas Natural Gas     NA               Modeled
    ## 3: Natural Gas Natural Gas     NA Other (e.g. compiled)
    ##                                   Description TechnologiesPractices
    ##                                        <char>                <char>
    ## 1: CH4 EF for natural gas engines less 25 MWw              CHP<25MW
    ## 2: CH4 EF for natural gas turbines less 25 MW              CHP<25MW
    ## 3:                     CH4 EF for natural gas                  <NA>
    ##    ParametersConditions RegionRegional_Conditions
    ##                  <char>                    <char>
    ## 1:                 <NA>                   Denmark
    ## 2:                 <NA>                   Denmark
    ## 3:                 <NA>                   Germany
    ##                                                                     AbatementControl_Technologies
    ##                                                                                            <char>
    ## 1:                      Engines equipped with oxidation catalysts for reducing the emission of CO
    ## 2: Almost all the gas turbines are equipped with low-NOx burners. One plant is equipped with SCR.
    ## 3:                                                                                           <NA>
    ##    Other_properties  Value   Unit Equation IPCC_Worksheet Technical_Reference
    ##              <char> <char> <char>   <char>         <char>              <char>
    ## 1:             <NA>    481   g/GJ     <NA>           <NA>                <NA>
    ## 2:             <NA>    1.7   g/GJ     <NA>           <NA>                <NA>
    ## 3:             <NA>    309  kg/TJ     <NA>           <NA>                <NA>
    ##                         Source_of_data            Data_provider           NF
    ##                                 <char>                   <char>       <char>
    ## 1:                               Other Pavel Shermanau, Belarus 1.A.1.a - Ma
    ## 2:                               Other Pavel Shermanau, Belarus 1.A.1.a - Ma
    ## 3: National Inventory Report (Annex I) Pavel Shermanau, Belarus 1.A.1.a - Ma
    ##        NFR Pollutant
    ##     <char>    <char>
    ## 1: 1.A.1.a       CH4
    ## 2: 1.A.1.a       CH4
    ## 3: 1.A.1.a       CH4

### Create directories

``` r
inventory(path = tempdir())
```

    ## Creating the folllowing directories, 
    ## /tmp/RtmpazPxjo/1.A.1.a
    ## /tmp/RtmpazPxjo/1.A.1.b
    ## /tmp/RtmpazPxjo/1.A.1.c
    ## /tmp/RtmpazPxjo/1.A.2.a
    ## /tmp/RtmpazPxjo/1.A.2.b
    ## /tmp/RtmpazPxjo/1.A.2.c
    ## /tmp/RtmpazPxjo/1.A.2.d
    ## /tmp/RtmpazPxjo/1.A.2.e
    ## /tmp/RtmpazPxjo/1.A.2.g.vii
    ## /tmp/RtmpazPxjo/1.A.2.g.viii
    ## /tmp/RtmpazPxjo/1.A.3.a.i.(i)
    ## /tmp/RtmpazPxjo/1.A.3.a.ii.(i)
    ## /tmp/RtmpazPxjo/1.A.3.b.i
    ## /tmp/RtmpazPxjo/1.A.3.b.ii
    ## /tmp/RtmpazPxjo/1.A.3.b.iii
    ## /tmp/RtmpazPxjo/1.A.3.b.iv
    ## /tmp/RtmpazPxjo/1.A.3.b.v
    ## /tmp/RtmpazPxjo/1.A.3.b.vi
    ## /tmp/RtmpazPxjo/1.A.3.b.vii
    ## /tmp/RtmpazPxjo/1.A.3.c
    ## /tmp/RtmpazPxjo/1.A.3.d.i
    ## /tmp/RtmpazPxjo/1.A.3.d.ii
    ## /tmp/RtmpazPxjo/1.A.4.a.i
    ## /tmp/RtmpazPxjo/1.A.4.a.ii
    ## /tmp/RtmpazPxjo/1.A.4.b.i
    ## /tmp/RtmpazPxjo/1.A.4.b.ii
    ## /tmp/RtmpazPxjo/1.A.4.c.i
    ## /tmp/RtmpazPxjo/1.A.4.c.ii
    ## /tmp/RtmpazPxjo/1.A.4.c.iii
    ## /tmp/RtmpazPxjo/1.A.5.a
    ## /tmp/RtmpazPxjo/1.A.5.b
    ## /tmp/RtmpazPxjo/1.B.1.a
    ## /tmp/RtmpazPxjo/1.B.1.b
    ## /tmp/RtmpazPxjo/1.B.2.a.i
    ## /tmp/RtmpazPxjo/1.B.2.a.iv
    ## /tmp/RtmpazPxjo/1.B.2.a.v
    ## /tmp/RtmpazPxjo/1.B.2.b
    ## /tmp/RtmpazPxjo/1.B.2.c
    ## /tmp/RtmpazPxjo/1.B.2.d
    ## /tmp/RtmpazPxjo/11.B
    ## /tmp/RtmpazPxjo/2.A.1
    ## /tmp/RtmpazPxjo/2.A.2
    ## /tmp/RtmpazPxjo/2.A.3
    ## /tmp/RtmpazPxjo/2.A.5.a
    ## /tmp/RtmpazPxjo/2.A.5.b
    ## /tmp/RtmpazPxjo/2.A.5.c
    ## /tmp/RtmpazPxjo/2.B
    ## /tmp/RtmpazPxjo/2.B.1
    ## /tmp/RtmpazPxjo/2.B.10.a
    ## /tmp/RtmpazPxjo/2.B.2
    ## /tmp/RtmpazPxjo/2.B.3
    ## /tmp/RtmpazPxjo/2.B.5
    ## /tmp/RtmpazPxjo/2.B.6
    ## /tmp/RtmpazPxjo/2.B.7
    ## /tmp/RtmpazPxjo/2.C.1
    ## /tmp/RtmpazPxjo/2.C.2
    ## /tmp/RtmpazPxjo/2.C.3
    ## /tmp/RtmpazPxjo/2.C.5
    ## /tmp/RtmpazPxjo/2.C.6
    ## /tmp/RtmpazPxjo/2.C.7.a
    ## /tmp/RtmpazPxjo/2.C.7.b
    ## /tmp/RtmpazPxjo/2.C.7.c
    ## /tmp/RtmpazPxjo/2.C.7.d
    ## /tmp/RtmpazPxjo/2.D.3.a
    ## /tmp/RtmpazPxjo/2.D.3.b
    ## /tmp/RtmpazPxjo/2.D.3.c
    ## /tmp/RtmpazPxjo/2.D.3.d
    ## /tmp/RtmpazPxjo/2.D.3.e
    ## /tmp/RtmpazPxjo/2.D.3.f
    ## /tmp/RtmpazPxjo/2.D.3.g
    ## /tmp/RtmpazPxjo/2.D.3.h
    ## /tmp/RtmpazPxjo/2.D.3.i, 2.G
    ## /tmp/RtmpazPxjo/2.G
    ## /tmp/RtmpazPxjo/2.H.1
    ## /tmp/RtmpazPxjo/2.H.2
    ## /tmp/RtmpazPxjo/2.I
    ## /tmp/RtmpazPxjo/2.K
    ## /tmp/RtmpazPxjo/3.B.1
    ## /tmp/RtmpazPxjo/3.B.1.a
    ## /tmp/RtmpazPxjo/3.B.1.b
    ## /tmp/RtmpazPxjo/3.B.2
    ## /tmp/RtmpazPxjo/3.B.3
    ## /tmp/RtmpazPxjo/3.B.4.a
    ## /tmp/RtmpazPxjo/3.B.4.d
    ## /tmp/RtmpazPxjo/3.B.4.e
    ## /tmp/RtmpazPxjo/3.B.4.f
    ## /tmp/RtmpazPxjo/3.B.4.g.i
    ## /tmp/RtmpazPxjo/3.B.4.g.ii
    ## /tmp/RtmpazPxjo/3.B.4.g.Ii
    ## /tmp/RtmpazPxjo/3.B.4.g.iii
    ## /tmp/RtmpazPxjo/3.B.4.g.iv
    ## /tmp/RtmpazPxjo/3.B.4.h
    ## /tmp/RtmpazPxjo/3.D.a.1
    ## /tmp/RtmpazPxjo/3.D.a.2
    ## /tmp/RtmpazPxjo/3.D.a.2.a
    ## /tmp/RtmpazPxjo/3.D.a.2.b
    ## /tmp/RtmpazPxjo/3.D.a.2.c
    ## /tmp/RtmpazPxjo/3.D.a.3
    ## /tmp/RtmpazPxjo/3.D.a.3.a
    ## /tmp/RtmpazPxjo/3.D.a.4
    ## /tmp/RtmpazPxjo/3.D.c
    ## /tmp/RtmpazPxjo/3.D.e
    ## /tmp/RtmpazPxjo/5.B.1
    ## /tmp/RtmpazPxjo/5.B.2
    ## /tmp/RtmpazPxjo/5.C.1.a
    ## /tmp/RtmpazPxjo/5.C.1.b.i
    ## /tmp/RtmpazPxjo/5.C.1.b.iii
    ## /tmp/RtmpazPxjo/5.C.1.b.iv
    ## /tmp/RtmpazPxjo/5.C.1.b.v
    ## /tmp/RtmpazPxjo/5.C.2
    ## /tmp/RtmpazPxjo/5.D
    ## /tmp/RtmpazPxjo/5.D.1
    ## /tmp/RtmpazPxjo/5.D.2
    ## /tmp/RtmpazPxjo/5.E
