upNames <- function(object)
    unique(names(object@Data))

upGet <- function(object, what) {
    k <- grep(what, names(object@Data))
    if (!length(k)) {
        err <- paste0("'", what, "' not found. Use any of\n",
                      paste(paste(strwrap(paste(upNames(object), collapse = " "))),
                            collapse = "\n"),
                      "\n")     
        stop(err)
    }
    unlist(object@Data[k], use.names = FALSE)
}
