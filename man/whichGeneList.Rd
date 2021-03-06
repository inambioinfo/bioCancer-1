% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Portal.R
\name{whichGeneList}
\alias{whichGeneList}
\title{Verify which gene list is selected}
\usage{
whichGeneList(geneListLabel)
}
\arguments{
\item{geneListLabel}{The label of GeneList. There are three cases:
 "Genes" user gene list,
 "Reactome_GeneList" GeneList plus genes from reactomeFI
"file name" from Examples}
}
\value{
Gene List label
}
\description{
Verify which gene list is selected
}
\examples{
How <- "runManually"
\dontrun{
whichGeneList("102")
}
}
