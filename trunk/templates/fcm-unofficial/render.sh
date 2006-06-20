#!/bin/bash

pdflatex thesis-english.tex 
bibtex thesis-english
pdflatex thesis-english.tex 
pdflatex thesis-english.tex 

pdflatex thesis-polski.tex 
bibtex thesis-polski
pdflatex thesis-polski.tex 
pdflatex thesis-polski.tex 

rm -f *.aux *.bak *.log *.blg *.bbl *.toc *.out
