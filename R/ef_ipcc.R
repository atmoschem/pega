#' Inventory structure
#'
#' @param nfr nomenclature for reporting, one or many
#' @param fuel String for type of fuel.
#' @param pol String for pollutant.
#' @param returnfdb logical return directly db
#' @return Return a data.table
#' @importFrom data.table setDT
#' @keywords  emission factors
#' @export
#' @examples {
#' ef_emep(tier = 1, fuel = "Natural gas", pol = "PM2.5")
#' }

ef_ipcc <- function(
  nfr = "1.A.1.a",
  fuel,
  pol,
  returnfdb = FALSE
) {
  eea <- data.table::setDT(sysdata$ipcc)
  #eea <- eea[grepl("1.A.1", NFR)]
  if (returnfdb) {
    return(eea)
  }
  # nfr ####
  if (length(nfr) > 1) {
    stop("One nfr at a time please")
  }

  NFR <- Pollutant <- NULL
  nfrs <- eea[, unique(NFR)]
  if (!nfr %in% nfrs) {
    stop(cat("only these nfr  allowed: ", nfrs, sep = " "))
  }
  ef <- eea[NFR == nfr]

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
    stop(cat("only these fuels  allowed: ", fuels, sep = " "))
  }
  ef <- ef[Fuel_2006 == fuel]

  # pol ####
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
