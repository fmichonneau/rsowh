
##' Wrapper for all the functions up to the point of running the RAxML
##' analyses.  Really the only function you should be using.
##'
##' This function generates bash scripts that contain the appropriate
##' calls to RAxML to estimate the likelihoods based on constrained
##' and unconstrained searches.
##'
##' The \sQuote{path} should contain all the files used to initiate
##' the data set simulation and analyses.
##' 
##' @title Generate RAxML scripts
##' @param path root path (i.e., directory) within which all the file
##' manipulations will be performed.
##' @param model The model of molecular evolution to be used in the
##' analysis (only GTRGAMMA and GTRGAMMAI supported for now)
##' @param algfile Path to the original alignment file
##' @param partfile Path to the original partition file
##' @param treefile Path to the CONSTRAINED (H0) tree
##' @param nreps Number of replicated datasets to use in the
##' simulations
##' @param constrTopology Path to the CONSTRAINED multifurcating topology
##' @param prefixConst Character string indicating the prefix for the
##' files generated for the constrained topology
##' @param prefixBest Character string indicating the prefix for the
##' files generated for the unconstrained topology
##' @param seed The seed to be used for the analyses (same seed is
##' used by seq-gen and RAxML)
##' @return TRUE, but used for its main effect of generating the bash
##' scripts needed to run the SOWH test.
##' @author Francois Michonneau
generateRAxMLscripts <- function(path, model, algfile, partfile, treefile, nreps,
                                 constrTopology, prefixConst="const",
                                 prefixBest="best", seed) {
    stopifnot(file.exists(path))
    tPath <- file.info(path)$isdir
    stopifnot(tPath)
    model <- match.arg(model, c("GTRGAMMA", "GTRGAMMAI"))    
    owd <- getwd()
    setwd(path)
    stopifnot(file.exists(algfile))
    stopifnot(file.exists(partfile))
    stopifnot(file.exists(treefile))
    stopifnot(file.exists(constrTopology))
    stopifnot(file.exists("seq-gen"))
    if (missing(seed)) {
        seed <- as.integer(runif(1) * 10000000)        
    }
    partFileScript <- file.path("alignmentsForTest", paste(prefixConst, ".part", sep=""))
    generateAlignments(algfile=algfile, partfile=partfile, tree=treefile, model=model, nreps=nreps)
    formatAlignments(pattern="\\.out_simSeq$", prefix=prefixConst,
                     pathin="groupedPartitions", pathout="individualAlignments")
    finalizeAlignments(prefix=prefixConst, nreps=nreps, pathin="individualAlignments",
                       pathout="alignmentsForTest")
    generateBashScript(path="alignmentsForTest", output="bestTrees.sh", model=model,
                       partfile=partFileScript,
                       tree=NULL, prefix=prefixBest, seed=seed)
    generateBashScript(path="alignmentsForTest", output="constTree.sh", model=model, 
                       partfile=partFileScript,
                       tree=constrTopology, prefix=prefixConst,seed=seed)
    setwd(owd)
    TRUE
}

