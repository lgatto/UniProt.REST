context("Testing UniProtProtein queries")

ac <- "P27361"
acs <- c("P27361", "P38398")

test_that("A sinlge UniProtProtein", {
    x <- UniProtProtein(ac)
    expect_true(validObject(x))
    expect_s4_class(x, "UniProtProtein")
    expect_null(show(x))
})


test_that("Multiple UniProtProtein", {
    x <- UniProtProtein(acs)
    y <- UniProtProteins(acs)
    expect_true(validObject(x))
    expect_true(validObject(y))
    expect_is(x, "list")
    expect_is(y, "list")
    expect_identical(length(x), length(y))
    sapply(x, function(xx) expect_true(validObject(xx)))
    sapply(y, function(xx) expect_true(validObject(xx)))
    sapply(x, function(xx) expect_s4_class(xx, "UniProtProtein"))
    sapply(y, function(xx) expect_s4_class(xx, "UniProtProtein"))
})

test_that("Protein isoforms", {
    x <- UniProtProteinIsoforms(ac)
    expect_length(x, 3L)
    expect_is(x, "list")
    sapply(x, function(xx) expect_true(validObject(xx)))
    sapply(x, function(xx) expect_s4_class(xx, "UniProtProtein"))
    nms <- sapply(x, function(xx) xx@Data[[1]][[1]])
    names(nms) <- NULL
    nms0 <- paste0("P27361-", 3:1)
    expect_identical(nms, nms0)
})
