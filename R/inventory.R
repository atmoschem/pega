#' start inventory structure
#'
#' @description create directories
#'
#'
#' @param path Character, default .
#' @param ef Character, default .
#' @param nfr String, nomenclature for ereporting, default "all"
#' @export
#' @examples \dontrun{
#' # do not run
#' }
inventory <- function(path, ef = "emep", nfr = "all") {
  if (missing(path)) {
    stop("Please, add a path to create dirs")
  }

  if (!ef %in% c("emep", "ipcc")) {
    stop("ef can be 'emep' or 'ipcc'")
  }

  if (ef == "emep") {
    ef <- "eea"
  }

  # Ensure dataset is a data.table
  efdb <- data.table::setDT(sysdata[[ef]])

  NFR <- NULL
  nfrs <- efdb[, unique(NFR)]

  if (identical(nfr, "all")) {
    nfr <- nfrs
  } else {
    if (any(!nfr %in% nfrs)) {
      stop("Only these nfr allowed: ", paste(nfrs, collapse = ", "))
    }
  }

  nfr <- nfr[order(nfr)]

  dirs <- paste0(path, "/", nfr)
  message("Creating the following directories: \n", paste(dirs, collapse = "\n"))

  for (i in seq_along(dirs)) {
    if (!dir.exists(dirs[i])) dir.create(dirs[i], recursive = TRUE)
    if (!dir.exists(paste0(dirs[i], "/scripts"))) dir.create(paste0(dirs[i], "/scripts"), recursive = TRUE)
    if (!dir.exists(paste0(dirs[i], "/emi"))) dir.create(paste0(dirs[i], "/emi"), recursive = TRUE)
  }
}
