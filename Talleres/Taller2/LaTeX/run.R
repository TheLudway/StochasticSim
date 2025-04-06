#!/usr/bin/Rscript

knitr::Sweave2knitr("notas.Rnw")
knitr::knit("notas.Rnw")
tools::texi2pdf("notas.tex")
