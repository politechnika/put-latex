#!/bin/bash

#
# This will work, although a proper Makefile or latexmk is recommended.
# latexmk -pvc -pdf thesis-master-english.tex
#

for type in bachelor master; do
    for lang in english polski; do
        pdflatex thesis-$type-$lang.tex
        bibtex   thesis-$type-$lang
        pdflatex thesis-$type-$lang.tex
        pdflatex thesis-$type-$lang.tex
    done
done

rm -f *.aux *.bak *.log *.blg *.bbl *.toc *.out

