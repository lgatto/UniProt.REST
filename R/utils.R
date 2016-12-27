upNames <- function(object)
    unique(names(object@Data))

upGet <- function(object, what) {
    sel <- names(object@Data) %in% what
    if (!any(sel)) {
        err <- paste0("'", what, "' not found. Use any of\n",
                      paste(paste(strwrap(paste(upNames(object), collapse = " "))),
                            collapse = "\n"),
                      "\n")
        stop(err)
    }
    unlist(object@Data[sel], use.names = FALSE)
}
