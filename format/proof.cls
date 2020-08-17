\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{rl_theory/proof}

\ProcessOptions\relax

\LoadClass[a4paper]{report}  

\RequirePackage{rl_theory/globals}

\input{keywords.tex}
\input{notation.tex}

\RequirePackage{fancyhdr}
\pagestyle{fancy}

\renewcommand{\headrulewidth}{0pt}
\rhead{\currpath\vspace{10pt}}
\setlength{\headheight}{26pt}
