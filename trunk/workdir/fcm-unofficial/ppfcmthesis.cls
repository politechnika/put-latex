%
% This is a LaTeX class for master and bachelor theses following the guidelines
% of Faculty of Computer Science and Management at Poznan University of technology.
%
% This class is UNOFFICIAL and NOT ENDORSED by the university.
%
% Written by Dawid Weiss.
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
Politechnika Pozna\'nska\\Instytut Informatyki
\else
Poznan University of Technology\\Institute of Computer Science
\fi\end{center}}

\pretitle{\vspace{3cm}\begin{center}\Large\bfseries\MakeUppercase}
\posttitle{\end{center}}

\renewcommand{\maketitlehookb}{\vspace{1cm}}

\renewcommand{\maketitlehookc}{\vfill\begin{center}
\if@pppolish
Promotor\\\@ppsupervisor
\else
Thesis supervisor\\\@ppsupervisor
\fi
\vspace{2cm}\begin{center}Pozna\'n, \@ppyear\end{center}
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

\settypeblocksize{*}{32pc}{1.618}
\setlrmargins{*}{1.47in}{*}
\setulmargins{*}{*}{1.3}
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

\checkandfixthelayout
\tightlists


