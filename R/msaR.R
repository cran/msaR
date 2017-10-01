#' msaR
#'
#' Dynamic Multiple Sequence Alignments in R and Shiny
#'
#' @import htmlwidgets
#' 
#' @param msa File or BioString  Object representing a multiple Sequence Alignment.
#' @param menu Optional. Default \code{TRUE}. Determines whether to include the interactive menu.
#' @param width Optional. Default \code{NULL}. The width of the html widget element.
#' @param height Optional. Default \code{NULL}. The height of the html widget element.
#' @param rowheight Optional. Default \code{20}. Height of a row in the MSA.
#' @param alignmentHeight Optional. Default \code{225}. Height of the MSA.
#' @param overviewbox optional. Default \code{TRUE}. Include the overview box?
#' @param colorscheme optional. Default \code{"nucleotide"}. The color scheme to use. Can be one of the following: 
#'     "buried","cinema","clustal","clustal2","helix","hydro","lesk","mae","nucleotide","purine","strand","taylor","turn","zappo"
#' @param seqlogo optional. Default \code{TRUE}. Include the seqlogo?
#' @param conservation optional. Default \code{TRUE}. Include the conservation widget?
#' @param markers optional. Default \code{TRUE}. Include the alignment markers? These are the numbers along the top that 
#' @param metacell optional. Default \code{FALSE}. Include the per-sequence metadata.
#' @param leftheader optional. Default \code{TRUE}. Include the header information.
#' @param labels optional. Default \code{TRUE}. Include all of the sequence information msa Labels.
#' @param labelname optional. Default \code{TRUE}. Include sequence name?
#' @param labelid optional. Default \code{TRUE}. Include the labelid?
#' @param labelNameLength optional. Default \code{100}. Width of the Label Names.
#' @param overviewboxWidth optional. Default. \code{"auto"}. Can also be "fixed"
#' @param overviewboxHeight optional. Default. \code{"fixed"}. Can also be an integer value.
#' @export
#' @examples 
#' seqfile <- system.file("sequences","AHBA.aln",package="msaR")
#' msaR(seqfile)
msaR <- function(msa, 
                 menu=TRUE, 
                 width = NULL, 
                 height = NULL,
                 rowheight = 15,
                 alignmentHeight = 225,
                 overviewbox = TRUE,
                 seqlogo = TRUE,
                 colorscheme="nucleotide",
                 conservation = FALSE,
                 markers = TRUE,
                 metacell = FALSE,
                 leftheader = TRUE,
                 labels = TRUE,
                 labelname = TRUE,
                 labelid = TRUE,
                 labelNameLength = 100,
                 overviewboxWidth = "auto",
                 overviewboxHeight = "fixed"
                 ) {
  
  if (!colorscheme %in% colorschemes) {
    stop(paste("Color scheme must be on one of the following: ", colorschemes))
  }
  
  config <- list(
    vis=list(
      conserv=conservation,
      overviewbox=overviewbox,
      seqlogo=seqlogo,
      sequences=TRUE,
      markers=markers,
      metacell=metacell,
      gapHeader=FALSE,
      leftHeader=leftheader,
      # about the labels
      labels=labels,
      labelName=labelname,
      labelId=labelid,
      labelPartition=FALSE,
      labelCheckbox=FALSE,
      # meta stuff
      metaGaps=TRUE,
      metaIdentity=TRUE,
      metaLinks=TRUE
    ),
    conf=list(
      dropImport=TRUE,
      registerMouseHover=FALSE,
      registerMouseClicks=TRUE,
      eventBus=TRUE,
      alphabetSize= 20,
      debug=FALSE,
      hasRef=FALSE,
      manualRendering=FALSE
    ),
    colorscheme=list(
      scheme=colorscheme,
      colorBackground=TRUE,
      showLowerCase=TRUE,
      opacity=0.6
    ),
    zoomer=list(
      menuFontsize='12px',
      autoResize=TRUE,
      alignmentWidth="auto",
      alignmentHeight=alignmentHeight,
      columnWidth=15,
      rowHeight=rowheight,
      textVisible=TRUE,
      labelIdLength=30,
      labelNameLength=labelNameLength,
      labelPartLength=15,
      labelCheckLength=15,
      labelFontsize=13,
      labelLineHeight="13px",
      # marker
      markerFontsize="10px",
      stepSize=1,
      markerStepSize=2,
      markerHeight=20,
      #canvas
      residueFont="13", #in px
      canvasEventScale=1,
      # overview box
      boxRectHeight=2,
      boxRectWidth=2,
      overviewboxPaddingTop=10,
      overviewboxWidth = overviewboxWidth,
      overviewboxHeight = overviewboxHeight,
      # meta cell
      metaGapWidth=35,
      metaIdentWidth=40,
      metaLinksWidth=25
    ),
    menu=list(
      menuFontsize="14px",
      menuItemFontsize="14px",
      menuItemLineHeight="14px",
      menuMarginLeft="3px",
      menuPadding="3px 4px 3px 4px"
    )
  )

  
  # forward options using x
  x <- list(
    alignment=as.fasta(msa),
    config=config,
    menu=menu,
    features=NULL
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'msaR',
    x,
    width = width,
    height = height,
    package = 'msaR'
  )
}


colorschemes <- c(
  "buried",
  "cinema",
  "clustal",
  "clustal2",
  "helix",
  "hydro",
  "lesk",
  "mae",
  "nucleotide",
  "purine",
  "strand",
  "taylor",
  "turn",
  "zappo"
)

#' Widget output function for use in Shiny
#'
#' @param outputId output id
#' @param width width
#' @param height height
#' @export
msaROutput <- function(outputId, width = '100%', height = '100%'){
  htmlwidgets::shinyWidgetOutput(outputId, 'msaR', width, height, package = 'msaR')
}
#' Widget render function for use in Shiny
#'
#' @param expr expr
#' @param env env
#' @param quoted quoted
#' @export
renderMsaR <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, msaROutput, env, quoted = TRUE)
}
