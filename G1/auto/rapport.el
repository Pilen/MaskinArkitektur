(TeX-add-style-hook "rapport"
 (lambda ()
    (LaTeX-add-labels
     "fig:shifterchoice"
     "fig:shiftertest"
     "fig:circ1"
     "fig:alu-1bit"
     "fig:circ2"
     "fig:adder"
     "fig:overflow"
     "fig:mux2bit"
     "fig:mux4bit"
     "fig:circ3")
    (TeX-run-style-hooks
     "amsmath"
     "algorithmic"
     "todonotes"
     "graphicx"
     "booktabs"
     "hyperref"
     "fancyhdr"
     "listings"
     "inputenc"
     "utf8"
     "babel"
     "amssymb"
     "latex2e"
     "art10"
     "article"
     "10pt"
     "a4paper"
     "danish")))

