
##' Apply \code{\link{splitMultiAlignments}} on all loci.
##'
##' Given a regexp pattern that match multiple files representing loci
##' of an alignment simulated by seq-gen, this function applies
##' \code{\link{splitMultiAlignments}} on each of them.
##'
##' This function may produce a large number of files. If you
##' generated 500 replicates and you have 5 loci, 2,500 files will be
##' generated.
##'
##' If \code{pathout} does not exist, it will be created.
##' @title formatAlignments
##' @param pattern character string that matches the files containing
##' the simulated replicates.
##' @param prefix character string to be appended to each individual
##' file name across all loci
##' @param pathin path (i.e., directory) where the simulated files are
##' located.
##' @param pathout path (i.e., directory) where the the individual
##' replicates will be located.
##' @seealso \code{\link[seqManagement]{splitMultiAlignments}}
##' @return TRUE, but really used for its side effect of generating
##' individual replicate for each locus.
##' @author Francois Michonneau
##' @export
formatAlignments <- function(pattern, prefix, pathin, pathout) {
    stopifnot(file.exists(pathin))
    pathout <- gsub("/$", "", pathout)
    if (! file.exists(pathout))
        system(paste("mkdir", pathout))
    else if ( ! file.info(pathout)$isdir)
        stop(pathout, " is not a directory.")
        
    lFiles <- list.files(pattern=pattern, path=pathin)
    for (i in 1:length(lFiles)) {
        splitMultiAlignments(lFiles[i], prefix=prefix, pathin=pathin, pathout=pathout)
    }
    TRUE
}

##' This function concatenate all the loci for a given replicate to
##' produce a single alignment, that will then be used by RAxML to
##' estimate the likelihoods of the constrained and unconstrained
##' topology.
##'
##' Not much that I can think right now.
##' @title Finalize the alignments
##' @param prefix The prefix shared by all the files representing
##' replicates.
##' @param nreps The number of replicates that have been generated. 
##' @param pathin path (i.e., directory) indicating where the files
##' for each locus and each replicates are located.
##' @param pathout path (i.e., directory) indicating where the each of
##' the concatenated replicates will be stored;
##' @return TRUE, but really is used for its side effect of generating
##' alignment files to be used by RAxML.
##' @author Francois Michonneau
##' @export
finalizeAlignments <- function(prefix, nreps, pathin, pathout) {
    stopifnot(file.exists(pathin))
    pathout <- gsub("/$", "", pathout)
    if (! file.exists(pathout))
        system(paste("mkdir", pathout))
    else if ( ! file.info(pathout)$isdir)
        stop(pathout, " is not a directory.")
    
    lReps <- list.files(pattern=paste("^", prefix, sep=""), path=pathin)
    partFile <- file.path(pathout, paste(prefix, ".part", sep=""))
    for (i in 1:nreps) {
        ptrn <- paste("^", prefix, "-rep", i, "-", sep="")
        otpt <- file.path(pathout, paste(prefix, "-rep", i, ".phy", sep=""))
        if(i == 1) part <- partFile else part <- NULL
        concatenateAlignments(pattern=ptrn, path=pathin, output=otpt,
                              input.format="sequential",
                              partition=part, partition.format="raxml",
                              format="sequential", standardize=TRUE, colw=999999,
                              colsep="")
    }
    TRUE
}
