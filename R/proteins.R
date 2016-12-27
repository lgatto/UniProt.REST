PROTEINSURL <- paste0(BASEURL, "proteins?")
PROTEINURL <- paste0(BASEURL, "proteins/")


##' A Protein fetched from UniProt REST API
##'
##' @slot Data A \code{list} containing all the data.
##' @rdname UniProtProtein
##' @examples
##' library("UniProt.REST")
##' ac <- "P27361"
##' acs <- c("P27361", "P38398")
##' UniProtProtein(ac)
##' UniProtProteins(acs) ## works also as UniProtProtein(ac)
##' UniProtProteinIsoforms(ac)
.UniProtProtein <- setClass("UniProtProtein",
                            slots = c(Data = "list"))


##' Method to show a \code{UniProtProtein} object.
##'
##' @param object An instance of class \code{UniProtProtein}.
##' 
##' @rdname UniProtProtein
setMethod("show", "UniProtProtein",
          function(object) {
              cat("A Protein retrieved from 'UnitProt.REST'\n")
              cat(" Available data for ", object@Data[[1]][[1]], ":\n  ", sep = "")
              cat(paste(strwrap(paste(upNames(object), collapse = " "))),
                  sep = "\n  ")
          })

.queryOneAccession <- function(accession) {
    url <- paste0(PROTEINURL, accession)
    got <- GET(url)
    stop_for_status(got)
    ans <- as_list(xml2::read_xml(got))
    .UniProtProtein(Data = ans)
}

##' Constructor for \code{UniProtProtein} objects
##'
##' @param accession A \code{character} contain one of multiple
##'     accession numbers. If more than one are provided, a
##'     \code{list} of \code{UniProtProtein} objects is returned.
##' 
##' @rdname UniProtProtein
UniProtProtein <- function(accession) {
    ans <- lapply(accession, .queryOneAccession)
    if (length(ans) == 1L)
        ans <- ans[[1]]
    ans
}

## a UniProtSequence is composed of

## accession
## name
## protein
## gene
## organism
## reference
## comment
## dbReference
## proteinExistence
## keyword
## feature - should be ranges
## evidence
## sequence


##' Retrieves all isoforms for a given accession number
##'
##' @rdname UniProtProtein
UniProtProteinIsoforms <- function(accession) {
    stopifnot(length(accession) == 1L)
    url0 <- paste0(PROTEINURL, accession)
    url <- paste0(url0, "/isoforms")
    got <- GET(url)
    stop_for_status(got)
    lst <- as_list(xml2::read_xml(got))
    lapply(lst, function(x) .UniProtProtein(Data = x))
}

##' Another xonstructor for \code{UniProtProtein} objects
##'
##' This constructor sends a unique message to the UniProt REST server
##' containing all accession numbers, as opposed to
##' \code{UniProtProtein}, that sends one message per accession
##' number.
##' 
##' @param accessions A \code{character} with on or more accession numbers.
##' 
##' @rdname UniProtProtein
UniProtProteins <- function(accessions) {
    if (length(accessions) > 1)
        accessions <- paste(accessions, collapse = ",")
    url <- paste0(PROTEINSURL, "accession=", accessions)
    got <- GET(url)
    stop_for_status(got)
    ans <- as_list(xml2::read_xml(got))
    lapply(ans, function(x) .UniProtProtein(Data = x))
}
