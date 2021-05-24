\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sol-man}[2020/11/28 Class for lengthy solution manuals]

%% Options
% 边数模式 Side mode
\providecommand{\Side}{twoside} % 单边(不分奇偶数页)或双边(区分奇偶数页，默认)模式 Oneside (not distinguishing odd or even pages, default) or twoside (distinguishing odd and even pages) mode
\newif\ifTwoSide % [布尔变量] 是(默认)否为双边模式 [Bool] Whether twoside mode (default) or not
\TwoSidetrue
\DeclareOption{oneside} % 单边模式 Oneside mode
{
    \renewcommand{\Side}{oneside}
    \TwoSidefalse
}
\DeclareOption{twoside} % 双边模式 Twoside mode
{
    \renewcommand{\Side}{twoside}
    \TwoSidetrue
}

% 语言 Language
\newif\ifUsingEnglish % [布尔变量] 是否(默认)使用英语 [Bool] Whether using English or not (default)
\DeclareOption{zh} % 使用中文
{
    \UsingEnglishfalse
    \PassOptionsToPackage{scheme=chinese}{ctex} % 用 ctex 宏包汉化文档结构 Chinesize the structure of the file with ctex package
}
\DeclareOption{en} % Using English
{
    \UsingEnglishtrue
    \PassOptionsToPackage{scheme=plain}{ctex} % 阻止 ctex 宏包过度汉化 Suppress excessive chinesization by ctex package
}
\ProcessOptions\relax

% 其余变量传递给 article 类 Other options passed to article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

%% Load class
\LoadClass[a4paper, \Side, 10pt]{book} % 加载纸张大小为 A4, \Side 模式, 字号为 10 号的 book 类 Load book class with A4 paper, \Side style and 10pt font

%% Call packages
\RequirePackage[UTF8]{ctex} % 中文支持 Chinese support

\RequirePackage[vmargin=1in,hmargin=.5in]{geometry} % 页边距 Page margin

% 自定义页眉和页脚 Header and footer customization
\RequirePackage{fancyhdr} % 页眉和页脚 Header & footer
\RequirePackage{xparse} % 多可选参数的自定义命令 Newcommand with multiple optional arguements
\RequirePackage{lastpage} % 返回末页页码 Return page number of the last page
\RequirePackage{calc} % 返回文本宽度 Return width of text

% 数学公式 Mathematical equations
\RequirePackage{amsmath, amssymb, amsthm, bm, mathtools} % 基础数学支持, 特殊数学符号, 自定义定理, 公式内加粗等 Basic math support, special math symbols, theorem customization, bold in equations, etc.
\RequirePackage{mathrsfs} % 公式内花体字母 Non-CM calligraphic letters in equations
\RequirePackage{esint} % 特殊积分号 Special integral signs

% 图片 Figures
\RequirePackage{graphicx} % 插入图片 Insert graphics
\RequirePackage{float} % 强制设定图片位置 Set the positions of figures mandatorily
\RequirePackage{subfigure} % figure环境中子图 Subfigures in the figure environment
\RequirePackage{tikz} % 绘图 Create graphics
\usetikzlibrary{quantikz} % 绘制量子电路图 Plot quantum circuit diagrams

% 表格 Tables
\RequirePackage{multirow} % 表内多行单元格合并 Tables with merged multi-row cells
\RequirePackage{booktabs} % 三线表 Three-line tables
\RequirePackage{longtable} % 表格跨页 Cross-page tables
\RequirePackage{lscape} % 横排表格 Landscape tables
\RequirePackage{diagbox} % 对角线分割单元格 Cells saperated by diagonal lines

% 化学式 Chemstry formulas
\RequirePackage[version=4]{mhchem} % 基础化学式 Basic chemistry equations
\RequirePackage{chemfig} % 化学结构式 Chemistry structural formulas

\RequirePackage{listings} % 程序代码 Program code

% 其他 Others
\RequirePackage{ulem} % 各式下划线和删除标记 Various underlines & deletion notes
\normalem % 避免将意大利斜体 (\emph或\em) 替换为下划线 Avoide replacing italics (\emph or \em) with underlines
\RequirePackage{color} % 文本颜色 Text color
\RequirePackage{hyperref} % 超链接 Hyperlink
\RequirePackage{framed} % 文本加框 Framed text

% 页眉和页脚 Header & footer
% #1 习题集标题 Exercise book title
% #2 习题集补充信息 Exercise book supplementary information
% #3 解题者姓名 Solver name
% #4 解题者姓名上的超链接 Hyperlink on solver name
% #5 时间 Time
\NewDocumentCommand{\SolManInfos}{ m m m O{https://github.com/Chen-Jialin} m }
{
    \fancypagestyle{FirstPage} % 首页页眉和页脚风格 First-page header and footer style
    {
        \fancyhf{} % 清除预设的页眉和页脚 Clear default header and footer
        \setlength{\headheight}{54pt} % 页眉高 Height of the header
        \fancyhead[L]{{\Huge\bfseries{}Solution\\
            Manual to}\\
            By \href{#4}{#3}, #5} % The left of the header
        \fancyhead[R]{{\Large\bfseries#1}\\
            #2} % The center of the header
        \fancyfoot[R]{\thepage\ / \pageref{LastPage}} % 页脚右：<当前页码> / <总页数> The right of the footer: <current page number> / <total page number>
    }
    \thispagestyle{FirstPage} % 设置首页页眉风格为 FirstPage Set header style of first page to be FirstPage
}
\fancypagestyle{plain}{ % 每章首页页眉和页脚风格 Header and footer style of each chapter's first page
    \fancyhf{} % 清除预设的页眉和页脚 Clear default header and footer
    \renewcommand{\headrulewidth}{0pt} % 去除页眉的装饰线 Remove decorative line in the header
    \ifTwoSide
        \fancyfoot[RO]{\thepage\ / \pageref{LastPage}} % 奇数页脚右: <当前页码> / <总页数> The right of odd page footer: <current page number> / <total page number>
        \fancyfoot[LE]{\thepage\ / \pageref{LastPage}} % 偶数页脚左: <当前页码> / <总页数> The left of even page footer: <current page number> / <total page number>
    \else
        \fancyfoot[R]{\thepage\ / \pageref{LastPage}} % 页脚右: <当前页码> / <总页数> The right of the footer: <current page number> / <total page number>
    \fi
}
\pagestyle{fancy} % 全局页眉和页脚风格 Global header and footer style
\fancyhf{} % 清除预设的页眉和页脚 Clear default header and footer
\setlength{\headheight}{14pt} % 页眉高 Height of the header
\renewcommand{\chaptermark}[1]{\markboth{\thechapter.\ #1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection.\ #1}}
\fancyhead[L]{\leftmark} % 页眉右：<当前章标题> The right of the header <current chapter title>
\fancyhead[R]{\rightmark} % 页眉左：<当前节标题> The left of the header: <current section title>
\ifTwoSide
    \fancyfoot[RO]{\thepage\ / \pageref{LastPage}} % 奇数页脚右: <当前页码> / <总页数> The right of odd page footer: <current page number> / <total page number>
    \fancyfoot[LE]{\thepage\ / \pageref{LastPage}} % 偶数页脚左: <当前页码> / <总页数> The left of even page footer: <current page number> / <total page number>
\else
    \fancyfoot[R]{\thepage\ / \pageref{LastPage}} % 页脚右: <当前页码> / <总页数> The right of the footer: <current page number> / <total page number>
\fi

\allowdisplaybreaks[4] % 公式跨页 Cross-page equations
\providecommand{\abs}[1]{\left\lvert#1\right\rvert} % 绝对值 Absolute value
\providecommand{\norm}[1]{\left\lVert#1\right\rVert} % 范数 Norm
\providecommand{\arcsinh}{\,\mathrm{arcsinh}\,} % 反双曲正弦 Inverse hyperbolic sine
\providecommand{\arccosh}{\,\mathrm{arccosh}\,} % 反双曲余弦 Inverse hyperbolic cosine
\providecommand{\arctanh}{\,\mathrm{arctanh}\,} % 反双曲正切 Inverse hyperbolic tangent
\providecommand{\re}{\,\mathrm{Re}\,} % 复数的实部 Real part of complex number
\providecommand{\im}{\,\mathrm{Im}\,} % 复数的虚部 Imaginary part of complex number
\providecommand{\sgn}{\,\mathrm{sgn}\,} % 符号函数 Sign function
\providecommand{\sinc}{\,\mathrm{sinc}\,} % 辛格函数 Sinc function
\providecommand{\rect}{\,\mathrm{rect}\,} % 矩形函数 Rectangular function
\providecommand{\tr}{\,\mathrm{tr}\,} % 矩阵的迹 Trace of matrix

% 题目和题解风格 Problem and solution style
\newtheoremstyle{Problem} % Theorem style name
{} % Space above theorem, being left empty means default
{} % Space below theorem, being left empty means default
{} % Theorem body font
{} % Theorem indent amount
{\bfseries} % Theorem head font
{.} % Punctuation after theorem head
{ } % Space after theorem head, whitespace means normal interword space
{\thmname{#1}\thmnumber{ #2}\thmnote{ (#3)}} % Theorem head spec, being left empty means default
\theoremstyle{Problem} % Set theorem style
\ifUsingEnglish
    \newtheorem{prob}{Problem}[chapter] % Problem
    \newtheorem{exe}{Exercise}[chapter] % Exercise
    \newtheorem{cor}{Corollary}[chapter] % Corollary
    \providecommand{\Solution}{Solution} % "Solution" in solution environment (sol)
    \providecommand{\Proof}{Proof} % "Proof" in proof environment (pf)
\else
    \newtheorem{prob}{问题}[chapter] % 问题
    \newtheorem{exe}{习题}[chapter] % 习题
    \newtheorem{cor}{引理}[chapter] % 引理
    \providecommand{\Solution}{解} % 题解环境 (sol) 中的“解”
    \providecommand{\Proof}{证} % 证明环境 (pf) 中的“证”
\fi
\newtheoremstyle{Solution} % 定理风格名称 Theorem style name
{} % 定理上方空间尺寸, 留空为默认 Space above theorem, being left empty means default
{} % 定理下方空间尺寸, 留空为默认 Space below theorem, being left empty means default
{} % 定理主体文本字体 Theorem body font
{} % 定理缩进量 Theorem indent amount
{\bfseries} % 定理开头字体 Theorem head font
{:} % 定理开头后所接标点 Punctuation after theorem head
{ } % 定理开头后所接空间尺寸, 空格为默认词间距 % Space after theorem head, whitespace means normal interword space
{\thmname{#1}} % 定理开头格式 Theorem head spec, being left empty means default
\makeatletter
\def\@endtheorem{\qed\endtrivlist\@endpefalse} % 题解后添加 qed 符号 (黑色空心小正方形) % Add qed symbols (black hollow small square) to the end of solutions
\makeatother
\theoremstyle{Solution} % 设定定理风格 Set theorem style
\newtheorem*{sol}{\Solution} % 题解 Solution
\newtheorem*{pf}{\Proof} % 证明 Proof

\providecommand{\muline}[1]{\text{\uline{$#1$}}} % 公式内下划线 Underlines in equations
\providecommand{\muuline}[1]{\text{\uuline{$#1$}}} % 公式内双下划线 Double underlines in equations
\providecommand{\muwave}[1]{\text{\wave{$#1$}}} % 公式内波浪下划线 Wavy underlines in equations
\providecommand{\msout}[1]{\text{\sout{$#1$}}} % 公式内删除线 Strickout in equations
\providecommand{\mxout}[1]{\text{\xout{$#1$}}} % 公式内删除标记 (多条斜线) Deletion notes (multiple slashes) in equations
\providecommand{\mdashuline}[1]{\text{\dashuline{$#1$}}} % 公式内虚下划线 Dashed underlines in equations
\providecommand{\mdotuline}[1]{\text{\dotuline{$#1$}}} % 公式内点状虚下划线 Dotted underlines in equations

% 插入代码风格 Inserted code style
\lstset
{
    numbers=left, % 在左侧添加行号 Add line numbers at left
    frame=single, % 用单线框围绕代码 Enclose code with single-line frames
    breaklines=true, % 自动折行 Automatic line wrapping
    showspaces=true, % 显示空格 Show spaces
    showtabs=true, % 显示制表符 Show tabs
    tab=\rightarrowfill % 用右箭头填充制表符 Fill tabs with right arrows
}

% 超链接自动换行 Hyperlink automatic line wrapping
\makeatletter
\def\UrlAlphabet{%
      \do\a\do\b\do\c\do\d\do\e\do\f\do\g\do\h\do\i\do\j%
      \do\k\do\l\do\m\do\n\do\o\do\p\do\q\do\r\do\s\do\t%
      \do\u\do\v\do\w\do\x\do\y\do\z\do\A\do\B\do\C\do\D%
      \do\E\do\F\do\G\do\H\do\I\do\J\do\K\do\L\do\M\do\N%
      \do\O\do\P\do\Q\do\R\do\S\do\T\do\U\do\V\do\W\do\X%
      \do\Y\do\Z}
\def\UrlDigits{\do\1\do\2\do\3\do\4\do\5\do\6\do\7\do\8\do\9\do\0}
\g@addto@macro{\UrlBreaks}{\UrlOrds}
\g@addto@macro{\UrlBreaks}{\UrlAlphabet}
\g@addto@macro{\UrlBreaks}{\UrlDigits}
\makeatother