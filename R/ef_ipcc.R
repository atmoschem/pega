#' Emissions factors from  Intergovernmental Panel on Climate Change (IPCC)
#'
#' @param nfr String: nomenclature for reporting
#' @param fuel String for type of fuel.
#' @param pol String for pollutant.
#' @param returnfdb logical return directly db
#' @return Return a data.table
#' @importFrom data.table setDT
#' @keywords  emission factors
#' @export
#' @examples {
#' ef_ipcc(fuel = "Natural Gas", pol = "CH4")
#' }
ef_ipcc <- function(
  nfr = "1.A.1",
  fuel,
  pol,
  returnfdb = FALSE
) {
  ipcc <- data.table::setDT(sysdata$ipcc)

  if (returnfdb) {
    return(ipcc)
  }
  # nfr ####
  if (length(nfr) > 1) {
    stop("One nfr at a time please")
  }

  nfrs <- ipcc[, unique(NFR)]
  nfrs <- nfrs[order(nfrs)]

  if (!nfr %in% nfrs) {
    stop(cat("only these nfr  allowed: ", nfrs, sep = "\n"))
  }
  NFR <- NULL
  ef <- ipcc[NFR == nfr]

  # fuel ####

  Fuel_2006 <- NULL
  fuelssx <- ef[, unique(Fuel_2006)]

  if (missing(fuel)) {
    stop(cat("Select one of:", fuelssx, sep = "\n"))
  }

  if (length(fuel) > 1) {
    stop("One fuel at a time please")
  }

  fuels <- ef[, unique(Fuel_2006)]
  if (!fuel %in% fuels) {
    stop(cat("only these fuels  allowed: ", fuels, sep = "\n"))
  }
  ef <- ef[Fuel_2006 == fuel]

  # pol ####
  Pollutant <- NULL

  pols <- ef[, unique(Pollutant)]

  if (missing(pol)) {
    stop(cat("Select one of:", pols, sep = "\n"))
  }

  if (any(!pol %in% pols)) {
    stop(cat("only these Pollutants  allowed: ", pols, sep = " "))
  }
  ef <- ef[Pollutant %in% pol]
  return(ef)
}
