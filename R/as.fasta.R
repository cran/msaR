#' as.fasta 
#' 
#' functionality to convert objects to a fasta string. Currently
#' this can handle character objects which are interpreted as filenames or
#' several of the popular means of storing sequence data: \code{\link[ape]{DNAbin}}, 
#' \code{\link[Biostrings]{DNAStringSet}}, \code{\link[Biostrings]{AAStringSet}},
#' \code{\link[Biostrings]{RNAStringSet}}, \code{\link[Biostrings]{BStringSet}},
#' \code{\link[Biostrings]{DNAMultipleAlignment}}, \code{\link[Biostrings]{RNAMultipleAlignment}},
#'  or \code{\link[Biostrings]{AAMultipleAlignment}}.
#' 
#' @param seqs (Required.) the sequence/alignment to be displayed. A character vector,  \code{\link[ape]{DNAbin}}, \code{\link[Biostrings]{DNAStringSet}},  \code{\link[Biostrings]{AAStringSet}},
#' or \code{\link[Biostrings]{RNAStringSet}}.
#' 
#' @return A character string in fasta format.
#'  
#' @importFrom ape as.alignment
#' @importFrom ape read.dna
#' @export
#' @rdname as.fasta
#' @examples 
#' seqfile <- system.file("sequences","AHBA.aln",package="msaR")
#' as.fasta(seqfile)
#' help("as.fasta")
#' 
#' if (requireNamespace("Biostrings", quietly = TRUE)) {
#'    seqs <- Biostrings::readDNAStringSet(seqfile)
#'    as.fasta(seqs)
#' }
#' 
as.fasta <- function(seqs) {
  
  # try character sequences first
  if (class(seqs)=="character") {
    try(sequences <- read.dna(seqs, format = "fasta"))
    if (exists("sequences")) return(as.fasta(sequences))
    return("Error reading your fasta file.")
  }
  
  # then DNAbin
  if (class(seqs) == "DNAbin") {
    aln <- as.alignment(seqs)
    return(paste0(">", aln$nam, "\n", aln$seq, collapse="\n"))
  }
  
  # Then Biostrings
  if (class(seqs) %in% c("DNAStringSet","AAStringSet", "RNAStringSet", "BStringSet", 
                       "DNAMultipleAlignment","RNAMultipleAlignment", "AAMultipleAlignment")) {
    
    # check for Biostring Namespace
    if (requireNamespace("Biostrings")) {
      
      if (class(seqs) %in% c("DNAStringSet", "RNAStringSet", "AAStringSet")) {
        newnames <- paste0(">", names(seqs))
        recs <- c(rbind(newnames, as.character(seqs)))
        return(paste(recs, collapse="\n"))
      }
      
      if (class(seqs)=="DNAMultipleAlignment"){
        return( as.fasta(Biostrings::DNAStringSet(seqs)))
      }
      
      if (class(seqs)=="RNAMultipleAlignment"){
        return( as.fasta(Biostrings::RNAStringSet(seqs)))
      }
      
      if (class(seqs)=="AAMultipleAlignment"){
        return( as.fasta(Biostrings::AAStringSet(seqs)))
      }
      
      stop("Invalid  seqs entry. Must be a character representing a filename")
      
    } else {
      stop("Biostrings must be loaded to convert Biostring objects.")
    }
  }
}
  



