\name{generateRAxMLscripts}
\alias{generateRAxMLscripts}
\title{Generate RAxML scripts}
\usage{
generateRAxMLscripts(path, model, algfile, partfile, treefile, nreps,
  constrTopology, prefixConst = "const", prefixBest = "best", seed)
}
\arguments{
  \item{path}{root path (i.e., directory) within which all
  the file manipulations will be performed.}

  \item{model}{The model of molecular evolution to be used
  in the analysis (only GTRGAMMA and GTRGAMMAI supported
  for now)}

  \item{algfile}{Path to the original alignment file}

  \item{partfile}{Path to the original partition file}

  \item{treefile}{Path to the CONSTRAINED (H0) tree}

  \item{nreps}{Number of replicated datasets to use in the
  simulations}

  \item{constrTopology}{Path to the CONSTRAINED
  multifurcating topology}

  \item{prefixConst}{Character string indicating the prefix
  for the files generated for the constrained topology}

  \item{prefixBest}{Character string indicating the prefix
  for the files generated for the unconstrained topology}

  \item{seed}{The seed to be used for the analyses (same
  seed is used by seq-gen and RAxML)}
}
\value{
TRUE, but used for its main effect of generating the bash
scripts needed to run the SOWH test.
}
\description{
Wrapper for all the functions up to the point of running
the RAxML analyses.  Really the only function you should be
using.
}
\details{
This function generates bash scripts that contain the
appropriate calls to RAxML to estimate the likelihoods
based on constrained and unconstrained searches.

The \sQuote{path} should contain all the files used to
initiate the data set simulation and analyses.
}
\author{
Francois Michonneau
}

