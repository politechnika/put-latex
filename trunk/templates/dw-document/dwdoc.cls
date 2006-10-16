%
% This is a private LaTeX class documents, notes and other stuff.
% (c) 2006 Dawid Weiss
%
%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{dwdoc}[2006/10/16 v0.01 DW Documents]

%
% Declare default options and load base package (memoir).
%
\ExecuteOptions{a4paper,pl,11pt,oneside,final}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

\RequirePackage[left=3.17cm,right=3.17cm,top=2.54cm,bottom=2.54cm]{geometry}
\RequirePackage[onehalfspacing]{setspace}
\RequirePackage{booktabs}
\RequirePackage{graphicx}
\RequirePackage{fancyvrb}

%
% Configure Hyperref
%

\RequirePackage{url}
\RequirePackage{nameref}
\RequirePackage{varioref}

\usepackage[unicode,linktocpage,bookmarks]{hyperref}
\hypersetup{
    pdffitwindow=true,
    bookmarksnumbered=true,
    bookmarksopen=true,
    colorlinks=true,
    pdfpagelayout=SinglePage,
    pdfpagemode=UseOutlines,
    pdfstartview=Fit,
    linkcolor=black,
    citecolor=black,
    anchorcolor=black,
    filecolor=black,
    menucolor=black,
    pagecolor=black,
    urlcolor=black,
    pdftitle={},
    pdfauthor={},
    pdfkeywords={}
}
