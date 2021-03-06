
##' Generate sequences with seq-gen using parameters from the RAxML run
##'
##' Currently, \code{seq-gen} uses a proportion of invariant sites
##' depending on whether the list of parameters in the \code{params}
##' object is empty or not.
##' @title Execute seq-gen 
##' @param params The list of parameters generates by \code{\link{getParams}}
##' @param nreps Number of replicated alignments to generate
##' @param model Model of molecular evolution used to generate the
##' data (for now only \sQuote{GTR} is supported)
##' @param ngamma Number of categories for the alpha parameter of the
##' Gamma distribution (RAxML always uses 4, so you should probably
##' leave it as the default value of 4).
##' @param seed Seed number to generate the alignment
##' @param outputFormat Format file of the alignment generated by
##' seq-gen, if you intend to use RAxML to estimate your trees, keep
##' the default (\sQuote{relaxed)}.
##' @param pathSimData Where the output files will be stored (default
##' \sQuote{simDataGrouped})
##' @return TRUE, but really is used for its side effect of generating
##' random sequences stored in files.
##' @author Francois Michonneau
##' @export
execSeqGen <- function(params, nreps, model="GTR", ngamma=4, seed="10101",
                       outputFormat=c("relaxed", "phylip", "nexus"),
                       pathSimData="simDataGrouped") {
    
    outputFormat <- match.arg(outputFormat)
    if (missing(nreps)) nreps <- "1" else as.character(nreps)

    pathSimData <- gsub("/$", "", pathSimData)
    if (! file.exists(pathSimData))
        system(paste("mkdir", pathSimData))
    else if ( ! file.info(pathSimData)$isdir)
        stop(pathSimData, " is not a directory.")
    
    output <- file.path(pathSimData, paste(params$fileNm, "simSeq", sep="_"))
    
    fOut <- switch(outputFormat,
                   phylip = " -op",
                   relaxed = " -or",
                   nexus = " -on")
    pInv <- ifelse (length(params$invar), character(0), c(" -i", params$invar))
    cmd <- paste("./seq-gen -m", model, " -l", params$seqlen, " -n", nreps,
                 " -a", params$alpha, " -g", ngamma,
                 " -f", paste(params$freqA, params$freqG, params$freqG, params$freqT),
                 " -r", paste(params$rateAC, params$rateAG, params$rateAT,
                 params$rateCG, params$rateCT, params$rateGT), " -z", seed,
                 fOut, " < ", params$treePath, " > ", output, sep="")
    system(cmd)
    TRUE
}
