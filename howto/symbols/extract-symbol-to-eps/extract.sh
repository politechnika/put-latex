#!/bin/bash

latex extract.tex
latex extract.tex
latex extract.tex

dvips extract.dvi
rm -f extract.eps && ps2eps extract.ps
epstopdf extract.eps

rm -f *.log *.aux *.ps *.dvi