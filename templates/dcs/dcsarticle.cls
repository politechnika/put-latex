%
%  $Id: dcsarticle.cls,v 1.30 2006/09/01 18:34:07 sobaniec Exp $
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dcsarticle}[2006/09/01 v1.0 DCS Group article class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}


\RequirePackage{geometry}
\RequirePackage[pagestyles,clearempty,psfloats]{titlesec}
\RequirePackage{dcslib}[2006/09/01]
\RequirePackage{setspace}

\DeclareOption{noimplicit}{
  \PassOptionsToPackage{implicit=false}{hyperref}
}
\ProcessOptions\relax
\RequirePackage{hyperref}


% default page layout
\newlength{\bindinglen}
\setlength{\bindinglen}{0.5cm}
\geometry{a4paper,tmargin=3cm,bmargin=3cm,lmargin=2.75cm,rmargin=2.75cm,
          bindingoffset=0cm}

% twoside
\DeclareOption{twoside}{
  \geometry{twoside=true,lmargin=2.5cm,rmargin=2.5cm,
            bindingoffset=\bindinglen}
}


% fonts
\newcommand{\secfont}{\fontfamily{pag}\selectfont}


% page styles
\newpagestyle{main}[\footnotesize\itshape]{
  \sethead{}{}{}
  \setfoot{}{\rm\normalsize\thepage}{}
  \setfloathead{}{}{}{\setheadrule{0pt}}[p]
}
\pagestyle{main}


% matters
\newif\if@mainmatter \@mainmattertrue
\newcommand\mainmatter{%
  \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}}
\newcommand\backmatter{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \@mainmatterfalse}


% sectioning
\DeclareOption{sanssec}{
  \titleformat{\section}{\secfont\LARGE}{\thesection}{1em}{}
  \titleformat{\subsection}{\secfont\Large}{\thesubsection}{1em}{}
  \titleformat{\subsubsection}{\secfont\large}{\thesubsubsection}{1em}{}
  \titleformat{\subparagraph}[runin]{\em}{}{0em}{}
  \titlespacing{\subparagraph}{0pt}{\bigskipamount}{1em}
}


% report option
\DeclareOption{report}{
  \renewcommand{\and}{\par}
  \renewcommand{\maketitle}{%
    \begin{titlepage}
    \secfont
    \setlength{\parindent}{0pt}
    \null\vfill
    \hfill\begin{minipage}{12.5cm}
      \begin{center}
        {\fontsize{18}{20}\selectfont\@title\par}
        \fontsize{12}{14}\selectfont
        \vspace{5mm}
        {\@author}\par
        \vspace{5mm}
        {\fontsize{10}{12}\selectfont \techreportname\ \@date}
      \end{center}
    \end{minipage}\hspace{\bindinglen}\hfill\null
    \vfill\null
    \end{titlepage}
    \cleardoublepage
  }

  \renewcommand\tableofcontents{%
    \section*{\contentsname}
    \pagestyle{empty}
    \@starttoc{toc}
    \cleardoublepage
    \pagestyle{main}}

  % page layout
  \geometry{tmargin=3.5cm,bmargin=3cm,lmargin=2.75cm,rmargin=2.75cm,
            headsep=7ex,footskip=0cm,bindingoffset=\bindinglen}

  % line space
  \setstretch{1.1}

  \ExecuteOptions{sanssec}

  \setlength{\parindent}{1pc}
 
  % parskip
  \setlength{\parskip}{0.6ex}

  % page styles
  \renewpagestyle{plain}{
    \setfoot{}{}{}
  }
  \renewpagestyle{main}[\footnotesize\itshape]{
    \headrule
    \sethead[\rm\normalsize\thepage][]%
            [\if@mainmatter
               \thesection~~\sectiontitle
             \else
               \sectiontitle
             \fi]%
            {\if@mainmatter
               \thesection~~\sectiontitle
             \else
               \sectiontitle
             \fi}{}{\rm\normalsize\thepage}
    \setfloathead{}{}{}{\setheadrule{0pt}}[p]
  }
  \pagestyle{main}

  % abstract environment
  \renewenvironment{abstract}
    {
     \thispagestyle{plain}
     \mbox{}\vfill
     \begin{list}{}{
       \setlength{\leftmargin}{0.1\textwidth}
       \setlength{\rightmargin}{0.1\textwidth}
       \begin{center}
         \secfont\large\abstractname
       \end{center}
       }
       \item\relax
    }
    {\end{list}\vfill\vfill\vfill\mbox{}
     \cleardoublepage
    }

}


% hyperref
\hypersetup{pdfpagemode=UseNone,colorlinks,breaklinks,
            bookmarksopen,bookmarksnumbered,
            bookmarksopenlevel=1,
            urlcolor=black,linkcolor=black,citecolor=black,
            plainpages=false,hypertexnames=false}


\DeclareOption{web}{
  \hypersetup{urlcolor=linkcolor,linkcolor=linkcolor,%
              citecolor=linkcolor}
  \hyperbaseurl{file:/}
  \lstset{language=c}
  \lstset{keywordstyle=\bfseries\color{dkgreen},
          commentstyle=\itshape\color{dkblue},
          stringstyle=\color{dkred},
          directivestyle=\color{directive}}
  \lstset{language=}
  % switch off two side
  \geometry{twoside=false,lmargin=2.75cm,rmargin=2.75cm,bindingoffset=0cm}
}


\ProcessOptions\relax
