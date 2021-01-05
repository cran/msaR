## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, message=FALSE)

## -----------------------------------------------------------------------------
library(msaR)

# read some sequences from a Multiple sequence alignment file.
seqfile <- system.file("sequences","AHBA.aln", package="msaR")

# display the MSA.
msaR(seqfile, menu=F, overviewbox = F)

## -----------------------------------------------------------------------------
msaR(seqfile, menu=F, overviewbox = F)

## -----------------------------------------------------------------------------

# read some sequences from a Multiple sequence alignment file.
proteinseqfile <- system.file("sequences","phosphoproteins.aln", package="msaR")

# loading AA with ape. Can also use Biostrings
proteins <- ape::read.FASTA(proteinseqfile, type="AA")
                            
# note the seqlogo will show up in your widget but 
# not the vignette static output
msaR(proteins, menu=F, overviewbox = F,  colorscheme = "clustal")


## ---- eval=FALSE--------------------------------------------------------------
#  msaROutput("msa", width="100%")

## ---- eval=FALSE--------------------------------------------------------------
#  output$msa <- renderMsaR(
#    msaR(seqfile)
#  )

