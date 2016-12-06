<!-- README.md is generated from README.Rmd. Please edit that file -->
Basic Usage
-----------

msaR is a an [htmlwidgets](https://github.com/ramnathv/htmlwidgets) wrapper of the [BioJS MSA viewer](https://github.com/wilzbach/msa) javascript library. msa will pass alignments to the BioJS MSA and has a convenience function that will handle the following formats:

1.  A character string which is interpreted to be a fasta file (opened by `ape::read.dna`)
2.  A DNAbin class object (ape)
3.  An XStringSet (Biostrings) including "DNAStringSet", "RNAStringSet", "AAStringSet", and "BStringSet"
4.  An XMultiple Alignment (Biostings) including "DNAMultipleAlignment","RNAMultipleAlignment", and"AAMultipleAlignment"

Any of these types of objects can be passed to msaR to create an html widget. This package in not on CRAN/Bioconductor and can be installed using [devtools](https://github.com/hadley/devtools). See [the online docs](https://zachcp.github.io/msaR/) for an interactive version of this widget.

``` r
# install
#devtools::install_github('zachcp/msaR')

library(msaR)

# read some sequences from a multiple sequence alignment file and display
seqfile <- system.file("sequences","AHBA.aln",package="msaR")
msaR(seqfile)
```

### Use as a Shiny widget

msaR can be used as a widget with the [Shiny](http://shiny.rstudio.com/) web application framework.

In ui.R

``` r
msaROutput("msa", width="100%")
```

In server.R

``` r
output$msa <- renderMsaR(
  msaR(seqfile)
)
```

### Contribute

All contributions are welcome! Please feel free to submit a pull request.

### Support and Suggestions

If you have any problem or suggestion please open an issue [here](https://github.com/zachcp/msaR/issues)

### License

This project is licensed under the [Boost Software License 1.0](https://github.com/wilzbach/msa/blob/master/LICENSE).

> Permission is hereby granted, free of charge, to any person or organization obtaining a copy of the software and accompanying documentation covered by this license (the "Software") to use, reproduce, display, distribute, execute, and transmit the Software, and to prepare derivative works of the Software, and to permit third-parties to whom the Software is furnished to do so, all subject to the following:

If you use the MSAViewer on your website, it solely requires you to link to us
