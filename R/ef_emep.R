#' Emissions factors from European European Environment Agency
#'
#' @param nfr String: nomenclature for reporting
#' @param tier numeric 1 or 2
#' @param fuel String for type of fuel.
#' @param abatement String.
#' @param pol String for pollutant.
#' @param returnfdb logical return directly db
#' @return Return a data.table
#' @importFrom data.table setDT
#' @keywords  emission factors
#' @export
#' @examples {
#'   ef_emep(tier = 1, fuel = "Natural gas", pol = "PM2.5")
#' }
ef_emep <- function(
  nfr = "1.A.1.a",
  tier,
  fuel,
  abatement,
  pol,
  returnfdb = FALSE
) {
  eea <- data.table::setDT(sysdata$eea)
  # eea <- eea[grepl("1.A.1", NFR)]
  if (returnfdb) {
    return(eea)
  }
  # nfr ####
  if (length(nfr) > 1) {
    stop("One nfr at a time please")
  }

  NFR <- tiers <- Fuel <- Abatement <- Pollutant <- NULL
  nfrs <- eea[, unique(NFR)]
  if (!nfr %in% nfrs) {
    stop("only these nfr allowed: ", paste(nfrs, collapse = " "))
  }
  ef <- eea[NFR == nfr]

  # tier ####
  tiersx <- ef[, unique(tiers)]

  if (missing(tier)) {
    stop("Select one of:\n", paste(tiersx, collapse = "\n"))
  }
  if (length(tier) > 1) {
    stop("One tier at a time please")
  }

  if (!tier %in% tiersx) {
    stop("only these tiers allowed: ", paste(tiersx, collapse = "\n"))
  }
  ef <- ef[tiers == tier]

  # fuel ####

  fuelssx <- ef[, unique(Fuel)]

  if (missing(fuel)) {
    stop("Select one of:\n", paste(fuelssx, collapse = "\n"))
  }

  if (length(fuel) > 1) {
    stop("One fuel at a time please")
  }

  fuels <- ef[, unique(Fuel)]
  if (!fuel %in% fuels) {
    stop("only these fuels allowed: ", paste(fuels, collapse = " "))
  }
  ef <- ef[Fuel == fuel]

  # Abatement ####

  if (missing(abatement)) {
    abatement <- ""
  }

  abas <- ef[, unique(Abatement)]
  if (!abatement %in% abas) {
    stop("only these abatement allowed: ", paste(abas, collapse = " "))
  }
  ef <- ef[Abatement == abatement]

  # pol ####

  pols <- ef[, unique(Pollutant)]

  if (missing(pol)) {
    stop("Select one of:\n", paste(pols, collapse = "\n"))
  }

  if (any(!pol %in% pols)) {
    stop("only these Pollutants allowed: ", paste(pols, collapse = " "))
  }
  ef <- ef[Pollutant %in% pol]
  return(ef)
}
