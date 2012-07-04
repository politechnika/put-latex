%
%  $Id: csthesis.cls,v 1.19 2008/02/07 09:39:07 sobaniec Exp $
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{csthesis}[2005/06/29 v1.1 CS Thesis class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions
\LoadClass{book}


\RequirePackage{geometry}
\RequirePackage[outermarks,pagestyles,clearempty,%
                psfloats,rigidchapters,newlinetospace]{titlesec}
\RequirePackage{titletoc}
\RequirePackage[theorems]{dcslib}
\RequirePackage{dcsalg}
\RequirePackage[nottoc,notlot,notlof]{tocbibind}
\RequirePackage{setspace}
\RequirePackage{pifont}
\RequirePackage{natbib}

\DeclareOption{noimplicit}{
  \PassOptionsToPackage{unicode=true,implicit=false}{hyperref}
}
\ProcessOptions\relax
\RequirePackage[unicode=true]{hyperref}


% line skip
\setstretch{1.1}


% front/back matters
\renewcommand\frontmatter{%
  \cleardoublepage%
  \@mainmatterfalse%
  \pagenumbering{arabic}}
\renewcommand\mainmatter{%
  \cleardoublepage
  \@mainmattertrue}


% colors
\definecolor{seccolor}{rgb}{0.6,0.6,0.6}
\definecolor{gray}{rgb}{0.5,0.5,0.5}
\definecolor{midgray}{rgb}{0.4,0.4,0.4}


% fonts
\newcommand{\secfont}{\fontfamily{pag}\selectfont}
% tt font
\renewcommand{\ttdefault}{lmtt}
\lstset{basewidth=0.5em}


\renewcommand{\and}{\par}
\renewcommand{\maketitle}{%
  \begin{titlepage}
  \secfont
  \setlength{\parindent}{0pt}
  \null\vfill
  \hfill\begin{minipage}{\textwidth}
    \begin{center}
      {\fontsize{18}{20}\selectfont\@title\par}
      \fontsize{12}{14}\selectfont
      \vspace{5mm}
      {\@author}\par
      \vspace{5mm}
      {\fontsize{10}{12}\selectfont \@date}
    \end{center}
  \end{minipage}\hspace{1cm}\hfill\null
  \vfill\null
  \end{titlepage}
  \clearpage
}


% hyperref
\hypersetup{pdfpagemode=UseNone,colorlinks,breaklinks,
            bookmarksopen,bookmarksnumbered,
            bookmarksopenlevel=1,
            urlcolor=black,linkcolor=black,citecolor=black,
            plainpages=false,hypertexnames=false}


% page layout
\newlength{\headindent}
\setlength{\headindent}{2.5cm}

\geometry{a4paper,tmargin=3cm,bmargin=2.8cm,lmargin=4.5cm,rmargin=2.5cm,
          headsep=35pt,footskip=1.5cm,bindingoffset=0.5cm,
          reversemarginpar,marginparwidth=2.5cm,marginparsep=0.5cm,
          asymmetric}

% oneside
\DeclareOption{oneside}{
  \geometry{twoside=false,lmargin=5cm,rmargin=2.5cm,bindingoffset=0cm}
}


% dcsalg
\dcsalgset{boxed,number,width=0.95\textwidth,font=\small}


% heading indent
\widenhead{\headindent}{0pt}


% titlesec
\titleformat{name=\chapter}[block]{\secfont\Huge\filleft}{}{0em}%
    {\parbox{0.9\textwidth}%
       {\raggedleft\fontfamily{phv}\fontsize{65}{50}\selectfont%
        \textcolor{seccolor}{\thechapter}}\vspace{0.5ex}\\}
\titleformat{name=\chapter,numberless}[block]{\secfont\Huge\filleft}{}{0em}{}
\titlespacing*{\chapter}{-\headindent}{0.5cm}{7cm}
\titleformat{\section}{\secfont\LARGE}{\thesection}{1em}{}[\titleline{\titlerule}]
\titlespacing*{\section}{-\headindent}{3.5ex plus 1ex minus 0.2ex}{4ex plus 0.2ex}

\titleformat{\subsection}{\secfont\Large}{\thesubsection}{1em}{}
\titlespacing*{\subsection}{0pt}{3.25ex plus 1ex minus 0.2ex}{1.5ex plus 0.2ex}

\titleformat{\subsubsection}{\secfont\large}{\thesubsubsection}{1em}{}

\titleformat{\paragraph}[runin]{\scshape}{}{0em}{}
\titlespacing{\paragraph}{0pt}{2.5ex plus 0.6ex minus 0.2ex}{1em}
\titleformat{\subparagraph}[runin]{\em}{}{0em}{}
\titlespacing{\subparagraph}{0pt}{2.5ex plus 0.8ex minus 0.15ex}{1em}


% toc
\titlecontents{chapter}[1.5em]{\addvspace{1.8ex}\secfont\bfseries}%
  {\contentslabel{1.5em}}{\hspace*{-1.5em}}%
  {~\hfill\contentspage}[\addvspace{0.3ex}]


% page styles
\renewpagestyle{plain}{
  \sethead{}{}{}
  \setfoot{}{}{}
}
\renewpagestyle{empty}{
  \sethead{}{}{}
  \setfoot{}{}{}
}
\newcommand{\setdefmainpagestyle}{
  \sethead[\large\usepage][]%
  [\footnotesize\itshape
    \if@mainmatter
      \ifthenelse{\value{chapter}>0}{\thechapter~~}{}
    \fi
    \chaptertitle]%
  {\footnotesize\itshape
    \if@mainmatter
      \ifthesection{\thesection~~\sectiontitle}%
                   {\ifthenelse{\value{chapter}>0}{\thechapter~~}{}\chaptertitle}
    \else
      \chaptertitle
    \fi
  }{}{\large\usepage}
  \setfoot{}{}{}
  \setfloathead{}{}{}{\setheadrule{0pt}}[p]
}
\newpagestyle{main}{\setdefmainpagestyle}

\newcommand{\workinginfo}{info}
\DeclareOption{working}{
  \renewpagestyle{plain}{
    \setfoot[\workinginfo][][]{}{}{\workinginfo}
  }
  \renewpagestyle{main}{
    \setdefmainpagestyle
    \setfoot[\workinginfo][][]{}{}{\workinginfo}
  }
}
\AtBeginDocument{\pagestyle{main}}


% extra commands

\newcommand{\OP}[2]{\langle #1, #2 \rangle}
% write identifier
\newcommand{\WID}{wI\!D}
% write-sets
\newcommand{\WS}{W\!S}
\newcommand{\WSx}{\widehat{\WS}}
\newcommand{\WSO}{W\!S_{o}}
\newcommand{\WSC}{W\!S_{c}}
\newcommand{\MSG}[1]{\left\langle #1 \right\rangle}
% table font
\newcommand{\TF}{\sffamily\small}
\newcommand{\TFS}{\sffamily\footnotesize}

% marginpar
\newcommand{\mpar}[1]{\marginpar{\raggedleft\footnotesize#1}}
\newcommand{\mparnote}[1]{\mpar{\itshape\textcolor{blue}{#1}}}
\newcommand{\mcomm}[1]{\marginpar{\raggedright\itshape\footnotesize#1}}
\newcommand{\marbox}[1]{\colorbox{gray}{\textcolor{white}{%
            \textsf{\footnotesize\bfseries #1}}}}
\newcommand{\defmarker}[1]{%
  \marginpar{\raggedleft\parbox{1.5cm}{\centering\marbox{#1}}}}
\newcommand{\DEF}{\defmarker{DEF}}
\newcommand{\LEM}{\defmarker{LEM}}
\newcommand{\THM}{\defmarker{THM}}
\newcommand{\EXM}{\marginpar{\raggedleft\parbox{1.5cm}{%
  \centering\textcolor{midgray}{\framebox{\textsf{\footnotesize\bfseries EXM}}}}}}


% math spacing
\setlength{\arraycolsep}{1.4\p@}
\setlength{\tabcolsep}{5\p@}
\renewcommand{\mod}{\ensuremath{\:\%\:}}


% dings
\newcommand{\DG}{\ding{52}}


% floats
\setcounter{topnumber}{1}


\ProcessOptions\relax
