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
    stop(cat("ef can be 'emep' or 'ipcc'"))
  }

  if (ef == "emep") {
    ef <- "eea"
  }
  efdb <- sysdata[[ef]]

  NFR <- NULL
  nfrs <- efdb[, unique(NFR)]

  if (nfr == "all") {
    nfr <- nfrs
  } else {
    if (!nfr %in% nfrs) {
      stop(cat("Only these nfr allowed: ", nfrs, sep = "\n"))
    }
  }

  nfr <- nfr[order(nfr)]

  dirs <- paste0(path, "/", nfr)
  cat("Creating the folllowing directories, ", dirs, sep = "\n")

  for (i in seq_along(dirs)) {
    dir.create(dirs[i], recursive = T)
    dir.create(paste(dirs[i], "/scripts"), recursive = T)
    dir.create(paste(dirs[i], "/emi"), recursive = T)
  }
}
