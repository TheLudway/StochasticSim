;; -*- lexical-binding: t; -*-

(TeX-add-style-hook
 "notas"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "12pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("graphicx" "") ("amsmath" "") ("geometry" "margin=1in") ("fancyhdr" "") ("enumerate" "") ("enumitem" "shortlabels") ("babel" "spanish") ("xurl" "") ("tcolorbox" "") ("titlesec" "") ("listings" "") ("xcolor" "") ("pgfplots" "") ("tikz" "") ("cancel" "") ("hyperref" "hidelinks")))
   (add-to-list 'LaTeX-verbatim-environments-local "lstlisting")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "lstinline")
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
    "titlesec"
    "listings"
    "xcolor"
    "pgfplots"
    "tikz"
    "cancel"
    "hyperref")
   (LaTeX-add-labels
    "subsec:p1-a"
    "subsec:p1-b"
    "subsec:p1-c"
    "subsec:p1-d"
    "subsec:p1-e")
   (LaTeX-add-counters
    "subsubsubsection")
   (LaTeX-add-listings-lstdefinestyles
    "RStyle"))
 :latex)

