#!/usr/bin/Rscript

# Elimina esta línea innecesaria
# knitr::clean_cache()

# Si estás usando sintaxis Sweave (<<>>= @), no necesitas Sweave2knitr
# knitr::Sweave2knitr("notas.Rnw")  # solo si vas a convertir a R Markdown

# Procesa el documento con knitr
knitr::knit("notas.Rnw")

# Compila a PDF
tools::texi2pdf("notas.tex")
