#!/usr/bin/Rscript

knitr::knit("notas.Rnw")
tools::texi2pdf("notas.tex")

