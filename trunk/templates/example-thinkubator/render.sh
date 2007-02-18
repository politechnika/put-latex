#!/bin/bash

pdfplatex thesis-polski.tex || pdflatex thesis-polski.tex
bibtex thesis-polski
pdfplatex thesis-polski.tex || pdflatex thesis-polski.tex
pdfplatex thesis-polski.tex || pdflatex thesis-polski.tex

rm -f *.aux *.bak *.log *.blg *.bbl *.toc *.out
