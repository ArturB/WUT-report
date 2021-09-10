%%--------------------------------------%%
%%  Simple and elegant academic report  %%
%%  Artur M. Brodzki, 2019-2021         %%
%%--------------------------------------%%

\ProvidesClass{src/wut-report}

\LoadClass[
    12pt
]{mwart}

%----------------------------
% Document class parameters
%----------------------------
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
    family=wut/wut-report.cls,
    prefix=wut
}
\DeclareStringOption[3mm]{footnoteindent}
\DeclareBoolOption[true]{showauthor}
\DeclareBoolOption[true]{showdate}
\DeclareBoolOption[true]{showsubject}
\DeclareBoolOption[true]{hyphenation}
\ProcessKeyvalOptions*
% Hyphenation
\ifwuthyphenation
\else
    \tolerance=1
    \emergencystretch=\maxdimen
    \hyphenpenalty=10000
    \hbadness=10000
\fi

%---------------------
% Basic dependencies
%---------------------
\RequirePackage{amsmath}       % Basic mathematical typesetting
\RequirePackage{amssymb}       % Advanced math symbols
\RequirePackage{amsthm}        % Theorems typesetting
\RequirePackage{chngcntr}      % Per-section counters
\RequirePackage{enumitem}      % Itemize/enumerate
\RequirePackage{fancyhdr}      % Custom header/footer styles
\RequirePackage{fourier}       % Adobe Utopia font
\RequirePackage{graphicx}      % Enhanced images support
\RequirePackage{ifluatex}      % LuaTeX-specific options
\RequirePackage{lipsum}        % Lorem ipsum
\RequirePackage{listings}      % Code listings
\RequirePackage{multirow}      % Advanced table cells
\RequirePackage{setspace}      % Set space between lines
\RequirePackage{tablefootnote} % Table footnotes
\RequirePackage{url}           % URL-sensitive line breaks

%---------------------------
% Parametrized dependencies
%---------------------------
% Bibliography in biber
\RequirePackage[
    backend=biber,
    style=ieee
]{biblatex}
% Custom figure and table captions
\RequirePackage[
    font=small,
    labelfont=bf,
    labelsep=period
]{caption}
% Custom footnote typesetting
\RequirePackage[
    hang
]{footmisc}
\setlength{\footnotemargin}{\wutfootnoteindent}
% Header and footer
\RequirePackage[
	myheadings
]{fullpage}
% A4 paper and margins
\RequirePackage[
    a4paper,
    left=25mm,
    right=25mm,
    top=25mm,
    bottom=25mm
]{geometry}
% Clickable hyperlinks
\RequirePackage{hyperref}
\hypersetup{
    colorlinks,
    citecolor=black,
    filecolor=black,
    linkcolor=black,
    urlcolor=black
}
% Advanced interword spacing
\RequirePackage[
	protrusion=true,
	expansion=true
]{microtype}

%-----------------------
% LuaTeX specific deps
%-----------------------
\ifluatex
    \RequirePackage[T1]{fontenc}
    \RequirePackage[utf8]{luainputenc}
\fi

%-----------------------
% Basic configuration
%-----------------------
\setstretch{1.15}
\setlength{\parindent}{5mm}
\setcounter{tocdepth}{5}
\setcounter{secnumdepth}{5}
% List style
\setlist[itemize,1]{topsep=2pt,label=\large$\bullet$, leftmargin=28pt}
\setlist[itemize,2]{topsep=2pt,leftmargin=18pt}
\setlist[itemize,3]{topsep=2pt,leftmargin=18pt}
\setlist[enumerate,1]{topsep=2pt,leftmargin=24pt}
\setlist[enumerate,2]{topsep=2pt,leftmargin=16pt}
\setlist[enumerate,3]{topsep=2pt,leftmargin=16pt}
% Section header style
\SetSectionFormatting{section}{0.5cm}{\FormatHangHeading{\Large}}{0.5cm}
\renewcommand{\sectionmark}[1]{
	\markboth{#1}{#1}
}

%---------------
% Wybór języka
%---------------
\newcommand{\langpol}{
    \newcommand{\@lang}{pl}
    \usepackage[polish]{babel}
    \usepackage{csquotes}

    \newtheorem{assumption}{Założenie}
    \newtheorem{axiom}{Aksjomat}
    \newtheorem{corollary}{Wniosek}
    \newtheorem{definition}{Definicja}
	\newtheorem{theorem}{Twierdzenie}
	\AtBeginDocument{
		\renewcommand{\tablename}{Tabela}
	}
}
\newcommand{\langeng}{
    \newcommand{\@lang}{en}
    \usepackage[english]{babel}
    \usepackage{csquotes}

    \newtheorem{assumption}{Assumption}
    \newtheorem{axiom}{Axiom}
    \newtheorem{corollary}{Corollary}
    \newtheorem{definition}{Definition}
	\newtheorem{theorem}{Theorem}
	\AtBeginDocument{
		\renewcommand{\tablename}{Table}
	}
}

%----------------------------
% Zawartość raportu - makra
%----------------------------

% Autor
\renewcommand{\author}[1]{
	\renewcommand{\@author}{#1}
    \newcommand{\theauthor}{#1}
}

% Przedmiot
\newcommand{\subject}[1] {
	\newcommand{\@subject}{#1}
    \newcommand{\thesubject}{#1}
}

% Nagłówki nagłówek
\newcommand{\leftheader}[1] {
	\newcommand{\@leftheader}{#1}
}
\newcommand{\rightheader}[1] {
	\newcommand{\@rightheader}{#1}
}

%------------------
% Header & footer
%------------------
\fancypagestyle{plain}{
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
	\fancyfoot[C]{\thepage}
}
\fancypagestyle{headings}{
	\fancyhead{}
	\renewcommand{\headrulewidth}{1pt}
	\fancyheadoffset{0cm}
	\fancyhead[R]{\@rightheader}
	\fancyhead[L]{\@leftheader}
	\fancyfoot[C]{\thepage}
}
\pagestyle{headings}

%------------------
% Tytuł raportu
%------------------
\renewcommand{\maketitle}{
    \thispagestyle{plain}
    \begin{center}
        \ifwutshowauthor
            \large \@author \\ \vspace{5mm}
        \fi
        \ifwutshowsubject
            \Large \@subject \\ \vspace{2mm}
        \fi

        \vspace{-4mm} \rule{\linewidth}{1pt} \\
        \vspace{1mm} \LARGE \textbf{\MakeUppercase{\@title}} \\
        \vspace{-3mm} \rule{\linewidth}{1pt}

        \vspace{5mm}
        \ifwutshowdate
            \normalsize \@date \\
        \fi
        \pagenumbering{arabic}
    \end{center}
}
