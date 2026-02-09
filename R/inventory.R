#' start inventory structure
#'
#' @description create directories
#'
#'
#' @param path Character, default .
#' @param nfr String, nomenclature for ereporting, default "all"
#' @param dict String with file name to add description notes in a csv.
#' @param return_dict Logical, to retunr dictionary as object
#' @export
#' @examples \dontrun{
#' # do not run
#' }
inventory <- function(path, nfr = "all", dict, return_dict = TRUE) {
  if (missing(path)) {
    stop("Please, add a path to create dirs")
  }

  # 1. Use a local copy to avoid modifying sysdata in place
  efx <- data.table::as.data.table(sysdata)

  notes <- unique(efx[, c("code", "category", "source")])

  if (!missing(dict)) {
    data.table::setorderv(notes, "code")
    data.table::fwrite(notes, dict)
  }

  # 2. Filter NFR if requested
  if (nfr != "all") {
    available_nfrs <- efx[, unique(code)]
    if (any(!nfr %in% available_nfrs)) {
      stop("Only these NFR allowed: ", paste(available_nfrs, collapse = " "))
    }
    code_arg <- nfr
    code <- NULL
    efx <- efx[code %in% code_arg]
  }

  nfr_to_create <- efx[, unique(code)]
  nfr_to_create <- nfr_to_create[order(nfr_to_create)]

  dirs <- paste0(path, "/", nfr_to_create)
  message(
    "Creating the following directories: \n",
    paste(dirs, collapse = "\n")
  )

  for (i in seq_along(dirs)) {
    if (!dir.exists(dirs[i])) {
      dir.create(dirs[i], recursive = TRUE)
    }
    if (!dir.exists(paste0(dirs[i], "/scripts"))) {
      dir.create(paste0(dirs[i], "/scripts"), recursive = TRUE)
    }
    if (!dir.exists(paste0(dirs[i], "/emi"))) {
      dir.create(paste0(dirs[i], "/emi"), recursive = TRUE)
    }
  }

  if (return_dict) return(notes)
}
