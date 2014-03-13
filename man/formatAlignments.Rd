\name{formatAlignments}
\alias{formatAlignments}
\title{formatAlignments}
\usage{
formatAlignments(pattern, prefix, pathin, pathout)
}
\arguments{
  \item{pattern}{character string that matches the files
  containing the simulated replicates.}

  \item{prefix}{character string to be appended to each
  individual file name across all loci}

  \item{pathin}{path (i.e., directory) where the simulated
  files are located.}

  \item{pathout}{path (i.e., directory) where the the
  individual replicates will be located.}
}
\value{
TRUE, but really used for its side effect of generating
individual replicate for each locus.
}
\description{
Apply \code{\link[seqManagement]{splitMultiAlignments}} on
all loci.
}
\details{
Given a regexp pattern that match multiple files
representing loci of an alignment simulated by seq-gen,
this function applies
\code{\link[seqManagement]{splitMultiAlignments}} on each
of them.

This function may produce a large number of files. If you
generated 500 replicates and you have 5 loci, 2,500 files
will be generated.

If \code{pathout} does not exist, it will be created.
}
\author{
Francois Michonneau
}
\seealso{
\code{\link[seqManagement]{splitMultiAlignments}}
}

