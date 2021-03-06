% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/generateBashScript.R
\name{generateBashScript}
\alias{generateBashScript}
\title{Generate a bash script}
\usage{
generateBashScript(path, output, partfile, model, prefix, tree, seed,
  raxmlCmd = "raxmlHPC-PTHREADS-SSE3", raxmlArg = "-T7",
  overwrite = FALSE)
}
\arguments{
\item{path}{character string indicating the path (i.e., directory)
where the simulated datasets on which to run the likelihood
searches are stored.}

\item{output}{character string indicating the file name (and path
if needed) of where the script should be written.}

\item{partfile}{character string indicating the name of the
partition file to be used by RAxML during the likelihood
estimations on the simulated data sets (WARNING: this is *NOT* the
same as the partition file you might have used in your original
anlysis, instead use the path for the file that was generated by
\code{\link{finalizeAlignments}}).}

\item{model}{character string indicating the model of molecular
evolution to be used during the likelihood estimation on the
replicated datasets (should be the same as the one used for the
original analyses).}

\item{prefix}{character string indicating the prefix used to name
the individual RAxML runs, for instance if
\code{prefix="best"}, the RAxML run on the first replicated
dataset will be named: \code{RAxML_info.best-rep001}.}

\item{tree}{If \code{NULL} or missing, RAxML will look for the
\sQuote{best} tree (using the \sQuote{\code{-f d}} RAxML algorithm),
otherwise a character string indicating the file name of a tree to
be used as a constraint during the likelihood search (using the
\sQuote{\code{-f d -g}} RAxML algorithm).}

\item{seed}{character string indicating the seed to be used to
initiate the likelihood search in RAxML. If missing a 7-digit
random seed is generated.}

\item{raxmlCmd}{character string used to call RAxML. Adjust it
depending on your installation, and the flavor of RAxML you want
to use, (default is \dQuote{raxmlHPC-PTHREADS-SSE3}).}

\item{raxmlArg}{character string for additional arguments to be
passed to RAxML (default \dQuote{-T7})}

\item{overwrite}{What to do when a file with the same name as the
one specified by \code{output} already exists? if \code{TRUE} it
will be overwritten, otherwise an error will be thrown (default
\code{FALSE}).}
}
\value{
TRUE, but really used for its side effect of generating a
bash script that contains the appropriate command to run a
likelihood search on each of the replicate dataset.
}
\description{
This function generates a bash script that runs RAxML on each of
the replicated dataset.
}
\details{
For now, the bash script generated by this function is not very
elegant (to say the least), but it gets the job done.

If you want to use this function by yourself, the recommended
usage is to call it from the directory above where your alignments
are stored.

The seed provided or generated is used in all the calls.
}
\author{
Francois Michonneau
}

