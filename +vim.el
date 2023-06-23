;;; +vim.el -*- lexical-binding: t; -*-

(map! :map evil-outer-text-objects-map
  "b" #'evil-a-paren
  "B" #'evil-a-bracket
  "c" #'evil-a-curly
  "C" #'evilnc-outer-comment)

(map! :map evil-inner-text-objects-map
  "b" #'evil-inner-paren
  "B" #'evil-inner-bracket
  "c" #'evil-inner-curly
  "C" #'evilnc-inner-comment)

(map! :m
  "0" #'doom/backward-to-bol-or-indent)

(map! :n
  ;; "-" #'evil-previous-line-first-non-blank) ;; original binding
  "-" #'evil-end-of-line)

(after! evil-snipe
  (setq evil-snipe-scope 'whole-buffer))

(evil-snipe-def 1 'inclusive "t" "T")
(evil-snipe-def 1 'exclusive "f" "F")
