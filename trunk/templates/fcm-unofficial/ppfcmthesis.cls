%
% This is a LaTeX class for master and bachelor theses following the guidelines
% of Faculty of Computer Science and Management at Poznan University of technology.
%
% This class is UNOFFICIAL and NOT ENDORSED by the university.
%
% Written by Dawid Weiss.
%
%
% Todo:
% - chapter header style.
% - figure and table header styles (and numeration)
% - itemization styles (I'd leave them as they are defined in memoir)
%
%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{ppfcmthesis}[2006/02/16 v0.9 PP FCM thesis class]
\newif\if@pppolish
%
% Declare default options and load base package (memoir).
%
\DeclareOption{en}{\@pppolishfalse}
\DeclareOption{pl}{\@pppolishtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
\ExecuteOptions{a4paper,pl,11pt,oneside,final}
\ProcessOptions\relax
\LoadClass{memoir}

%
% Require additional packages
%
\RequirePackage{textpos}
\if@pppolish
\RequirePackage{polski}
\fi
\RequirePackage{setspace}
\RequirePackage{graphicx}
\ifx\pdfoutput\undefined
	\DeclareGraphicsExtensions{.eps}
\else
	\DeclareGraphicsExtensions{.pdf,.png,.jpg}
\fi
\RequirePackage{fancyvrb}

%
% Customize title page
%
\aliaspagestyle{title}{empty}
\date{}
\newcommand{\ppsupervisor}[1]{\def\@ppsupervisor{#1}}
\newcommand{\ppyear}[1]{\def\@ppyear{#1}}

\setlength{\droptitle}{0cm}

\renewcommand{\maketitlehooka}{%
\begin{center}
\begin{textblock}{10}(0,0)\hfill\includegraphics[width=1.5cm]{figures/template/logo-pp}\end{textblock}%
\if@pppolish
Politechnika Pozna\'nska\\Wydzia{\l} Informatyki i Zarz{\k{a}}dzania\\Instytut Informatyki
\else
Poznan University of Technology\\Faculty of Computer Science and Management\\Institute of Computer Science
\fi\end{center}}

\pretitle{\vspace{2cm}\begin{center}\if@pppolish Praca dypomowa magisterska\else Master's thesis\fi\par\vspace{1cm}\Large\bfseries\MakeUppercase}
\posttitle{\end{center}}

\renewcommand{\maketitlehookb}{\vspace{1cm}}

\renewcommand{\maketitlehookc}{\vfill\begin{center}
\if@pppolish
Promotor\\\@ppsupervisor
\else
Thesis supervisor\\\@ppsupervisor
\fi
\vspace{2cm}\begin{center}Pozna\'n, \@ppyear\if@pppolish~r.\fi\end{center}
}

%
% Customize running titles and page style.
%

\makepagestyle{ppfcmthesis}
\makeevenfoot{ppfcmthesis}{}{}{}
\makeatletter
\newcommand{\@ppfcmthesismarks}{%
  \let\@mkboth\markboth
  \def\chaptermark##1{\markboth{##1}{##1}}    % left mark & right marks
  \def\sectionmark##1{\markright{%
    \ifnum \c@secnumdepth>\z@
      \thesection. \ %
    \fi
    ##1}}
  \def\tocmark{\markboth{\contentsname}{}}
  \def\lofmark{\markboth{\listfigurename}{}}
  \def\lotmark{\markboth{\listtablename}{}}
  \def\bibmark{\markboth{\bibname}{}}
  \def\indexmark{\markboth{\indexname}{}}
}
\makepsmarks{ppfcmthesis}{\@ppfcmthesismarks}
\makeatother
\makeevenhead{ppfcmthesis}{\thepage}{}{\normalfont\small\itshape\leftmark}
\makeoddhead{ppfcmthesis}{\normalfont\small\itshape\rightmark}{}{\thepage}

%
% Customize book style
%
\pagestyle{ppfcmthesis}
\setstocksize{297mm}{210mm}
\settrimmedsize{297mm}{210mm}{*}
\settrims{0pt}{0cm}
\setlrmarginsandblock{3.5cm}{2.5cm}{*}
\setulmarginsandblock{2.5cm}{2.5cm}{*}
\setmarginnotes{6pt}{50pt}{\onelineskip}
\setheadfoot{\onelineskip}{2\onelineskip}
\setheaderspaces{*}{2\onelineskip}{*}
\onehalfspacing

\setcounter{tocdepth}{4}
\maxsecnumdepth{subsection}
\setsecnumdepth{subsection}

\changecaptionwidth
\captionwidth{.9\linewidth}
\captionnamefont{\footnotesize\scshape}
\captiontitlefont{\footnotesize}

\def\thesubsubsection {\thesubsection .\arabic{subsubsection}}

\tightlists
\checkandfixthelayout

%
% Macros 
%

% English
\newcommand{\termdef}[1]{\emph{#1}}
\newcommand{\acronym}[1]{\emph{\MakeUppercase{#1}}}

% Polish
\newcommand{\definicja}[1]{\termdef{#1}}
\newcommand{\akronim}[1]{\acronym{#1}}
\newcommand{\english}[1]{ang.~\emph{#1}}

% Table head
\newcolumntype{L}{c}\newcommand{\tabhead}[1]{\multicolumn{1}{L}{#1}}

