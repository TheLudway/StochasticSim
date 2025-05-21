;; -*- lexical-binding: t; -*-

(TeX-add-style-hook
 "referencias"
 (lambda ()
   (LaTeX-add-bibitems
    "ross2014introduction"
    "bruce2020practical"))
 '(or :bibtex :latex))

