;; -*- lexical-binding: t; -*-

(TeX-add-style-hook
 "cite"
 (lambda ()
   (LaTeX-add-bibitems
    "gnu-doc_bash"
    "newham_2005_bash"
    "robachevsky_unix"
    "robbins_2013_bash"
    "tannenbaum_modern-os_ru"
    "zarrelli_2017_bash"
    "tannenbaum_arch-pc_ru"))
 '(or :bibtex :latex))

