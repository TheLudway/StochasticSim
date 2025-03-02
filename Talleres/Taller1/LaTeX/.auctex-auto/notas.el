;; -*- lexical-binding: t; -*-

(TeX-add-style-hook
 "notas"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "12pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("graphicx" "") ("amsmath" "") ("geometry" "margin=1in") ("fancyhdr" "") ("enumerate" "") ("enumitem" "shortlabels") ("babel" "spanish") ("xurl" "") ("tcolorbox" "") ("titlesec" "")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art12"
    "graphicx"
    "amsmath"
    "geometry"
    "fancyhdr"
    "enumerate"
    "enumitem"
    "babel"
    "xurl"
    "tcolorbox"
    "titlesec")
   (LaTeX-add-labels
    "fig:caja-canica"
    "fig:caja-2")
   (LaTeX-add-counters
    "subsubsubsection"))
 :latex)

