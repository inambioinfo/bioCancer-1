% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/radiant.R
\name{returnTextAreaInput}
\alias{returnTextAreaInput}
\title{Return message when the filter formula is not correct (mRNA > 500)}
\usage{
returnTextAreaInput(inputId,
                          label= NULL,
                          rows = 2,
                         placeholder = NULL,
                         resize= "vertical",
                         value = "")
}
\arguments{
\item{inputId}{The ID of the object}

\item{label}{Text describes the box area}

\item{rows}{Number of rows}

\item{placeholder}{Error message if needed}

\item{resize}{orientation of text}

\item{value}{default text in the area box}
}
\value{
text message
}
\description{
Return message when the filter formula is not correct (mRNA > 500)
}
\examples{
ShinyApp <-  1
\dontrun{
returnTextAreaInput(inputId = "data-filter",
                    label = "Error message",
                    rows =  2,
                    placeholder = "Provide a filter (e.g., Genes == 'ATM') and press return",
                    resize = "vertical",
                    value="")
}
}
