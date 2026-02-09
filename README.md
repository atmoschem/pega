
# PEGA <img src="https://raw.githubusercontent.com/atmoschem/pega/main/man/figures/logo2.jpg" align="right" width="220"/>

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

    ## [1] '0.8.0'

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
    ##   1:                         Natural gas US Region 2.81e-01   g/GJ
    ##   2:                         Natural gas           7.60e-04  mg/GJ
    ##   3:                         Natural gas           1.20e-01  mg/GJ
    ##   4:                         Natural gas           1.00e-01  mg/GJ
    ##   5:                         Natural gas           2.50e-04  mg/GJ
    ##  ---                                                              
    ## 342:                        Other Biogas      <NA> 1.60e+00   g/GJ
    ## 343: Municipal Wastes (biomass fraction)      <NA> 1.20e+00   g/GJ
    ## 344:         Other Primary Solid Biomass      <NA> 1.10e+00   g/GJ
    ## 345:                     Wood/Wood Waste      <NA> 8.30e-01   g/GJ
    ## 346:                         Natural Gas      <NA> 3.09e+02  kg/TJ
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

### Create directories

``` r
inventory(path = tempdir())
```

    ## Creating the following directories: 
    ## /tmp/RtmpnN6jOp/1
    ## /tmp/RtmpnN6jOp/1.A
    ## /tmp/RtmpnN6jOp/1.A.1
    ## /tmp/RtmpnN6jOp/1.A.1.a
    ## /tmp/RtmpnN6jOp/1.A.1.a.i
    ## /tmp/RtmpnN6jOp/1.A.1.a.ii
    ## /tmp/RtmpnN6jOp/1.A.1.a.iii
    ## /tmp/RtmpnN6jOp/1.A.1.b
    ## /tmp/RtmpnN6jOp/1.A.1.c
    ## /tmp/RtmpnN6jOp/1.A.1.c.i
    ## /tmp/RtmpnN6jOp/1.A.1.c.ii
    ## /tmp/RtmpnN6jOp/1.A.2
    ## /tmp/RtmpnN6jOp/1.A.2.a
    ## /tmp/RtmpnN6jOp/1.A.2.b
    ## /tmp/RtmpnN6jOp/1.A.2.c
    ## /tmp/RtmpnN6jOp/1.A.2.d
    ## /tmp/RtmpnN6jOp/1.A.2.e
    ## /tmp/RtmpnN6jOp/1.A.2.f
    ## /tmp/RtmpnN6jOp/1.A.2.g
    ## /tmp/RtmpnN6jOp/1.A.2.g.vii
    ## /tmp/RtmpnN6jOp/1.A.2.g.viii
    ## /tmp/RtmpnN6jOp/1.A.2.h
    ## /tmp/RtmpnN6jOp/1.A.2.j
    ## /tmp/RtmpnN6jOp/1.A.2.l
    ## /tmp/RtmpnN6jOp/1.A.3
    ## /tmp/RtmpnN6jOp/1.A.3.a
    ## /tmp/RtmpnN6jOp/1.A.3.a.i
    ## /tmp/RtmpnN6jOp/1.A.3.a.i.(i)
    ## /tmp/RtmpnN6jOp/1.A.3.a.ii
    ## /tmp/RtmpnN6jOp/1.A.3.a.ii.(i)
    ## /tmp/RtmpnN6jOp/1.A.3.b
    ## /tmp/RtmpnN6jOp/1.A.3.b.i
    ## /tmp/RtmpnN6jOp/1.A.3.b.i.1
    ## /tmp/RtmpnN6jOp/1.A.3.b.ii
    ## /tmp/RtmpnN6jOp/1.A.3.b.iii
    ## /tmp/RtmpnN6jOp/1.A.3.b.iv
    ## /tmp/RtmpnN6jOp/1.A.3.b.v
    ## /tmp/RtmpnN6jOp/1.A.3.b.vi
    ## /tmp/RtmpnN6jOp/1.A.3.b.vii
    ## /tmp/RtmpnN6jOp/1.A.3.c
    ## /tmp/RtmpnN6jOp/1.A.3.d
    ## /tmp/RtmpnN6jOp/1.A.3.d.i
    ## /tmp/RtmpnN6jOp/1.A.3.d.ii
    ## /tmp/RtmpnN6jOp/1.A.3.e.ii
    ## /tmp/RtmpnN6jOp/1.A.4
    ## /tmp/RtmpnN6jOp/1.A.4.a
    ## /tmp/RtmpnN6jOp/1.A.4.a.i
    ## /tmp/RtmpnN6jOp/1.A.4.a.ii
    ## /tmp/RtmpnN6jOp/1.A.4.b
    ## /tmp/RtmpnN6jOp/1.A.4.b.i
    ## /tmp/RtmpnN6jOp/1.A.4.b.ii
    ## /tmp/RtmpnN6jOp/1.A.4.c.i
    ## /tmp/RtmpnN6jOp/1.A.4.c.ii
    ## /tmp/RtmpnN6jOp/1.A.4.c.iii
    ## /tmp/RtmpnN6jOp/1.A.5.a
    ## /tmp/RtmpnN6jOp/1.A.5.b
    ## /tmp/RtmpnN6jOp/1.B.1.a
    ## /tmp/RtmpnN6jOp/1.B.1.a.i
    ## /tmp/RtmpnN6jOp/1.B.1.a.i.1
    ## /tmp/RtmpnN6jOp/1.B.1.a.i.2
    ## /tmp/RtmpnN6jOp/1.B.1.a.i.3
    ## /tmp/RtmpnN6jOp/1.B.1.a.ii
    ## /tmp/RtmpnN6jOp/1.B.1.a.ii.1
    ## /tmp/RtmpnN6jOp/1.B.1.a.ii.2
    ## /tmp/RtmpnN6jOp/1.B.1.b
    ## /tmp/RtmpnN6jOp/1.B.2
    ## /tmp/RtmpnN6jOp/1.B.2.a
    ## /tmp/RtmpnN6jOp/1.B.2.a.i
    ## /tmp/RtmpnN6jOp/1.B.2.a.ii
    ## /tmp/RtmpnN6jOp/1.B.2.a.iv
    ## /tmp/RtmpnN6jOp/1.B.2.a.v
    ## /tmp/RtmpnN6jOp/1.B.2.b
    ## /tmp/RtmpnN6jOp/1.B.2.b.i
    ## /tmp/RtmpnN6jOp/1.B.2.b.ii
    ## /tmp/RtmpnN6jOp/1.B.2.c
    ## /tmp/RtmpnN6jOp/1.B.2.d
    ## /tmp/RtmpnN6jOp/1.B.3
    ## /tmp/RtmpnN6jOp/11.B
    ## /tmp/RtmpnN6jOp/2.A
    ## /tmp/RtmpnN6jOp/2.A.1
    ## /tmp/RtmpnN6jOp/2.A.2
    ## /tmp/RtmpnN6jOp/2.A.3
    ## /tmp/RtmpnN6jOp/2.A.4
    ## /tmp/RtmpnN6jOp/2.A.4.a
    ## /tmp/RtmpnN6jOp/2.A.4.b
    ## /tmp/RtmpnN6jOp/2.A.4.c
    ## /tmp/RtmpnN6jOp/2.A.4.d
    ## /tmp/RtmpnN6jOp/2.A.5
    ## /tmp/RtmpnN6jOp/2.A.5.a
    ## /tmp/RtmpnN6jOp/2.A.5.b
    ## /tmp/RtmpnN6jOp/2.A.5.c
    ## /tmp/RtmpnN6jOp/2.B
    ## /tmp/RtmpnN6jOp/2.B.1
    ## /tmp/RtmpnN6jOp/2.B.10.a
    ## /tmp/RtmpnN6jOp/2.B.2
    ## /tmp/RtmpnN6jOp/2.B.3
    ## /tmp/RtmpnN6jOp/2.B.4
    ## /tmp/RtmpnN6jOp/2.B.5
    ## /tmp/RtmpnN6jOp/2.B.6
    ## /tmp/RtmpnN6jOp/2.B.7
    ## /tmp/RtmpnN6jOp/2.B.8.a
    ## /tmp/RtmpnN6jOp/2.B.8.b
    ## /tmp/RtmpnN6jOp/2.B.8.c
    ## /tmp/RtmpnN6jOp/2.B.8.d
    ## /tmp/RtmpnN6jOp/2.B.8.e
    ## /tmp/RtmpnN6jOp/2.B.8.f
    ## /tmp/RtmpnN6jOp/2.B.9.a
    ## /tmp/RtmpnN6jOp/2.B.9.b
    ## /tmp/RtmpnN6jOp/2.C.1
    ## /tmp/RtmpnN6jOp/2.C.2
    ## /tmp/RtmpnN6jOp/2.C.3
    ## /tmp/RtmpnN6jOp/2.C.4
    ## /tmp/RtmpnN6jOp/2.C.5
    ## /tmp/RtmpnN6jOp/2.C.6
    ## /tmp/RtmpnN6jOp/2.C.7.a
    ## /tmp/RtmpnN6jOp/2.C.7.b
    ## /tmp/RtmpnN6jOp/2.C.7.c
    ## /tmp/RtmpnN6jOp/2.C.7.d
    ## /tmp/RtmpnN6jOp/2.D.1
    ## /tmp/RtmpnN6jOp/2.D.2
    ## /tmp/RtmpnN6jOp/2.D.3.a
    ## /tmp/RtmpnN6jOp/2.D.3.b
    ## /tmp/RtmpnN6jOp/2.D.3.c
    ## /tmp/RtmpnN6jOp/2.D.3.d
    ## /tmp/RtmpnN6jOp/2.D.3.e
    ## /tmp/RtmpnN6jOp/2.D.3.f
    ## /tmp/RtmpnN6jOp/2.D.3.g
    ## /tmp/RtmpnN6jOp/2.D.3.h
    ## /tmp/RtmpnN6jOp/2.D.3.i,2.G
    ## /tmp/RtmpnN6jOp/2.E
    ## /tmp/RtmpnN6jOp/2.E.1
    ## /tmp/RtmpnN6jOp/2.E.2
    ## /tmp/RtmpnN6jOp/2.E.3
    ## /tmp/RtmpnN6jOp/2.E.4
    ## /tmp/RtmpnN6jOp/2.F.1
    ## /tmp/RtmpnN6jOp/2.F.1.a
    ## /tmp/RtmpnN6jOp/2.F.1.b
    ## /tmp/RtmpnN6jOp/2.F.2
    ## /tmp/RtmpnN6jOp/2.F.3
    ## /tmp/RtmpnN6jOp/2.F.4
    ## /tmp/RtmpnN6jOp/2.F.5
    ## /tmp/RtmpnN6jOp/2.F.6
    ## /tmp/RtmpnN6jOp/2.G
    ## /tmp/RtmpnN6jOp/2.G.1
    ## /tmp/RtmpnN6jOp/2.G.1.a
    ## /tmp/RtmpnN6jOp/2.G.1.b
    ## /tmp/RtmpnN6jOp/2.G.1.c
    ## /tmp/RtmpnN6jOp/2.G.2.a
    ## /tmp/RtmpnN6jOp/2.G.2.b
    ## /tmp/RtmpnN6jOp/2.G.3.a
    ## /tmp/RtmpnN6jOp/2.G.3.b
    ## /tmp/RtmpnN6jOp/2.G.4
    ## /tmp/RtmpnN6jOp/2.H.1
    ## /tmp/RtmpnN6jOp/2.H.2
    ## /tmp/RtmpnN6jOp/2.I
    ## /tmp/RtmpnN6jOp/2.K
    ## /tmp/RtmpnN6jOp/3
    ## /tmp/RtmpnN6jOp/3.A
    ## /tmp/RtmpnN6jOp/3.A.1
    ## /tmp/RtmpnN6jOp/3.A.1.a
    ## /tmp/RtmpnN6jOp/3.A.1.a.i
    ## /tmp/RtmpnN6jOp/3.A.1.a.ii
    ## /tmp/RtmpnN6jOp/3.A.1.b
    ## /tmp/RtmpnN6jOp/3.A.1.c
    ## /tmp/RtmpnN6jOp/3.A.1.d
    ## /tmp/RtmpnN6jOp/3.A.1.e
    ## /tmp/RtmpnN6jOp/3.A.1.f
    ## /tmp/RtmpnN6jOp/3.A.1.g
    ## /tmp/RtmpnN6jOp/3.A.1.h
    ## /tmp/RtmpnN6jOp/3.A.1.j
    ## /tmp/RtmpnN6jOp/3.A.2
    ## /tmp/RtmpnN6jOp/3.A.2.a
    ## /tmp/RtmpnN6jOp/3.A.2.a.i
    ## /tmp/RtmpnN6jOp/3.A.2.a.ii
    ## /tmp/RtmpnN6jOp/3.A.2.b
    ## /tmp/RtmpnN6jOp/3.A.2.c
    ## /tmp/RtmpnN6jOp/3.A.2.d
    ## /tmp/RtmpnN6jOp/3.A.2.e
    ## /tmp/RtmpnN6jOp/3.A.2.f
    ## /tmp/RtmpnN6jOp/3.A.2.g
    ## /tmp/RtmpnN6jOp/3.A.2.h
    ## /tmp/RtmpnN6jOp/3.A.2.i
    ## /tmp/RtmpnN6jOp/3.A.2.j
    ## /tmp/RtmpnN6jOp/3.B
    ## /tmp/RtmpnN6jOp/3.B.1
    ## /tmp/RtmpnN6jOp/3.B.1.a
    ## /tmp/RtmpnN6jOp/3.B.1.b
    ## /tmp/RtmpnN6jOp/3.B.1.b.i
    ## /tmp/RtmpnN6jOp/3.B.1.b.ii
    ## /tmp/RtmpnN6jOp/3.B.1.b.iii
    ## /tmp/RtmpnN6jOp/3.B.2
    ## /tmp/RtmpnN6jOp/3.B.2.a
    ## /tmp/RtmpnN6jOp/3.B.2.b
    ## /tmp/RtmpnN6jOp/3.B.2.b.i
    ## /tmp/RtmpnN6jOp/3.B.2.b.ii
    ## /tmp/RtmpnN6jOp/3.B.2.b.iii
    ## /tmp/RtmpnN6jOp/3.B.3
    ## /tmp/RtmpnN6jOp/3.B.3.a
    ## /tmp/RtmpnN6jOp/3.B.3.b
    ## /tmp/RtmpnN6jOp/3.B.3.b.i
    ## /tmp/RtmpnN6jOp/3.B.4
    ## /tmp/RtmpnN6jOp/3.B.4.a
    ## /tmp/RtmpnN6jOp/3.B.4.a.i
    ## /tmp/RtmpnN6jOp/3.B.4.a.ii
    ## /tmp/RtmpnN6jOp/3.B.4.a.iii
    ## /tmp/RtmpnN6jOp/3.B.4.b
    ## /tmp/RtmpnN6jOp/3.B.4.b.ii
    ## /tmp/RtmpnN6jOp/3.B.4.b.iii
    ## /tmp/RtmpnN6jOp/3.B.4.d
    ## /tmp/RtmpnN6jOp/3.B.4.e
    ## /tmp/RtmpnN6jOp/3.B.4.f
    ## /tmp/RtmpnN6jOp/3.B.4.g.i
    ## /tmp/RtmpnN6jOp/3.B.4.g.ii
    ## /tmp/RtmpnN6jOp/3.B.4.g.Ii
    ## /tmp/RtmpnN6jOp/3.B.4.g.iii
    ## /tmp/RtmpnN6jOp/3.B.4.g.iv
    ## /tmp/RtmpnN6jOp/3.B.4.h
    ## /tmp/RtmpnN6jOp/3.B.5
    ## /tmp/RtmpnN6jOp/3.B.5.a
    ## /tmp/RtmpnN6jOp/3.B.5.b
    ## /tmp/RtmpnN6jOp/3.B.5.b.i
    ## /tmp/RtmpnN6jOp/3.B.6.b
    ## /tmp/RtmpnN6jOp/3.B.6.b.i
    ## /tmp/RtmpnN6jOp/3.C
    ## /tmp/RtmpnN6jOp/3.C.1
    ## /tmp/RtmpnN6jOp/3.C.1.a
    ## /tmp/RtmpnN6jOp/3.C.1.b
    ## /tmp/RtmpnN6jOp/3.C.1.c
    ## /tmp/RtmpnN6jOp/3.C.10
    ## /tmp/RtmpnN6jOp/3.C.11
    ## /tmp/RtmpnN6jOp/3.C.12
    ## /tmp/RtmpnN6jOp/3.C.3
    ## /tmp/RtmpnN6jOp/3.C.4
    ## /tmp/RtmpnN6jOp/3.C.5
    ## /tmp/RtmpnN6jOp/3.C.6
    ## /tmp/RtmpnN6jOp/3.C.7
    ## /tmp/RtmpnN6jOp/3.C.8
    ## /tmp/RtmpnN6jOp/3.D.1
    ## /tmp/RtmpnN6jOp/3.D.a.1
    ## /tmp/RtmpnN6jOp/3.D.a.2
    ## /tmp/RtmpnN6jOp/3.D.a.2.a
    ## /tmp/RtmpnN6jOp/3.D.a.2.b
    ## /tmp/RtmpnN6jOp/3.D.a.2.c
    ## /tmp/RtmpnN6jOp/3.D.a.3
    ## /tmp/RtmpnN6jOp/3.D.a.3.a
    ## /tmp/RtmpnN6jOp/3.D.a.4
    ## /tmp/RtmpnN6jOp/3.D.c
    ## /tmp/RtmpnN6jOp/3.D.e
    ## /tmp/RtmpnN6jOp/4
    ## /tmp/RtmpnN6jOp/4.A
    ## /tmp/RtmpnN6jOp/4.A.1
    ## /tmp/RtmpnN6jOp/4.A.2
    ## /tmp/RtmpnN6jOp/4.B
    ## /tmp/RtmpnN6jOp/4.C
    ## /tmp/RtmpnN6jOp/4.C.1
    ## /tmp/RtmpnN6jOp/4.C.2
    ## /tmp/RtmpnN6jOp/4.D
    ## /tmp/RtmpnN6jOp/4.D.1
    ## /tmp/RtmpnN6jOp/4.D.2
    ## /tmp/RtmpnN6jOp/4.E
    ## /tmp/RtmpnN6jOp/5.B.1
    ## /tmp/RtmpnN6jOp/5.B.2
    ## /tmp/RtmpnN6jOp/5.C.1.a
    ## /tmp/RtmpnN6jOp/5.C.1.b.i
    ## /tmp/RtmpnN6jOp/5.C.1.b.iii
    ## /tmp/RtmpnN6jOp/5.C.1.b.iv
    ## /tmp/RtmpnN6jOp/5.C.1.b.v
    ## /tmp/RtmpnN6jOp/5.C.2
    ## /tmp/RtmpnN6jOp/5.D
    ## /tmp/RtmpnN6jOp/5.D.1
    ## /tmp/RtmpnN6jOp/5.D.2
    ## /tmp/RtmpnN6jOp/5.E
    ## /tmp/RtmpnN6jOp/NA
