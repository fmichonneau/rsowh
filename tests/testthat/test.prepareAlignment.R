
## Not ready for prime time
if (FALSE) {
    pth <- "~/Documents/2014-02.Pyrgo/dataTest"

    algFile <- file.path(pth, "alg.phy")
    parFile <- file.path(pth, "part.part")
    trFile  <- file.path(pth, "RAxML_bestTree.const")
    mdl     <- "GTRGAMMA"
    nReps   <- 5

    xx <- generateAlignments(algFile, parFile, trFile, mdl, nReps, pathFiles=pth)
    
    formatAlignments("\\.out_simSeq", prefix="constTreeSim", pathin="simDataGrouped",
                     pathout="simDataIndividual")
    finalizeAlignments("constTreeSim", 5, pathin="simDataIndividual",
                       pathout="simDataConcatenated")

    generateRAxMLscripts()
}
