\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gatechthesis}[2025/04/22 GA Tech MS/Ungraduate Thesis]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass{report}

% package imports
\RequirePackage{graphicx}
\RequirePackage[a4paper, left=1.5in, right=1in, top=1in, bottom=1in]{geometry}
\RequirePackage{multicol}
\RequirePackage{setspace}  
\RequirePackage{times} 
\RequirePackage[explicit]{titlesec} 
\RequirePackage[titles]{tocloft}
\RequirePackage{ifoddpage}
\RequirePackage{rotating} 
\RequirePackage[backend=biber,sorting=nyt, style=apa]{biblatex}
\RequirePackage[toc,page]{appendix} 
\RequirePackage[normalem]{ulem} 
\RequirePackage{url} 
\RequirePackage{siunitx} 
\RequirePackage[bookmarks=true,hidelinks]{hyperref}
\RequirePackage{bookmark} 
\RequirePackage{caption}
\RequirePackage{subcaption} 
\RequirePackage[acronym,nogroupskip,nopostdot]{glossaries}
\RequirePackage{doi} 
\RequirePackage{fancyhdr} 

\sisetup{
    sticky-per=true,
    detect-mode=true,
    per-mode = symbol-or-fraction
}

% --- Fancyhdr setup for page number in top right ---
\pagestyle{fancy} 
\fancyhf{} 
\fancyhead[R]{\thepage} % Page number in the top right corner
\renewcommand{\headrulewidth}{0pt} 
\renewcommand{\footrulewidth}{0pt}

\fancypagestyle{plain}{%
  \fancyhf{}
  % \fancyhead[R]{\thepage} % Remove or comment out this line to hide page number on chapter pages
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

\doublespacing 
\AtBeginDocument{\renewcommand{\ref}[1]{\autoref{#1}}}
\makeglossaries 
\urlstyle{same}
\hbadness=9000 
\setcounter{biburlnumpenalty}{99999}
\hypersetup{
    colorlinks,
    linkcolor={black},
    citecolor={black}, 
    urlcolor={black}
}

\makeatletter

% formatting of chapter numbers in bookmarks
\bookmarksetup{%
    depth=1, 
    addtohook={%
    \ifnum 0=\bookmarkget{level}\relax
      \renewcommand*{\numberline}[1]{#1 | }%
    \fi
    \ifnum 0<\bookmarkget{level}\relax
      \renewcommand*{\numberline}[1]{}%
    \fi
    }
}

\newcommand{\ALC@uniqueautorefname}{Line}
\newcommand{\algorithmautorefname}{Algorithm}

% set up rotatepage environment - this will make landscape figures with awareness of page parity and whether the document is set up as single- or two-sided
\@ifclasswith{report}{twoside}{%
    \newenvironment{rotatepage}{%
        \checkoddpage\ifoddpage
            \clearpage\pagebreak[4]\global\pdfpageattr\expandafter{\the\pdfpageattr/Rotate 270}%
        \else
            \clearpage\pagebreak[4]\global\pdfpageattr\expandafter{\the\pdfpageattr/Rotate 90}%
        \fi
        }%
        {\clearpage\pagebreak[4]\global\pdfpageattr\expandafter{\the\pdfpageattr/Rotate 0}}%
    }{
    \newenvironment{rotatepage}%
        {\clearpage\pagebreak[4]\global\pdfpageattr\expandafter{\the\pdfpageattr/Rotate 90}}%
        {\clearpage\pagebreak[4]\global\pdfpageattr\expandafter{\the\pdfpageattr/Rotate 0}}%
    }

% tokens for author info
\newcommand{\approvaldate}[1]{\gdef\@approvaldate{#1}}%
\newcommand{\@approvaldate}{\@latex@warning@no@line{No \noexpand\approvaldate given}}
\newcommand{\school}[1]{\gdef\@school{#1}}%
\newcommand{\@school}{\@latex@warning@no@line{No \noexpand\school given}}
\newcommand{\department}[1]{\gdef\@department{#1}}%
\newcommand{\@department}{\@latex@warning@no@line{No \noexpand\department given}}
\makeatother

% frontmatter environment, only handles title formatting
\newenvironment{frontmatter}{%
    \clearpage
    \pagestyle{plain}
    \titleformat{\chapter}[display]{\normalfont\bfseries\filcenter}{\chaptertitlename\ \thechapter}{0pt}{\MakeUppercase{##1}}
}%
{%
}

% thesisbody environment, handles text and other formatting 
\newenvironment{thesisbody}{%
    \clearpage
    \pagestyle{fancy}
    \pagenumbering{arabic} % resumes page numbering after front matter
    \setcounter{page}{1} % set the page number appropriately
    \titleformat{\chapter}[block]{\normalfont\bfseries\filcenter}{\MakeUppercase{CHAPTER \thechapter.}}{0.5em}{\MakeUppercase{##1}}  % modified to put chapter and title on same line
    \titlespacing*{\chapter}
      {0pt}{0pt}{30pt}	% controls vertical margins on title
    \titleformat{\section}{\normalfont\bfseries}{\thesection}{1em}{##1}
    \titleformat{\subsection}{\normalfont\small\bfseries}{\thesubsection}{1em}{##1}
    \titleformat{\subsubsection}{\normalfont\itshape}{\thesubsection}{1em}{##1}
}%
{
    \clearpage
}

% ------------------ Title Page ------------------
\makeatletter
% args: {month}{year}
\newcommand{\makeTitlePage}[2]{
    \pagestyle{empty}
    \pagenumbering{roman}
    \currentpdfbookmark{Title Page}{titlePage}
    \phantomsection
    \begin{center}
    \bfseries % Add \bfseries here to make all text bold
    \begin{singlespacing}
    \@title\\ % Removed explicit \textbf{} as \bfseries applies globally
    \vspace{6\baselineskip}

    A Thesis by\\ % Removed explicit \textbf{}
    \vspace{6\baselineskip}

    \@author\\ % Removed explicit \textbf{}
    \vspace{7\baselineskip}

    Submitted to the Department of Bachelor of Science in Computer Science\\
    College of Computing and Information Sciences (CCIS)\\
    Caraga State University – Main Campus\\
    \vspace{6\baselineskip}

    In Partial Fulfillment\\
    of the Requirements for the Degree\\
    Bachelor of Science in Computer Science (BSCS)\\

    \vfill % This will push the date to the bottom of the page

    #1 #2 \\
    \vspace{0.5in} % Add some space at the bottom

    \end{singlespacing}
    \end{center}
}

% ------------------ Approval page environment/formatting ------------------

\newenvironment{approvalPage}
{
    \clearpage
    \phantomsection
    \addcontentsline{toc}{chapter}{APPROVAL SHEET}
    \begin{centering}
    \textbf{APPROVAL SHEET}\\
    \vspace{\baselineskip}
    \end{centering}
}
{
    \clearpage
}

% --- Dedication Environment ---
\newenvironment{dedication}
{
    \clearpage
    \phantomsection
    \addcontentsline{toc}{chapter}{DEDICATION}
    \begin{centering}
    \textbf{DEDICATION}\\
    \vspace{\baselineskip}
    \end{centering}
}
{
    \clearpage
}

% ------------------ Acknowledgment environment/formatting ------------------
\newenvironment{acknowledgment}
{
    \clearpage
    \phantomsection
    \addcontentsline{toc}{chapter}{ACKNOWLEDGMENT}
    \begin{centering}
    \textbf{ACKNOWLEDGMENT}\\
    \vspace{\baselineskip}
    \end{centering}
}
{
    \clearpage
}

% ------------------ abstract environment definition ------------------
\renewenvironment{abstract}
{
    \clearpage
    \phantomsection
    \addcontentsline{toc}{chapter}{ABSTRACT}
    \begin{centering}
    \textbf{ABSTRACT}\\
    \vspace{\baselineskip}
    \end{centering}
}{
}

% --------------- table of contents formatting and command creation ---------------
% \renewcommand{\cftchapdotsep}{\cftdotsep}  % add dot separators for chapters
\renewcommand{\cftsecdotsep}{10000} % remove dots for sections
\renewcommand{\cftsubsecdotsep}{10000} % remove dots for subsections
\renewcommand{\cftsubsubsecdotsep}{10000} % remove dots for subsubsections
\renewcommand{\cftfigdotsep}{10000} % remove dots for List of Figures
\renewcommand{\cfttabdotsep}{10000} % remove dots for List of Tables
\renewcommand{\cftchapfont}{\bfseries}  % set title font weight but remove uppercase
\renewcommand{\cftchappagefont}{}  % set page number font weight
\renewcommand{\cftchappresnum}{CHAPTER }
\renewcommand{\cftchapaftersnum}{:}
\renewcommand{\cftchapnumwidth}{6em} 
\renewcommand{\cftchapafterpnum}{\vskip\baselineskip} % set correct spacing for entries in single space environment
\renewcommand{\cftsecafterpnum}{\vskip\baselineskip}  % set correct spacing for entries in single space environment
\renewcommand{\cftsubsecafterpnum}{\vskip\baselineskip} % set correct spacing for entries in single space environment
\renewcommand{\cftsubsubsecafterpnum}{\vskip\baselineskip} % set correct spacing for entries in single space environment

\newcommand{\makeTOC}{
    % format title font size and position (this also applies to list of figures and list of tables)
    \currentpdfbookmark{Table of Contents}{TOC}
    \renewcommand\contentsname{Table of Contents}
    \begin{singlespace}
    \tableofcontents
    \end{singlespace}
    \clearpage
}

% ------------------ List of Tables ------------------
\newcommand{\makeListOfTables}{
\phantomsection
\addcontentsline{toc}{chapter}{LIST OF TABLES}
\begin{singlespace}
\setlength\cftbeforetabskip{\baselineskip}  % manually set spacing between entries
\listoftables
\end{singlespace}
\clearpage
}

% ------------------ List of Figures ------------------
\newcommand{\makeListOfFigures}{
\phantomsection
\addcontentsline{toc}{chapter}{LIST OF FIGURES}
\begin{singlespace}
\setlength\cftbeforefigskip{\baselineskip}  % manually set spacing between entries
\listoffigures
\end{singlespace}
\clearpage
}

% ------------------ List of Acronyms ------------------
\newcommand{\makeListOfAcronyms}{
\phantomsection
\addcontentsline{toc}{chapter}{LIST OF ACRONYMS}
\printglossary[type=\acronymtype,title=LIST OF ACRONYMS]
}

% ------------------ appendix environment definition ------------------
% A note on layout: in the Chicago (and by extension IEEE) style manual, appendices are first in the end matter, then bibliography or references. In APA, bibliography is first, then appendices. The thesis manual on which this template is based assumes the Chicago convention.

% remove the page number on the appendices cover and move bookmark up the page, create a group-subgroup structure for the appendices in the TOC/bookmarks
\makeatletter
\newenvironment{theappendices}{
    \bookmarksetup{depth=0,open}
    \addtocontents{toc}{\setcounter{tocdepth}{1}}
    \renewcommand{\addappheadtotoc}{%
      \phantomsection
      \addcontentsline{toc}{chapter}{\MakeUppercase{\appendixpagename}}%
    }
    \renewcommand{\@chap@pppage}{%
        \clear@ppage
        \addappheadtotoc 
        \thispagestyle{empty}%
        \if@twocolumn\onecolumn\@tempswatrue\else\@tempswafalse\fi
        \null\vfil
        \markboth{}{}%
        {\centering
        \interlinepenalty \@M
        \normalfont
        \Huge \bfseries \MakeUppercase{\appendixpagename}\par}% 
        \if@dotoc@pp
        \fi
    }
    \bookmarksetupnext{level=part}
    \begin{appendices}
    \addtocontents{toc}{\protect\renewcommand{\protect\cftsecpresnum}{\appendixname\space}}
    \addtocontents{toc}{\protect\renewcommand{\protect\cftsecnumwidth}{5.75em}}
    \addtocontents{toc}{\protect\renewcommand{\protect\cftsecaftersnum}{:}}
    \addtocontents{toc}{%
    \begingroup
        \let\protect\l@chapter\protect\l@section
        \let\protect\l@section\protect\l@subsection
    }
}{
    \addtocontents{toc}{\endgroup}
    \end{appendices}
}
\makeatother

% ------------------ bibliography formatting and command creation ------------------

% I am only leaving these \AtEveryBibitem lines in because they were in the original template when I downloaded it. Change these at your own leisure.

% prevent certain fields in references from printing in bibliography
\AtEveryBibitem{\clearfield{issn}}
\AtEveryBibitem{\clearlist{issn}}
\AtEveryBibitem{\clearfield{language}}
\AtEveryBibitem{\clearlist{language}}
% \AtEveryBibitem{\clearfield{doi}} 
% \AtEveryBibitem{\clearlist{doi}}
\AtEveryBibitem{\clearfield{url}}
\AtEveryBibitem{\clearlist{url}}
\AtEveryBibitem{%
\ifentrytype{online}{}
    {\clearfield{urlyear}\clearfield{urlmonth}\clearfield{urlday}}}

\newcommand{\makeBibliography}{
    \clearpage
    \bookmarksetupnext{level=part}
    \phantomsection
    \addcontentsline{toc}{chapter}{REFERENCES}
    \begin{centering}
    \textbf{REFERENCES}\\
    \end{centering}
    \begin{singlespace}  % use single-line spacing for multi-line text within a single reference
    \setlength\bibitemsep{\baselineskip}  % manually set separation between items in bibliography to double space
    \printbibliography[heading=none]
    \end{singlespace}
}

% --- Bionote Environment ---
\newenvironment{bionote}
{
    \clearpage
    \phantomsection
    \addcontentsline{toc}{chapter}{BIONOTE}
    \begin{centering}
    \textbf{BIONOTE}\\ 
    \vspace{\baselineskip}
    \end{centering}
}
{
    \clearpage
}
