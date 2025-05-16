% !TeX root = thesis.tex
% !TeX program = xelatex  % Or lualatex
\NeedsTeXFormat{LaTeX2e}
% \ProvidesClass{gatechthesis}[2025/04/22 GA Tech MS/Ungraduate Thesis - Modified]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass[12pt]{report} %%% MODIFIED: Set base font size to 12pt

% --- Package Imports ---
\RequirePackage{graphicx}
\RequirePackage[letterpaper, left=1.5in, right=1in, top=1in, bottom=1in]{geometry} % Standard margins
% \RequirePackage[letterpaper, left=0in, right=0in, top=0in, bottom=0in]{geometry} % User's original "zero margin" setting
\RequirePackage{multicol}
\RequirePackage{setspace}
% \RequirePackage{times} % Removed: Redundant with fontspec/xelatex
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
\captionsetup[table]{skip=0pt}
\RequirePackage{subcaption}
\RequirePackage[acronym,nogroupskip,nopostdot]{glossaries}
\RequirePackage{doi}
\RequirePackage{fancyhdr}
\RequirePackage{etoolbox} % For \patchcmd, \pretocmd etc. if needed later

% --- Font Setup (from thesis.tex preamble) ---
% It's generally better to have font setup within the class if it's a core part of the thesis style
% However, keeping it in thesis.tex allows user flexibility. If you move \setmainfont here,
% ensure font files are accessible relative to the .cls or use system fonts.
% For now, assuming \setmainfont{Candara} remains in thesis.tex.

% --- Thesis Title Font Size Definition ---
\newcommand{\thesistitlefontsize}{\fontsize{14pt}{16.8pt}\selectfont}
\newcommand{\sectiontitlefontsize}{\fontsize{13pt}{15.6pt}\selectfont} %%% ADDED: For 13pt section titles

\newcommand{\rothead}[1]{\rotatebox{90}{\textbf{#1}}} % Adjust angle as needed

% --- SI Units Setup ---
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
  \fancyhead[R]{\thepage}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

% --- Spacing and Paragraph Setup ---
\doublespacing % This will apply to the 12pt base font
\setlength{\parindent}{3.011em} % Set to 2em for a "tab"; adjust as needed

% --- Document-wide Settings ---
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

% --- Default Chapter Title Formatting & Spacing ---
% These are defaults; they can be overridden by environments like frontmatter or thesisbody.
\titleformat{\chapter}[display]
{\thesistitlefontsize\bfseries\filcenter} % Apply 14pt font size
{\chaptertitlename\ \thechapter}
{0pt}
{\MakeUppercase}
\titlespacing*{\chapter}
{0pt}{-\topskip}{35pt} % Adjusted: Pull up by \topskip to remove default top spacing

%%% MODIFIED: Section, Subsection, Subsubsection title formats
\titleformat{\section}{\sectiontitlefontsize\bfseries}{\thesection}{1em}{##1} % Use 13pt
\titleformat{\subsection}{\normalfont\bfseries}{\thesubsection}{1em}{##1}     % Use 12pt (from \normalsize)
\titleformat{\subsubsection}{\normalfont\bfseries}{\thesubsubsection}{1em}{##1} % Use 12pt (from \normalsize)

% Ensure subsubsections are numbered in the document and TOC
\setcounter{secnumdepth}{3}  % Show numbers up to subsubsection level
\setcounter{tocdepth}{3}     % Include subsubsections in TOC

\makeatletter

% --- Bookmark Formatting ---
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

% --- Autoref Names ---
\newcommand{\ALC@uniqueautorefname}{Line}
\newcommand{\algorithmautorefname}{Algorithm}

% --- Rotatepage Environment ---
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

% --- Thesis Information Tokens ---
\newcommand{\approvaldate}[1]{\gdef\@approvaldate{#1}}%
\newcommand{\@approvaldate}{\@latex@warning@no@line{No \noexpand\approvaldate given}}
\newcommand{\school}[1]{\gdef\@school{#1}}%
\newcommand{\@school}{\@latex@warning@no@line{No \noexpand\school given}}
\newcommand{\department}[1]{\gdef\@department{#1}}%
\newcommand{\@department}{\@latex@warning@no@line{No \noexpand\department given}}
\makeatother

% --- Frontmatter Environment ---
% Handles title formatting for ToC, LoF, LoT (which use \chapter*)
\newenvironment{frontmatter}{%
  \clearpage
  \pagestyle{plain}
  \titleformat{\chapter}[display]
  {\vspace*{-16.8pt}\normalfont\thesistitlefontsize\bfseries\filcenter} % Adjusted
  {} % No chapter number/name for \chapter*
  {0pt}
  {\MakeUppercase{##1}}
  \titlespacing*{\chapter}
  {0pt}{0pt}{35pt} % before-sep is 0pt
}%
{%
}

% --- Thesisbody Environment ---
% Handles text and other formatting for main content and appendices
\newenvironment{thesisbody}{%
  \clearpage
  \pagestyle{fancy}
  \pagenumbering{arabic} % resumes page numbering after front matter
  \setcounter{page}{1} % set the page number appropriately

  % --- Modified Chapter Formatting for thesisbody ---
  \titleformat{\chapter}[block] % Shape can remain [block] if that's the desired style for numbered chapters
  {\vspace*{-28pt}\thesistitlefontsize\bfseries\filcenter} % Added \vspace*{-16.8pt}
  {\MakeUppercase{CHAPTER \thechapter.}} % Label for numbered chapters
  {0.5em} % Separation between label (CHAPTER X.) and title text
  {\MakeUppercase{##1}}[\thispagestyle{empty}] % Formatting for the title text AND set page style to empty
  \titlespacing*{\chapter}
  {0pt}{0pt}{35pt} % before-sep changed from -\topskip to 0pt. after-sep remains 35pt.
  % --- End of Modified Chapter Formatting ---

  %%% MODIFIED: Section, Subsection, Subsubsection title formats within thesisbody
  \titleformat{\section}{\sectiontitlefontsize\bfseries}{\thesection}{1em}{##1} % Use 13pt
  \titleformat{\subsection}{\normalfont\bfseries}{\thesubsection}{1em}{##1}     % Use 12pt (from \normalsize)
  \titleformat{\subsubsection}{\normalfont\bfseries}{\thesubsubsection}{1em}{##1} % Use 12pt (from \normalsize)
}%
{
  \clearpage
}

% --- Title Page Command ---
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
      \@title\\
      \vspace{6\baselineskip}

      A Thesis by\\
      \vspace{6\baselineskip}

      \@author\\
      \vspace{7\baselineskip}

      Submitted to the Department of Bachelor of Science in Computer Science\\
      College of Computing and Information Sciences (CCIS)\\
      Caraga State University – Main Campus\\
      \vspace{6\baselineskip}

      In Partial Fulfillment\\
      of the Requirements for the Degree\\
      Bachelor of Science in Computer Science (BSCS)\\

      \vfill
      \vspace{2cm}

      #1 #2 \\
      \vspace{0.25cm}

    \end{singlespacing}
  \end{center}
}
\makeatother

% --- Approval Page Environment ---
\newenvironment{approvalPage}
{
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{APPROVAL SHEET}
  \begin{centering}
    \thesistitlefontsize\textbf{APPROVAL SHEET}\\ % Apply 14pt font size
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
    \thesistitlefontsize\textbf{DEDICATION}\\ % Apply 14pt font size
    \vspace{\baselineskip}
  \end{centering}
}
{
  \clearpage
}

% --- Acknowledgment Environment ---
\newenvironment{acknowledgment}
{
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{ACKNOWLEDGMENT}
  \begin{centering}
    \thesistitlefontsize\textbf{ACKNOWLEDGMENT}\\ % Apply 14pt font size
    \vspace{\baselineskip}
  \end{centering}
}
{
  \clearpage
}

% --- Abstract Environment ---
\renewenvironment{abstract}
{
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{ABSTRACT}
  \begin{centering}
    \thesistitlefontsize\textbf{ABSTRACT}\\ % Apply 14pt font size
    \vspace{\baselineskip}
  \end{centering}
}{
  % \clearpage % Original abstract did not have \clearpage at the end
}

% --- Table of Contents Title ---
\renewcommand{\contentsname}{TABLE OF CONTENTS}

% --- Table of Contents Formatting and Command Creation ---
\renewcommand{\cftchapdotsep}{\cftdotsep}
\renewcommand{\cftchapfont}{\bfseries}
\renewcommand{\cftchappagefont}{}
\renewcommand{\cftchappresnum}{CHAPTER }
\renewcommand{\cftchapaftersnum}{:}
\renewcommand{\cftchapnumwidth}{6em}
\renewcommand{\cftchapafterpnum}{\vskip\baselineskip}
\renewcommand{\cftsecafterpnum}{\vskip\baselineskip}
\renewcommand{\cftsubsecafterpnum}{\vskip\baselineskip}
\renewcommand{\cftsubsubsecafterpnum}{\vskip\baselineskip}

% Removed commented-out \tableofcontents, \listoffigures, \listoftables redefinitions
% and \patchcmd. Title formatting/spacing should be handled by \titleformat and \titlespacing
% for \chapter (affecting \chapter*) within the frontmatter environment.

\newcommand{\makeTOC}{
  \currentpdfbookmark{Table of Contents}{TOC}
  % \renewcommand\contentsname{Table of Contents} % Title set by \chapter* mechanism
  \begin{singlespace}
    \setcounter{tocdepth}{3}
    \tableofcontents % This will use \chapter*{TABLE OF CONTENTS}
  \end{singlespace}
  \clearpage
}

% --- List of Tables Command ---
\newcommand{\makeListOfTables}{
  \phantomsection
  % \addcontentsline{toc}{chapter}{LIST OF TABLES} % Done by \listoftables with tocloft
  \begin{singlespace}
    \setlength\cftbeforetabskip{\baselineskip}
    \listoftables % This will use \chapter*{LIST OF TABLES}
  \end{singlespace}
  \clearpage
}

% --- List of Figures Command ---
\newcommand{\makeListOfFigures}{
  \phantomsection
  % \addcontentsline{toc}{chapter}{LIST OF FIGURES} % Done by \listoffigures with tocloft
  \begin{singlespace}
    \setlength\cftbeforefigskip{\baselineskip}
    \listoffigures % This will use \chapter*{LIST OF FIGURES}
  \end{singlespace}
  \clearpage
}

% --- List of Acronyms Command ---
\newcommand{\makeListOfAcronyms}{
  \phantomsection
  % \addcontentsline{toc}{chapter}{LIST OF ACRONYMS} % Done by \printglossary with tocloft
  \printglossary[type=\acronymtype,title=LIST OF ACRONYMS] % Title should pick up frontmatter \chapter* style
  \clearpage % Added clearpage for consistency, if needed. Remove if List of Acronyms page break is handled differently.
}

% --- Appendix Environment Definition ---
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
    \thesistitlefontsize\bfseries \MakeUppercase{\appendixpagename}\par}% Apply 14pt font size
    \if@dotoc@pp
    \fi
  }
  \bookmarksetupnext{level=part}
  \begin{appendices} % From appendix package
    % These \addtocontents customize how appendix sections appear in ToC
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

% --- Bibliography Formatting and Command Creation ---
% Prevent certain fields in references from printing
\AtEveryBibitem{\clearfield{issn}}
\AtEveryBibitem{\clearlist{issn}}
\AtEveryBibitem{\clearfield{language}}
\AtEveryBibitem{\clearlist{language}}
\AtEveryBibitem{\clearfield{url}}
\AtEveryBibitem{\clearlist{url}}
\AtEveryBibitem{%
  \ifentrytype{online}{}{%
    \clearfield{urlyear}\clearfield{urlmonth}\clearfield{urlday}%
  }%
}

\newcommand{\makeBibliography}{
  \clearpage
  \bookmarksetupnext{level=part}
  \phantomsection
  \addcontentsline{toc}{chapter}{REFERENCES} % This adds "REFERENCES" to ToC
  \begin{centering}
    \thesistitlefontsize\textbf{REFERENCES}\\ % Apply 14pt font size
    % No \vspace here, \printbibliography will handle spacing before first item.
    % If extra space is needed before bib items, adjust \bibitemsep or add \vspace before \printbibliography
  \end{centering}
  \begin{singlespace}
    \setlength\bibitemsep{\baselineskip} % Separation between bibliography items
    \printbibliography[heading=none] % heading=none because we provided our own centered title
  \end{singlespace}
}

% --- Bionote Environment ---
\newenvironment{bionote}
{
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{BIONOTE}
  \begin{centering}
    \thesistitlefontsize\textbf{BIONOTE}\\ % Apply 14pt font size
    \vspace{\baselineskip}
  \end{centering}
}
{
  \clearpage
}

\endinput