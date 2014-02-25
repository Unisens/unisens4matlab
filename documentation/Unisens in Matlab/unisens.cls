\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{unisens}[2008/07/01 v0.1 Template for Unisens documentation]
\LoadClass[a4paper, 10pt, oneside, DIV10, tablecaptionabove]{scrartcl}
\RequirePackage{color}
\RequirePackage{titlesec}
\RequirePackage{textcomp}
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage{amssymb}
\RequirePackage{helvet}
%\RequirePackage{lmodern}
\ProcessOptions


\addtolength{\textwidth}{-1cm}
\addtolength{\oddsidemargin}{1cm}
\definecolor{unisensBlue}{rgb}{0.0471, 0.2118, 0.3804}
\definecolor{unisensGray}{rgb}{0.7608, 0.7608, 0.7608}

\titleformat{\section}[hang]%[frame][display]
{\leftskip=-1cm\usekomafont{sectioning}\Large\color{unisensBlue}}
{\thesection~}{0mm}{}
[\vspace{-1.8ex}\hspace{0cm}\titlerule]

\titleformat{\subsection}[hang]%[frame][display]
{\usekomafont{sectioning}\large\color{unisensBlue}}
{\thesubsection~}{0mm}{}
\setkomafont{paragraph}{\small}
\setkomafont{descriptionlabel}{\sffamily\small\bfseries}

\newcommand{\note}[1]{\marginpar{\raggedright\textsf{\footnotesize\bfseries#1}}}
\newcommand{\code}[1]{\texttt{\hyphenchar\font=-1 #1}}
\renewcommand{\labelitemi}{\raisebox{0.2ex}{\tiny\color{unisensBlue}$\blacksquare$}}
\renewcommand{\labelitemii}{\raisebox{0.2ex}{\tiny\color{unisensBlue}$\square$}}
\renewcommand{\labelitemiii}{\raisebox{0.2ex}{\tiny\color{unisensGray}$\blacksquare$}}
\renewcommand{\labelitemiv}{\raisebox{0.2ex}{\tiny\color{unisensGray}$\square$}}
\setkomafont{captionlabel}{\sffamily\bfseries\small\raggedright}
\setcapindent{0em}
\setcapwidth[l]{\textwidth}
\fancyfoot[RH]{}
\fancyfoot[LH]{}
\fancyfoot[RF]{}
\fancyfoot[LF]{}
\fancyfoot[CF]{\hspace{-0.5cm}\thepage}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

\def\unisens@title{}
\renewcommand{\title}[1]{\def\unisens@title{#1}}
\def\unisens@subject{}
\newif\ifsubject\subjectfalse
\renewcommand{\subject}[1]{\def\unisens@subject{#1}\subjecttrue}
\def\unisens@date{\today}
\renewcommand{\date}[1]{\def\unisens@date{#1}}
\def\unisens@author{}
\newif\ifauthor\authorfalse
\renewcommand{\author}[1]{\def\unisens@author{#1}\authortrue}

\renewcommand{\maketitle}{%
  %\thispagestyle{empty}
	\hspace{-1.35cm}\parbox[t]{\textwidth}{%
  \usekomafont{sectioning}\color{unisensBlue}\huge\unisens@title%
  \ifsubject
	  \\[0.3ex]%
  	\usekomafont{sectioning}\color{unisensBlue}\large\unisens@subject%
  \fi
 	\\[1\baselineskip]%
  \ifauthor
  	\usekomafont{sectioning}\color{unisensGray}\large\unisens@author%
	  \\[0.5\baselineskip]%
  \fi
  \usekomafont{sectioning}\color{unisensGray}\large\unisens@date}
  \vspace{1cm}
}
\AtBeginDocument{%
  \pagestyle{fancy}%
}
\endinput
