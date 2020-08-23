\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{rl_theory/rl_theory}

\ProcessOptions\relax

\LoadClass[a4paper]{report}  

\RequirePackage{catchfile}

\RequirePackage{rl_theory/globals}

\makeatletter 
\newcommand\mynobreakpar{\par\nobreak\@afterheading} 
\makeatother

\newcommand{\tsectionfmt}[3]{#1{\bf #2.\nobreak}#3\mynobreakpar}
\newcommand{\listgen}[3]{\ensuremath{#1_#2, \ldots, #1_{#3}}}
\newcommand{\listof}[2]{\listgen{#1}{1}{#2}}
\newcommand{\listn}[1]{\listof{#1}{n}}
\renewenvironment{part}[1]{\tsectionfmt{\underline}{#1}{}}{}
