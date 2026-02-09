#' Inventory structure
#'
#' @param nfr nomenclature for reporting, one or many
#' @param fuel String for type of fuel.
#' @param pollutant String for pollutant.
#' @param returnfdb logical return directly db
#' @return Return a data.table
#' @importFrom data.table setDT
#' @keywords  emission factors
#' @export
#' @examples {
#'   ef()
#' }
#' @export
ef <- function(nfr = "1.A.1.a", fuel, pollutant, returnfdb = FALSE) {
  # 1. Use a local copy to avoid modifying sysdata in place if it's cached
  efx <- data.table::copy(sysdata)
  data.table::setDT(efx)

  if (returnfdb) {
    return(efx)
  }

  # 2. NFR Filtering
  # Using .. prefix tells data.table to look in the calling environment, not the columns
  available_nfrs <- efx[, unique(code)]
  if (!nfr %in% available_nfrs) {
    stop("only these nfr allowed: ", paste(available_nfrs, collapse = " "))
  }
  code <- NULL
  efx <- efx[code %in% nfr]

  if (missing(fuel) && missing(pollutant)) {
    return(efx)
  }

  # 3. Fuel Filtering
  if (!missing(fuel)) {
    available_fuels <- efx[, unique(fuel)]
    if (any(!fuel %in% available_fuels)) {
      stop("only these fuels allowed: ", paste(available_fuels, collapse = " "))
    }
    fuel_arg <- fuel
    fuel <- NULL
    efx <- efx[fuel %in% fuel_arg]
  }

  # 4. Pollutant Filtering
  if (!missing(pollutant)) {
    available_pols <- efx[, unique(pol)]
    if (any(!pollutant %in% available_pols)) {
      stop(
        "only these Pollutants allowed: ",
        paste(available_pols, collapse = " ")
      )
    }
    pollutant_arg <- pollutant
    pol <- NULL
    efx <- efx[pol %in% pollutant_arg]
  }

  return(efx)
}
