\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mancls}

%code选项：标明文档是否为源代码文档；noheaders选项：不展示页眉
\DeclareOption{code}{\newcommand{\codedoc}{}}
\DeclareOption{noheaders}{\newcommand{\noheaders}{}}
\ProcessOptions\relax

\LoadClass{ctexart}
\RequirePackage{xcolor}
\RequirePackage{ragged2e}
\RequirePackage{fancyhdr}
\RequirePackage{listings}
\RequirePackage{geometry}
\RequirePackage{fontspec}
\RequirePackage{soul}
\RequirePackage{tikz}
\RequirePackage{geometry}

\newfontfamily\Consolas{Consolas}
\lstset{basicstyle=\Consolas}

%提供绘制逻辑流程图的tikz样式
\usetikzlibrary{shapes.geometric, arrows,positioning,calc}
\tikzstyle{startstop} = [rectangle, rounded corners, minimum width=3cm, minimum height=1cm,text centered, draw=black, fill=red!30]
\tikzstyle{io} = [trapezium, trapezium left angle=70, trapezium right angle=110, minimum width=3cm, minimum height=1cm, text centered, draw=black, fill=blue!30]
\tikzstyle{process} = [rectangle, minimum width=3cm, minimum height=1cm, text centered, draw=black, fill=orange!30]
\tikzstyle{decision} = [diamond, minimum width=3cm, minimum height=1cm, text centered, draw=black, fill=cyan!30,text width=1.5 cm]
\tikzstyle{arrow} = [thick,->,>=stealth]

%提供一个无页边距的整页图片页，用\afterpage{}包括此环境可获得最佳效果
\newenvironment{wholepagefigure}{
    \newpage
    \newgeometry{bottom=0mm,top=0mm,right=0mm,left=0mm}
    \begin{figure}[h]
        \centering
}{
    \end{figure}
    \restoregeometry
    \newpage
}

%提供行内代码环境\code与右斜杠别名\bs
\definecolor{codecolor}{gray}{0.85}
\newcommand{\codehl}[1]{
    \begingroup
    \sethlcolor{codecolor}%
    \hl{\texttt{#1}}%
    \endgroup
}
\providecommand{\code}[1]{
    \begingroup
    \colorbox{codecolor}{\texttt{#1}}
    \endgroup
}
\newcommand{\bs}{\textbackslash}

%重定义标题页
\newcommand{\suffix}{\ifdefined \codedoc 软件源程序 \else 使用说明书 \fi}
\renewcommand{\maketitle}{
    \pagebreak
    \hspace{0pt}
    \vfill
\begin{center}
    {\Centering \songti \zihao{1} \textbf{\@title}}
\end{center}
\begin{center}
    {\songti \fontsize{48}{72} \selectfont \textbf{\suffix}}
\end{center}
    \vfill
    \hspace{0pt}
    \thispagestyle{empty}
    \pagebreak
}
%提供新的目录命令\contents命令
\newcommand{\contents}{
    \tableofcontents
    \thispagestyle{empty}
    \pagebreak
}
%为文档开头添加标题页，如果是手册文档，添加目录页
\AtBeginDocument{
    \maketitle
    \ifdefined \codedoc \else \contents \fi
    \setcounter{page}{1}
}

\ifdefined \noheaders
%清除页眉页脚
\pagestyle{empty}
\else
%定义页眉页脚样式
\pagestyle{fancy}
\fancyhf{}
\chead{\@title}
\rhead{第\thepage 页}
\fi
%提供有行号和无行号的两个listings样式
\lstdefinelanguage{Praat}{
    morekeywords={for,endfor,form,endform,repeat,until,if,else,endif},
    sensitive=true,
    morestring=[b]",
    morestring=[b]'
}
\lstdefinestyle{codestyle}{
    commentstyle=\color{white},
    emptylines=0,
    numbers=none,
    breaklines=true,
    showstringspaces=false
}
\lstdefinestyle{codestyleln}{
    commentstyle=\color{white},
    emptylines=0,
    numbers=left,
    breaklines=true,
    showstringspaces=false
}
\lstdefinestyle{examplecode}{
    basicstyle=\Consolas,
    emptylines=0,
    breaklines=true
}
%为源码文件调整每页行数，效果大约是每页55行，取消缩进
\ifdefined \codedoc
\geometry{
    textheight=42\baselineskip,
    paper=a4paper
}
\setlength{\parindent}{0em}
\renewcommand{\baselinestretch}{0.995}
\fi

