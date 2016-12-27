.onAttach <- function(libname, pkgname) {
    packageStartupMessage(paste("\nThis is 'UniProt.REST' version",
                                packageVersion("UniProt.REST"), "\n"))
}

