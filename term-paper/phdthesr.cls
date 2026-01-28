\def\RCSfile{ceurart}%
\def\RCSversion{phdthesr}%
\def\RCSdate{2026-01-28}%
\RequirePackage{expl3}
\ProvidesExplClass
{\RCSfile} % Package name
{\RCSdate} % Release date
{\RCSversion} % Release version
{Russian thesis} % Description
\RequirePackage{xparse}
\RequirePackage{l3keys2e}
\@ifundefined{regex_match:nnTF}{\RequirePackage{l3regex}}{}

\ExplSyntaxOn

% Основные пакеты для русского языка
% \RequirePackage{fontspec}
% \RequirePackage{polyglossia}
% \setmainlanguage{russian}
% \setotherlanguage{english}
% \defaultfontfeatures{Ligatures=TeX}

% Для библиографии
% \RequirePackage[backend=biber,
%   style=gost-numeric,
%   sorting=none,
%   language=auto,
% autolang=other]{biblatex}

%%% Ключи для настройки класса

%%%% Переменные для хранения опций, которые будут переданы в базовый класс
\tl_new:N \l__phdthesr_class_options_tl
\tl_set:Nn \l__phdthesr_class_options_tl {paper=a4, bibliography=totoc, index=totoc, listof=totoc}

%%%% Булевы переменные для типов работ
\bool_new:N \g__phdthesr_bachelor_bool
\bool_new:N \g__phdthesr_master_bool
\bool_new:N \g__phdthesr_phd_bool
\bool_new:N \g__phdthesr_doctor_bool

%%%% Переменные для данных работы
\tl_new:N \g__phdthesr_type_tl
\tl_new:N \g__phdthesr_type_name_tl
\tl_new:N \g__phdthesr_degree_tl
\tl_new:N \g__phdthesr_qualification_tl
\tl_new:N \g__phdthesr_fontsize_tl
\tl_new:N \g__phdthesr_line_spacing_tl
\str_new:N \g__phdthesr_font_choice_str

%%%% Поля страницы (будут настроены в зависимости от размера шрифта)
\dim_new:N \g__phdthesr_top_margin_dim
\dim_new:N \g__phdthesr_bottom_margin_dim
\dim_new:N \g__phdthesr_left_margin_dim
\dim_new:N \g__phdthesr_right_margin_dim

%%%% Использование \DeclareOption для прямой обработки

\DeclareOption{10pt}{\tl_gset:Nn \g__phdthesr_fontsize_tl {10pt} \tl_put_right:Nn \l__phdthesr_class_options_tl {,fontsize=10pt}}
\DeclareOption{11pt}{\tl_gset:Nn \g__phdthesr_fontsize_tl {11pt} \tl_put_right:Nn \l__phdthesr_class_options_tl {,fontsize=11pt}}
\DeclareOption{12pt}{\tl_gset:Nn \g__phdthesr_fontsize_tl {12pt} \tl_put_right:Nn \l__phdthesr_class_options_tl {,fontsize=12pt}}
\DeclareOption{13pt}{\tl_gset:Nn \g__phdthesr_fontsize_tl {13pt} \tl_put_right:Nn \l__phdthesr_class_options_tl {,fontsize=13pt}}
\DeclareOption{14pt}{\tl_gset:Nn \g__phdthesr_fontsize_tl {14pt} \tl_put_right:Nn \l__phdthesr_class_options_tl {,fontsize=14pt}}

%%%% Разбор ключей
\keys_define:nn { phdthesr  / options }
{
  %%% Размер шрифта
  fontsize .choice:,
  fontsize / 12pt .code:n = {
    \tl_gset:Nn \g__phdthesr_fontsize_tl {12pt}
    \tl_put_right:Nn \l__phdthesr_class_options_tl {,fontsize=12pt}
    %% Настройка полей для 12pt
    \dim_gset:Nn \g__phdthesr_top_margin_dim {20mm}
    \dim_gset:Nn \g__phdthesr_bottom_margin_dim {20mm}
    \dim_gset:Nn \g__phdthesr_left_margin_dim {30mm}
    \dim_gset:Nn \g__phdthesr_right_margin_dim {10mm}
  },
  fontsize / 13pt .code:n = {
    \tl_gset:Nn \g__phdthesr_fontsize_tl {13pt}
    \tl_put_right:Nn \l__phdthesr_class_options_tl {,fontsize=13pt}
    %% Настройка полей для 13pt
    \dim_gset:Nn \g__phdthesr_top_margin_dim {20mm}
    \dim_gset:Nn \g__phdthesr_bottom_margin_dim {20mm}
    \dim_gset:Nn \g__phdthesr_left_margin_dim {25mm}
    \dim_gset:Nn \g__phdthesr_right_margin_dim {10mm}
  },
  fontsize / 14pt .code:n = {
    \tl_gset:Nn \g__phdthesr_fontsize_tl {14pt}
    \tl_put_right:Nn \l__phdthesr_class_options_tl {,fontsize=14pt}
    %% Настройка полей для 14pt
    \dim_gset:Nn \g__phdthesr_top_margin_dim {20mm}
    \dim_gset:Nn \g__phdthesr_bottom_margin_dim {20mm}
    \dim_gset:Nn \g__phdthesr_left_margin_dim {30mm}
    \dim_gset:Nn \g__phdthesr_right_margin_dim {10mm}
  },
  fontsize .initial:n = { 12pt },

  %%% Межстрочный интервал
  linespacing .choice:,
  linespacing / single .code:n = {
    \tl_gset:Nn \g__phdthesr_line_spacing_tl {single}
  },
  linespacing / onehalf .code:n = {
    \tl_gset:Nn \g__phdthesr_line_spacing_tl {onehalf}
  },
  linespacing / double .code:n = {
    \tl_gset:Nn \g__phdthesr_line_spacing_tl {double}
  },
  linespacing .initial:n = { onehalf },

  %%% Гарнитура шрифта
  font .choice:,
  font / times .code:n = {
    \str_gset:Nn \g__phdthesr_font_choice_str { times }
  },
  font / pt .code:n = {
    \str_gset:Nn \g__phdthesr_font_choice_str { pt }
  },
  font / plex .code:n = {
    \str_gset:Nn \g__phdthesr_font_choice_str { plex }
  },
  font .initial:n = plex,

  %%% Тип работы
  type .choice:,
  type / bachelor .code:n = {
    \bool_gset_true:N \g__phdthesr_bachelor_bool
    \tl_gset:Nn \g__phdthesr_type_tl { bachelor }
    \tl_gset:Nn \g__phdthesr_type_name_tl { ВЫПУСКНАЯ~КВАЛИФИКАЦИОННАЯ~РАБОТА }
    \tl_gset:Nn \g__phdthesr_degree_tl { бакалавр }
    \tl_gset:Nn \g__phdthesr_qualification_tl { бакалавра }
  },
  type / master .code:n = {
    \bool_gset_true:N \g__phdthesr_master_bool
    \tl_gset:Nn \g__phdthesr_type_tl { master }
    \tl_gset:Nn \g__phdthesr_type_name_tl { МАГИСТЕРСКАЯ~ДИССЕРТАЦИЯ }
    \tl_gset:Nn \g__phdthesr_degree_tl { магистр }
    \tl_gset:Nn \g__phdthesr_qualification_tl { магистра }
  },
  type / candidate .code:n = {
    \bool_gset_true:N \g__phdthesr_phd_bool
    \tl_gset:Nn \g__phdthesr_type_tl { candidate }
    \tl_gset:Nn \g__phdthesr_type_name_tl { ДИССЕРТАЦИЯ }
    \tl_gset:Nn \g__phdthesr_degree_tl { кандидат~наук }
    \tl_gset:Nn \g__phdthesr_qualification_tl { кандидата~наук }
  },
  type / doctor .code:n = {
    \bool_gset_true:N \g__phdthesr_doctor_bool
    \tl_gset:Nn \g__phdthesr_type_tl { doctor }
    \tl_gset:Nn \g__phdthesr_type_name_tl { ДИССЕРТАЦИЯ }
    \tl_gset:Nn \g__phdthesr_degree_tl { доктор~наук }
    \tl_gset:Nn \g__phdthesr_qualification_tl { доктора~наук }
  },
  type .default:n = { bachelor },

  % Специальность (для диссертаций)
  specialty .tl_set:N = \g__phdthesr_specialty_tl,

  % Шифр специальности
  specialty-code .tl_set:N = \g__phdthesr_specialty_code_tl,

  % Ученая степень
  degree .tl_set:N = \g__phdthesr_degree_tl,

  % Направление подготовки (для ВКР/магистратуры)
  field .tl_set:N = \g__phdthesr_field_tl,

  % Код направления
  field-code .tl_set:N = \g__phdthesr_field_code_tl,

  % Образовательная программа
  program .tl_set:N = \g__phdthesr_program_tl,

  % Профиль/специализация
  profile .tl_set:N = \g__phdthesr_profile_tl,

  % Кафедра
  department .tl_set:N = \g__phdthesr_department_tl,

  % Факультет
  faculty .tl_set:N = \g__phdthesr_faculty_tl,

  % Форма обучения
  form .choice:,
  form / fulltime .code:n = { \tl_gset:Nn \g__phdthesr_form_tl { очная } },
  form / parttime .code:n = { \tl_gset:Nn \g__phdthesr_form_tl { заочная } },
  form / evening .code:n = { \tl_gset:Nn \g__phdthesr_form_tl { очно-заочная } },
  form .default:n = { fulltime },
}

%%%% Процессинг опций
%% Обрабатываем все опции
\ProcessOptions\relax

%% Обрабатываем через l3keys для ключевых опций
\ProcessKeysOptions{ phdthesr  / options }

%%%% Загрузка базового класса с обработанными опциями
\LoadClass[ \l__phdthesr_class_options_tl ]{scrbook}

%%% Дополнительные пакеты

\RequirePackage{scrhack}
\PassOptionsToPackage{listings=false}{scrhack}
\AddToHook{begindocument/before}{\@ifpackageloaded{minted}{\removefromtoclist[float]{lol}}{}}

%%%% Для правильных переносов
\RequirePackage{microtype}

%%%% Математические пакеты
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}

%%%% Для таблиц
\RequirePackage{booktabs}
\RequirePackage{tabularx}
\RequirePackage{multirow}

%%%% Для графики
\RequirePackage{graphicx}
\RequirePackage{wrapfig}
\RequirePackage{caption}
\RequirePackage{subcaption}

%%%% Гиперссылки
\RequirePackage[unicode,
  colorlinks=true,
  linkcolor=black,
  citecolor=black,
  urlcolor=blue,
pdfstartview=FitH]{hyperref}

%%%% Для листингов кода
\RequirePackage{listings}
\RequirePackage{xcolor}

%%%% Расширенная математика

\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amscd}

\usepackage{mathtools}
\mathtoolsset{
  showonlyrefs=true,
  mathic=true,
}

\allowdisplaybreaks

%%%% Calligraphic fonts for physicists
\usepackage{mathrsfs}

%%% Теперь применяем настройки на основе опций
\ExplSyntaxOn

%%% Установка межстрочного интервала
% \tl_if_empty:NF \g__phdthesr_line_spacing_tl
% {
%   \tl_case:Nn \g__phdthesr_line_spacing_tl
%   {
%     { single } { \RequirePackage[singlespacing]{setspaceenhanced} }
%     { onehalf } { \RequirePackage[onehalfspacing]{setspaceenhanced} }
%     { double } { \RequirePackage[doublespacing]{setspaceenhanced} }
%   }
%   }
\RequirePackage[onehalfspacing]{setspace}
% \RequirePackage[doublespacing]{setspace}
% \RequirePackage[singlespacing]{setspace}

%%% Установка полей
\KOMAoptions{twoside=false}

\RequirePackage[
  top=\dim_use:N \g__phdthesr_top_margin_dim,
  bottom=\dim_use:N \g__phdthesr_bottom_margin_dim,
  left=\dim_use:N \g__phdthesr_left_margin_dim,
  right=\dim_use:N \g__phdthesr_right_margin_dim,
]{geometry}
\geometry{includefoot}
\geometry{bindingoffset=0mm}
\geometry{marginparwidth=0dd,marginparsep=0dd}
\geometry{heightrounded}

%%% Установка шрифта
% \tl_if_empty:NF \g__phdthesr_font_choice_tl
% % {
% \tl_case:NnF \g__phdthesr_font_choice_tl
% {
\cs_new_protected:Npn \phdthesr_setup_fonts:
{
  \str_case:Vn \g__phdthesr_font_choice_str
  {
    { times }
    {
      \setmainfont{Times~New~Roman}
      \setsansfont{Arial}
      \setmonofont{Courier~New}
    }
    { pt }
    {
      \setmainfont{PT~Serif}
      \setsansfont{PT~Sans}
      \setmonofont{PT~Mono}
    }
    { plex }
    {
      \RequirePackage[math,RM={Scale=0.94},SS={Scale=0.94},SScon={Scale=0.94},TT={Scale=MatchLowercase,FakeStretch=0.9},DefaultFeatures={Ligatures=Common}]{plex-otf}
    }
  }
}

\AtBeginDocument{
  \ExplSyntaxOn
  \phdthesr_setup_fonts:
  \ExplSyntaxOff
}

% Установка абзацного отступа
% \dim_if_exist:NT \g__phdthesr_parindent_dim
% {
%   \setlength{\parindent}{\dim_use:N \g__phdthesr_parindent_dim}
% }

% Команды для установки данных
\NewDocumentCommand{\settitle}{m}{\newcommand{\@title}{#1}}
\NewDocumentCommand{\setauthor}{m}{\newcommand{\@author}{#1}}
\NewDocumentCommand{\setspecialty}{m}{\tl_gset:Nn \g__phdthesr_specialty_tl {#1}}
\NewDocumentCommand{\setspecialtycode}{m}{\tl_gset:Nn \g__phdthesr_specialty_code_tl {#1}}
\NewDocumentCommand{\setfield}{m}{\tl_gset:Nn \g__phdthesr_field_tl {#1}}
\NewDocumentCommand{\setfieldcode}{m}{\tl_gset:Nn \g__phdthesr_field_code_tl {#1}}
\NewDocumentCommand{\setprogram}{m}{\tl_gset:Nn \g__phdthesr_program_tl {#1}}
\NewDocumentCommand{\setprofile}{m}{\tl_gset:Nn \g__phdthesr_profile_tl {#1}}
\NewDocumentCommand{\setsupervisor}{m}{\newcommand{\@supervisor}{#1}}
\NewDocumentCommand{\setdepartment}{m}{\tl_gset:Nn \g__phdthesr_department_tl {#1}}
\NewDocumentCommand{\setfaculty}{m}{\tl_gset:Nn \g__phdthesr_faculty_tl {#1}}
\NewDocumentCommand{\setorganization}{m}{\newcommand{\@organization}{#1}}
\NewDocumentCommand{\setcity}{m}{\newcommand{\@city}{#1}}
\NewDocumentCommand{\setyear}{m}{\newcommand{\@year}{#1}}
\NewDocumentCommand{\setudc}{m}{\newcommand{\@udc}{#1}}
\NewDocumentCommand{\setkeywords}{m}{\newcommand{\@keywords}{#1}}

% Титульная страница для бакалавриата
\NewDocumentCommand{\__make_bachelor_titlepage}{}
{
  \thispagestyle{empty}
  \begin{center}
    \vspace*{-2cm}

    {\large \textbf{МИНИСТЕРСТВО~НАУКИ~И~ВЫСШЕГО~ОБРАЗОВАНИЯ~РОССИЙСКОЙ~ФЕДЕРАЦИИ} \\}
    \vspace{0.3cm}

    {\large \textbf{\@organization} \\}
    \vspace{0.3cm}

    {\large \tl_use:N \g__phdthesr_faculty_tl \\}
    \vspace{0.3cm}

    {\large \tl_use:N \g__phdthesr_department_tl \\}
    \vspace{2cm}

    {\Large \textbf{\g__phdthesr_type_name_tl} \\}
    \vspace{0.5cm}

    {\large (бакалаврская~работа) \\}
    \vspace{1.5cm}

    {\Large \textbf{\@title} \\}
    \vspace{1.5cm}

    \begin{flushright}
      \begin{minipage}{0.6\textwidth}
        \raggedright
        Направление~подготовки:~\tl_use:N \g__phdthesr_field_code_tl \\[0.2cm]
        Образовательная~программа:~\tl_use:N \g__phdthesr_program_tl \\[0.2cm]
        Профиль:~\tl_use:N \g__phdthesr_profile_tl \\[0.2cm]
        Форма~обучения:~\tl_use:N \g__phdthesr_form_tl
      \end{minipage}
    \end{flushright}
    \vspace{1.5cm}

    \begin{flushright}
      \begin{minipage}{0.6\textwidth}
        \raggedright
        Выполнил(а): \\
        студент(ка)~группы~XXXX \\[0.2cm]
        \@author \\[1cm]

        Научный~руководитель: \\
        \@supervisor
      \end{minipage}
    \end{flushright}
    \vfill

    {\large \@city~\@year}
  \end{center}
}

% Титульная страница для магистратуры
\NewDocumentCommand{\__make_master_titlepage}{}
{
  \thispagestyle{empty}
  \begin{center}
    \vspace*{-2cm}

    {\large \textbf{МИНИСТЕРСТВО~НАУКИ~И~ВЫСШЕГО~ОБРАЗОВАНИЯ~РОССИЙСКОЙ~ФЕДЕРАЦИИ} \\}
    \vspace{0.3cm}

    {\large \textbf{\@organization} \\}
    \vspace{0.3cm}

    {\large \tl_use:N \g__phdthesr_faculty_tl \\}
    \vspace{0.3cm}

    {\large \tl_use:N \g__phdthesr_department_tl \\}
    \vspace{2cm}

    {\Large \textbf{\g__phdthesr_type_name_tl} \\}
    \vspace{0.5cm}

    {\large (магистерская~диссертация) \\}
    \vspace{1.5cm}

    {\Large \textbf{\@title} \\}
    \vspace{1.5cm}

    \begin{flushright}
      \begin{minipage}{0.6\textwidth}
        \raggedright
        Направление~подготовки:~\tl_use:N \g__phdthesr_field_code_tl \\[0.2cm]
        Образовательная~программа:~\tl_use:N \g__phdthesr_program_tl \\[0.2cm]
        Магистерская~программа:~\tl_use:N \g__phdthesr_profile_tl \\[0.2cm]
        Форма~обучения:~\tl_use:N \g__phdthesr_form_tl
      \end{minipage}
    \end{flushright}
    \vspace{1.5cm}

    \begin{flushright}
      \begin{minipage}{0.6\textwidth}
        \raggedright
        Выполнил(а): \\
        магистрант~группы~XXXX \\[0.2cm]
        \@author \\[1cm]

        Научный~руководитель: \\
        \@supervisor
      \end{minipage}
    \end{flushright}
    \vfill

    {\large \@city~\@year}
  \end{center}
}

% Титульная страница для кандидатской диссертации
\NewDocumentCommand{\__make_candidate_titlepage}{}
{
  \thispagestyle{empty}
  \begin{center}
    \vspace*{-1.5cm}

    {\large \textbf{\@organization} \\}
    \vspace{0.5cm}

    {\large \tl_use:N \g__phdthesr_department_tl \\}
    \vspace{2cm}

    {\Large \textbf{\@author} \\}
    \vspace{1cm}

    {\LARGE \textbf{\@title} \\}
    \vspace{0.5cm}

    {\large Диссертация~на~соискание~ученой~степени \\}
    \vspace{0.3cm}

    {\large \tl_use:N \g__phdthesr_degree_tl \\}
    \vspace{0.5cm}

    {\large Специальность:~\tl_use:N \g__phdthesr_specialty_code_tl~«\tl_use:N \g__phdthesr_specialty_tl» \\}
    \vspace{2cm}

    \begin{flushright}
      \begin{minipage}{0.6\textwidth}
        Научный~руководитель: \\
        \@supervisor
      \end{minipage}
    \end{flushright}
    \vfill

    {\large \@city~\@year}
  \end{center}
}

% Титульная страница для докторской диссертации
\NewDocumentCommand{\__make_doctor_titlepage}{}
{
  \thispagestyle{empty}
  \begin{center}
    \vspace*{-1.5cm}

    {\large \textbf{\@organization} \\}
    \vspace{0.5cm}

    {\large \tl_use:N \g__phdthesr_department_tl \\}
    \vspace{2cm}

    {\Large \textbf{\@author} \\}
    \vspace{1cm}

    {\LARGE \textbf{\@title} \\}
    \vspace{0.5cm}

    {\large Диссертация~на~соискание~ученой~степени \\}
    \vspace{0.3cm}

    {\large \tl_use:N \g__phdthesr_degree_tl \\}
    \vspace{0.5cm}

    {\large Специальность:~\tl_use:N \g__phdthesr_specialty_code_tl~«\tl_use:N \g__phdthesr_specialty_tl» \\}
    \vspace{2cm}

    \begin{flushright}
      \begin{minipage}{0.6\textwidth}
        Научный~консультант: \\
        \@supervisor
      \end{minipage}
    \end{flushright}
    \vfill

    {\large \@city~\@year}
  \end{center}
}

% Основная команда для создания титульной страницы
% \NewDocumentCommand{\maketitlepage}{}
% {
%   \bool_if:NT \g__phdthesr_bachelor_bool { \__make_bachelor_titlepage }
%   \bool_if:NT \g__phdthesr_master_bool { \__make_master_titlepage }
%   \bool_if:NT \g__phdthesr_phd_bool { \__make_candidate_titlepage }
%   \bool_if:NT \g__phdthesr_doctor_bool { \__make_doctor_titlepage }
%   \clearpage
% }

% Аннотация (разная для разных типов работ)
% \NewDocumentEnvironment{abstract}{}
% {
%   \chapter*{Аннотация}
%   \addcontentsline{toc}{chapter}{Аннотация}

%   \bool_if:NT \g__phdthesr_bachelor_bool
%   {
%     \noindent\textbf{Бакалаврская~работа} \\
%     \noindent\textbf{Тема:} \@title \\
%     \noindent\textbf{Автор:} \@author \\
%     \noindent\textbf{Научный~руководитель:} \@supervisor \\
%     \noindent\textbf{Объем:} \pageref{LastPage}~стр.,~\total{figures}~рис.,~\total{tables}~табл.,~\nocite{*}~\total{citenum}~ист. \\
%     \vspace{0.5cm}
%   }

%   \bool_if:NT \g__phdthesr_master_bool
%   {
%     \noindent\textbf{Магистерская~диссертация} \\
%     \noindent\textbf{Тема:} \@title \\
%     \noindent\textbf{Автор:} \@author \\
%     \noindent\textbf{Научный~руководитель:} \@supervisor \\
%     \noindent\textbf{Объем:} \pageref{LastPage}~стр.,~\total{figures}~рис.,~\total{tables}~табл.,~\nocite{*}~\total{citenum}~ист. \\
%     \vspace{0.5cm}
%   }

%   \bool_if:NTF \g__phdthesr_phd_bool
%   {
%     \noindent\textbf{Кандидатская~диссертация} \\
%   }
%   {
%     \bool_if:NT \g__phdthesr_doctor_bool
%     {
%       \noindent\textbf{Докторская~диссертация} \\
%     }
%   }
% }
% {
%   \vspace{1cm}

%   \bool_if:nT { \g__phdthesr_phd_bool || \g__phdthesr_doctor_bool }
%   {
%     \noindent\textbf{Ключевые~слова:} \@keywords \\
%     \vspace{0.5cm}

%     \noindent\textbf{УДК:} \@udc
%   }
% }

% Автореферат (только для диссертаций)
% \NewDocumentCommand{\makereferat}{m}
% {
%   \bool_if:nF { \g__phdthesr_bachelor_bool || \g__phdthesr_master_bool }
%   {
%     \cleardoublepage
%     \thispagestyle{empty}

%     \begin{center}
%       \vspace*{-2cm}

%       {\large \textbf{АВТОРЕФЕРАТ} \\}
%       \vspace{0.5cm}

%       {\large диссертации~на~соискание~ученой~степени \\}
%       \vspace{0.3cm}

%       {\large \tl_use:N \g__phdthesr_degree_tl \\}
%       \vspace{1cm}

%       {\Large \textbf{\@title} \\}
%       \vspace{1cm}

%       {\large \@author \\}
%       \vspace{2cm}
%     \end{center}

%     \noindent\textbf{Специальность:} \tl_use:N \g__phdthesr_specialty_code_tl~«\tl_use:N \g__phdthesr_specialty_tl» \\

%     \bool_if:NT \g__phdthesr_phd_bool
%     {
%       \noindent\textbf{Научный~руководитель:} \@supervisor
%     }

%     \bool_if:NT \g__phdthesr_doctor_bool
%     {
%       \noindent\textbf{Научный~консультант:} \@supervisor
%     }

%     \vspace{1cm}

%     #1

%     \vfill

%     \begin{center}
%       \@city~\@year
%     \end{center}

%     \cleardoublepage
%   }
% }

% Задание на ВКР (для бакалавриата и магистратуры)
% \NewDocumentCommand{\maketask}{m}
% {
%   \bool_if:nT { \g__phdthesr_bachelor_bool || \g__phdthesr_master_bool }
%   {
%     \cleardoublepage
%     \thispagestyle{empty}

%     \begin{center}
%       \vspace*{-2cm}

%       {\large \textbf{ЗАДАНИЕ} \\}
%       \vspace{0.3cm}

%       {\large на~выполнение~\tl_if_eq:NnTF \g__phdthesr_type_tl { bachelor } { бакалаврской~работы } { магистерской~диссертации } \\}
%       \vspace{1cm}

%       {\Large \textbf{\@title} \\}
%       \vspace{2cm}
%     \end{center}

%     \noindent\textbf{Студент(ка):} \@author \\
%     \noindent\textbf{Группа:} XXXXX \\
%     \noindent\textbf{Направление~подготовки:} \tl_use:N \g__phdthesr_field_code_tl~«\tl_use:N \g__phdthesr_field_tl» \\
%     \noindent\textbf{Профиль/программа:} \tl_use:N \g__phdthesr_profile_tl \\
%     \noindent\textbf{Кафедра:} \tl_use:N \g__phdthesr_department_tl \\
%     \noindent\textbf{Срок~сдачи:} \underline{\hspace{3cm}} \\
%     \noindent\textbf{Дата~выдачи~задания:} \underline{\hspace{3cm}} \\
%     \vspace{0.5cm}

%     \noindent\textbf{Исходные~данные~к~работе:} \\
%     #1
%     \vspace{1cm}

%     \noindent\textbf{Содержание~пояснительной~записки:} \\
%     (перечень~подлежащих~разработке~вопросов) \\
%     \vspace{1cm}

%     \noindent\textbf{Перечень~графического~материала:} \\
%     (с~точным~указанием~обязательных~чертежей) \\
%     \vspace{1cm}

%     \noindent\textbf{Консультанты~по~разделам:} \\
%     \begin{tabular}{@{}p{0.4\textwidth}p{0.4\textwidth}@{}}
%       \textbf{Раздел} & \textbf{Консультант} \\
%       \midrule
%       & \\
%       & \\
%       & \\
%     \end{tabular}
%     \vspace{1cm}

%     \noindent\textbf{Календарный~план:} \\
%     \begin{tabular}{@{}p{0.1\textwidth}p{0.6\textwidth}p{0.2\textwidth}@{}}
%       № & Наименование~этапов & Срок~выполнения \\
%       \midrule
%       1 & & \\
%       2 & & \\
%       3 & & \\
%       4 & & \\
%     \end{tabular}
%     \vspace{1cm}

%     \begin{tabular}{@{}p{0.45\textwidth}p{0.45\textwidth}@{}}
%       \textbf{Студент} & \textbf{Руководитель} \\
%       \underline{\hspace{5cm}} & \underline{\hspace{5cm}} \\
%       \small{\@author} & \small{\@supervisor} \\
%     \end{tabular}

%     \cleardoublepage
%   }
% }

% Рецензия (для всех типов работ)
% \NewDocumentCommand{\makereview}{m m}
% {
%   \cleardoublepage
%   \thispagestyle{empty}

%   \begin{center}
%     \vspace*{-2cm}

%     {\large \textbf{РЕЦЕНЗИЯ} \\}
%     \vspace{0.5cm}

%     {\large на~\tl_if_eq:NnTF \g__phdthesr_type_tl { bachelor }
%       { бакалаврскую~работу }
%       { \tl_if_eq:NnTF \g__phdthesr_type_tl { master }
%         { магистерскую~диссертацию }
%         { диссертацию }
%       }
%     } \\
%     \vspace{0.3cm}

%     {\large \@title \\}
%     \vspace{0.3cm}

%     {\large выполненную~\tl_if_eq:NnTF \g__phdthesr_type_tl { bachelor }
%       { студентом }
%       { \tl_if_eq:NnTF \g__phdthesr_type_tl { master }
%         { магистрантом }
%         { соискателем }
%       }
%     } \\
%     \vspace{0.3cm}

%     {\large \@author \\}
%     \vspace{1cm}
%   \end{center}

%   \noindent\textbf{Рецензент:} #1 \\
%   \noindent\textbf{Место~работы,~должность:} #2 \\
%   \vspace{1cm}

%   \noindent\textbf{Содержание~рецензии:} \\
%   (оценка~актуальности,~новизны,~практической~значимости,~замечания,~рекомендации) \\
%   \vspace{1cm}

%   \noindent\textbf{Вывод:} \\
%   (рекомендовать/не~рекомендовать~к~защите) \\
%   \vspace{1cm}

%   \begin{tabular}{@{}p{0.45\textwidth}p{0.45\textwidth}@{}}
%     \textbf{Подпись} & \textbf{Дата} \\
%     \underline{\hspace{5cm}} & \underline{\hspace{5cm}} \\
%   \end{tabular}

%   \cleardoublepage
% }

% Остальные команды остаются без изменений
% \NewDocumentCommand{\tableofcontents}{}
% {
%   \chapter*{\contentsname}
%   \@starttoc{toc}
% }

% \NewDocumentCommand{\listoffigures}{}
% {
%   \chapter*{\listfigurename}
%   \@starttoc{lof}
% }

% \NewDocumentCommand{\listoftables}{}
% {
%   \chapter*{\listtablename}
%   \@starttoc{lot}
% }

% \NewDocumentEnvironment{introduction}{}
% {
%   \chapter*{Введение}
%   \addcontentsline{toc}{chapter}{Введение}
% }
% {}

% \NewDocumentEnvironment{conclusion}{}
% {
%   \chapter*{Заключение}
%   \addcontentsline{toc}{chapter}{Заключение}
% }
% {}

% \NewDocumentCommand{\printbibliography}{}
% {
%   \chapter*{\bibname}
%   \addcontentsline{toc}{chapter}{\bibname}
%   \printbibheading
%   \printbibliography[heading=none]
% }

% \NewDocumentCommand{\appendix}{}
% {
%   \par
%   \setcounter{chapter}{0}
%   \setcounter{section}{0}
%   \gdef\@chapapp{\appendixname}
%   \gdef\thechapter{\Asbuk{chapter}}
% }

\ExplSyntaxOff

%%% Русские названия
% \addto\captionsrussian{
%   \renewcommand{\contentsname}{Содержание}
%   \renewcommand{\listfigurename}{Список~иллюстраций}
%   \renewcommand{\listtablename}{Список~таблиц}
%   \renewcommand{\bibname}{Список~литературы}
%   \renewcommand{\indexname}{Предметный~указатель}
%   \renewcommand{\figurename}{Рис.}
%   \renewcommand{\tablename}{Таблица}
%   \renewcommand{\appendixname}{Приложение}
%   \renewcommand{\partname}{Часть}
%   \renewcommand{\chaptername}{Глава}
% }

% Настройка стилей заголовков
\renewcommand{\chapterformat}{\thechapter~}
\renewcommand{\sectionformat}{\thesection~}
\renewcommand{\subsectionformat}{\thesubsection~}
\renewcommand{\sectfont}{\bfseries\boldmath}

%%% Колонтитулы
% \clearpairofpagestyles
% \chead{}
% \ohead{\pagemark}
% \ihead{}

%%% Captions

\RequirePackage{caption}

\captionsetup{font={small}}
% \captionsetup{
%  textfont={bf},
% labelfont={bf}}

% \DeclareCaptionFormat{tableRight}{\hfill#1\newline#2#3\par}
\DeclareCaptionFormat{gost1.5}{\hfill#1\newline#2#3\par}

\captionsetup[figure]{
  % labelsep=period,
  labelsep=space,
position=bottom,justification=centering}

% \captionsetup[table]{format=tableRight,labelsep=none,position=top}
\captionsetup[table]{format=gost1.5,labelsep=none,position=top,justification=centering}

%\AtBeginDocument{%
% \RequirePackage{floatrow}
%\makeatletter
%\@ifpackageloaded{floatrow}{%
%    \floatsetup[table]{style=Plaintop}
%    }{}
%\makeatother
%}

%%% Russian

\RequirePackage{indentfirst}

%%% Lists

\RequirePackage{enumitem}
\setlist{nosep}
\setlist{noitemsep}
% \setlist[enumerate]{labelsep=*, leftmargin=*}
% \setlist[itemize]{leftmargin=*,topsep=0pt}
\setlist[itemize]{topsep=0pt}
\setlist[itemize,1]{label=---~}
\setlist[itemize,2]{label=---~}
\setlist[itemize,3]{label=---~}

%%% Footnotes numbered per page

\RequirePackage{perpage}
\MakePerPage{footnote}

%%% Chapter

\KOMAoptions{headings=standardclasses,headings=big,chapterprefix=false}
\renewcommand*\raggedchapter{\centering}
\renewcommand*\raggedsection{\centering}
\RedeclareSectionCommand[beforeskip=0pt,afterskip=1\baselineskip]{chapter}
% \setkomafont{chapterprefix}{\normalsize\mdseries}

% \addtokomafont{chapterentrypagenumber}{\normalfont\chapterFontShape}

%%% TOC

% \RequirePackage{tocloft}
\RequirePackage[titletoc]{appendix}
\setcounter{tocdepth}{2}
\KOMAoptions{toc=chapterentrydotfill}

%%% Header, footer

\usepackage{scrlayer-scrpage}
\clearpairofpagestyles
\cfoot*{\pagemark}

%%% Abstract

\ExplSyntaxOn

% Хранилище для текста абстракта
\tl_new:N \g_abstract_text_tl
\bool_new:N \g_abstract_defined_bool
\bool_set_false:N \g_abstract_defined_bool

% Окружение abstract
\NewDocumentEnvironment{abstract}{+b}
{
  % Сохраняем текст абстракта
  \tl_gset:Nn \g_abstract_text_tl {#1}
  \bool_set_true:N \g_abstract_defined_bool
}
{}

% Команда для вывода абстракта
\NewDocumentCommand{\printabstract}{}
{
  \bool_if:NTF \g_abstract_defined_bool
  {
    \begin{center}
      \large\textbf{Аннотация}
    \end{center}
    \g_abstract_text_tl
    \par\medskip
  }
  {
    \msg_warning:nn {abstract} {undefined}
  }
}

% Расширенная версия с параметрами
\NewDocumentCommand{\printabstractx}{O{Аннотация} m}
{
  \bool_if:NTF \g_abstract_defined_bool
  {
    \begin{center}
      \large\textbf{#1}
    \end{center}
    \keys_set:nn {abstract} {#2}
    \abstract_format_text:
    \par\medskip
  }
  {
    \msg_warning:nn {abstract} {undefined}
  }
}

% Ключи для оформления
\keys_define:nn {abstract}
{
  fontsize .tl_set:N = \l_abstract_fontsize_tl,
  fontsize .initial:n = \normalsize,
  indent .bool_set:N = \l_abstract_indent_bool,
  indent .initial:n = true,
  parskip .dim_set:N = \l_abstract_parskip_dim,
  parskip .initial:n = 0.5em,
}

% Форматирование текста
\cs_new_protected:Nn \abstract_format_text:
{
  \l_abstract_fontsize_tl
  \bool_if:NT \l_abstract_indent_bool
  {
    \parindent = 1.5em
  }
  \dim_if_empty:NF \l_abstract_parskip_dim
  {
    \setlength{\parskip}{\l_abstract_parskip_dim}
  }
  \g_abstract_text_tl
}

% Команда для получения текста абстракта (если нужно использовать в другом месте)
\NewDocumentCommand{\getabstract}{}
{
  \tl_use:N \g_abstract_text_tl
}

% Проверка, определен ли абстракт
\NewDocumentCommand{\ifabstractdefined}{}
{
  \bool_if:NTF \g_abstract_defined_bool
  {true}
  {false}
}

% Сообщения об ошибках
\msg_new:nnn {abstract} {undefined}
{
  Абстракт~не~определен.~Используйте~окружение~abstract.
}

\NewDocumentCommand \makeabstract { } {
  % \tex_def:D \baselinestretch{1}
  \thispagestyle{empty}
  \setcounter{page}{2}
  \null\vfil
  \begin{center}
    {\bfseries \MakeUppercase{\PHDministry} \par}
    \smallskip
    {\bfseries \MakeUppercase{\PHDinstitute} \par}
  \end{center}

  \bigskip
  \bigskip
  \bigskip

  \begin{center}
    {\large\textbf{Аннотация}}\par
    \textbf{выпускной~квалификационной~работы}\par

    % Автор
    \ifx\@empty\PHDauthorgen
    \else%
    \bigskip
    \PHDauthorgen
    \bigskip
    \fi
  \end{center}

  \noindent на~тему:~
  \PHDtitle
  \par
  \bigskip

  \getabstract
  % \g_abstract_text_tl

  % \begin{Abstract}
  %   % \noindent
  %   % \ignorespaces
  %   \file_if_exist:nT { \jobname.abs } { \file_input:n { \jobname.abs } }
  % \end{Abstract}

  \vfill

  \noindent Автор~ВКР
  \hfill \rule{5cm}{0.4pt} \hfill \PHDauthor
}

\ExplSyntaxOff

\endinput
