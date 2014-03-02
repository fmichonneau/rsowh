\name{finalizeAlignments}
\alias{finalizeAlignments}
\title{Finalize the alignments}
\usage{
finalizeAlignments(prefix, nreps, pathin, pathout)
}
\arguments{
  \item{prefix}{The prefix shared by all the files
  representing replicates.}

  \item{nreps}{The number of replicates that have been
  generated.}

  \item{pathin}{path (i.e., directory) indicating where the
  files for each locus and each replicates are located.}

  \item{pathout}{path (i.e., directory) indicating where
  the each of the concatenated replicates will be stored;}
}
\value{
TRUE, but really is used for its side effect of generating
alignment files to be used by RAxML.
}
\description{
This function concatenate all the loci for a given
replicate to produce a single alignment, that will then be
used by RAxML to estimate the likelihoods of the
constrained and unconstrained topology.
}
\details{
Not much that I can think right now.
}
\author{
François Michonneau
}

