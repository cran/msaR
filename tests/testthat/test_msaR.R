context("test msaR")
library(msaR)


test_that("serialization to sequences works", {
  seqfile  <- system.file("sequences","AHBA.aln", package="msaR")
  testseqs <- ape::read.FASTA(seqfile)
  
  
  
  converted_sequences <- as.sequences(testseqs)
  
  expect_equal(length(converted_sequences), 11)
  expect_equal(length(converted_sequences[[1]]), 3)
  expect_equal(names(converted_sequences[[1]]), c("id","name","seq"))
  expect_equal(converted_sequences[[1]]$name, "Hygrocin_AHBA")
  expect_equal(converted_sequences[[1]]$id, "Hygrocin_AHBA")
  expect_equal(substr(converted_sequences[[1]]$seq, 1, 5), "--atg")
  
})


test_that("msaR inits", {
  
  seqfile  <- system.file("sequences","AHBA.aln", package="msaR")
  testseqs <- ape::read.FASTA(seqfile)
  
  
  widget <- msaR(seqfile)
  
  testthat::expect_true(inherits(widget, "msaR"))
  testthat::expect_true(inherits(widget, "htmlwidget"))
  
})
