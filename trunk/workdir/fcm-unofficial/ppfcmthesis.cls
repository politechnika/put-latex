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

%
% Customize title page
%
\aliaspagestyle{title}{empty}
\date{}
\newcommand{\ppsupervisor}[1]{\def\@ppsupervisor{#1}}
\newcommand{\ppyear}[1]{\def\@ppyear{#1}}

\setlength{\droptitle}{0cm}

\renewcommand{\maketitlehooka}{\noindent%
\begin{center}
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


