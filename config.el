;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom

(setq doom-window-resize-rate-coarse 10)
(setq doom-window-resize-rate-fine 1)

;; Try to improve LSP performance
;; https://emacs-lsp.github.io/lsp-mode/page/performance/#adjust-gc-cons-threshold
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb

;; broken
;; How to do this o_o
;; (defun lambda-fy (fn)
;;   (lambda () (interactive) ((fn doom-window-resize-rate-hydra))))

;https://codingstruggles.com/emacs/resizing-windows-doom-emacs.html#:~:text=Sometimes%20guessing%20the%20correct%20size,be%20repeated%20for%20each%20step.&text=Now%20we%20can%20just%20press,to%20resize%20the%20current%20window.; sync' after modifying this file!
(defhydra doom-window-resize-hydra (:hint nil)
;; "
;;              _k_ increase height
;; _h_ decrease width    _l_ increase width ... SHIFT to fine tune
;;              _j_ decrease height
;; "
  ("h" (lambda () (interactive) (evil-window-decrease-width doom-window-resize-rate-coarse)))
  ("j" (lambda () (interactive) (evil-window-decrease-height doom-window-resize-rate-coarse)))
  ("k" (lambda () (interactive) (evil-window-increase-height doom-window-resize-rate-coarse)))
  ("l" (lambda () (interactive) (evil-window-increase-width doom-window-resize-rate-coarse)))

  ("H" (lambda () (interactive) (evil-window-decrease-width doom-window-resize-rate-fine)))
  ("J" (lambda () (interactive) (evil-window-decrease-height doom-window-resize-rate-fine)))
  ("K" (lambda () (interactive) (evil-window-increase-height doom-window-resize-rate-fine)))
  ("L" (lambda () (interactive) (evil-window-increase-width doom-window-resize-rate-fine)))

  ("q" nil))

(map!
    (:prefix "SPC w"
     :desc "Hydra resize" :n "SPC" #'doom-window-resize-hydra/body))

(map! :leader
  "g P" #'magit-push
  "g p" #'magit-pull
  "g d" #'magit-diff
  "g SPC" #'magit-status
  "g e" #'flymake-goto-next-error
  "g E" #'flymake-goto-prev-error
  "g k" #'+vc-gutter/previous-hunk
  "g j" #'+vc-gutter/next-hunk)

(map! :n
  "g ." #'magit-status)

(defun move-line-up ()
  "Move up the current line."
  ;; (interactive)
  ;; (transpose-lines 1)
  ;; (forward-line -2)
  ;; (indent-according-to-mode))
  (forward-line -1))

(defun move-line-down ()
  "Move down the current line."
  ;; (interactive)
  ;; (transpose-lines 1)
  ;; (forward-line -1)
  ;; (indent-according-to-mode))
  (forward-line 1))

;; (global-set-key [(control q control qq)]  'move-line-up)
;; (global-set-key [(control j)]  'move-line-down)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name ""
      user-mail-address "")

(beacon-mode 1)
(map! :leader "l" #'beacon-blink)
;; (map! :i "SPC" #'beacon-blink)
;; (global-unset-key (kbd "SPC"))
;; (map! :g "SPC" #'beacon-blink)
;; (map! "SPC" 'self-insert-command) ;; This was the fix
;; (map! :i "SPC" #'beacon-blink)
;; (map! :i "SPC" nil)

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-spacegrey)
(setq doom-spacegrey-brighter-comments nil
      doom-spacegrey-brighter-modeline t)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Notes/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; https://emacs.stackexchange.com/questions/58463/project-el-override-project-root-with-dir-local-var
(defun cargo-project-override (dir)
  (let ((override (locate-dominating-file dir "Cargo.toml")))
    (if override
      (list 'vc 'Git override)
      nil)))

(defun toggle-eldoc-minibuffer ()
  "Toggle eldoc minibuffer"
  (interactive)
  (if eldoc-echo-area-use-multiline-p
      (setq eldoc-echo-area-use-multiline-p nil)
    (setq eldoc-echo-area-use-multiline-p 't)))
(use-package eldoc
  :config
  ;; (setq lsp-signature-auto-activate nil)
  ;; (setq eldoc-echo-area-use-multiline-p nil))
  )

(defun ediff-copy-both-to-C ()
  (interactive)
  (ediff-copy-diff ediff-current-difference nil 'C nil
                   (concat
                    (ediff-get-region-contents ediff-current-difference 'A ediff-control-buffer)
                    (ediff-get-region-contents ediff-current-difference 'B ediff-control-buffer))))
(defun add-d-to-ediff-mode-map () (define-key ediff-mode-map "d" 'ediff-copy-both-to-C))
(add-hook 'ediff-keymap-setup-hook 'add-d-to-ediff-mode-map)

;; https://lists.gnu.org/r/bug-gnu-emacs/2021-04/msg01344.html
(use-package tramp
  :config
  ;; (add-to-list 'tramp-remote-path 'tramp-own-remote-path)

  ;; This fixes some hanging problems for some reason
  (add-to-list 'tramp-connection-properties
             (list (regexp-quote "/ssh:guse4a-ossdev-jll1:")
                   "remote-shell" "/bin/bash"))
  (customize-set-variable 'tramp-encoding-shell "/bin/zsh")
  (customize-set-variable 'tramp-use-ssh-controlmaster-options nil))

(use-package project
  :config
  (add-hook 'project-find-functions #'cargo-project-override))

(use-package vterm
  :commands vterm
  :config
  (setq vterm-timer-delay 0.005))

(use-package org
  :commands org
  :config
  (setq truncate-lines t))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)
   (jupyter . t)))

(defun splash-banner ()
  (let* ((banner '("૮ ・ﻌ・ა"
                   ))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'splash-banner)

(after! doom-modeline
  ;; Set custom modal icon here
  ;; (setq modal-icon-active "⭑૮​​​​･​​​ﻌ​​･​​​ა​​​⭑")
  (setq modal-icon-active   "૮​​​​･​​​​​ﻌ​​​​･​​​​​ა​​​⋆")
  (setq modal-icon-inactive "૮​​​–​​​​ﻌ​​​​–​​​აᷦᷦᷦ")

  ;; Enable Unicode fallback
  (setq doom-modeline-unicode-fallback t)

  ;; Override definition in doom-modeline-segments.el:1746
  (defun doom-modeline--modal-icon (text face help-echo)
  "Display the model icon with FACE and HELP-ECHO.
   TEXT is alternative if icon is not available."
    (propertize (doom-modeline-icon
                 'material
                 (when doom-modeline-modal-icon "") ;; Trigger fallback by providing empty string
                 (if (doom-modeline--active)
                     (pcase text
                       ;; (" <N> " "⋆૮​​​​･​​​​​ﻌ​​​​･​​​​​ა​​​⋆")
                       (" <N> " "૮​​​​･​​​​​ﻌ​​​​･​​​​​ა​​​⭑")
                       (" <I> " "૮​​​​･​​​​​ﻌ​​​​･​​​​​ა​​​✎")
                       ((or " <V> " " <Vl> " " <Vb> ") "૮​​​​･​​​​​ﻌ​​​​･​​​​​ა​​​⚑")
                       (" <R> " "૮​​​​･​​​​​ﻌ​​​​･​​​​​ა​​​⚠")
                       (" <O> " "૮​​​​･​​​​​ﻌ​​​​･​​​​​ა​​​﹖"))
                   modal-icon-inactive)
                 text ;; Ascii fallback
                 :face (doom-modeline-face face)
                 ;; :v-adjust -0.225)
                 :v-adjust -1)
                 'help-echo help-echo)))

(after! doom-themes
  (setq doom-theme 'doom-spacegrey))

;; (custom-theme-set-faces 'doom-spacegrey
;; '(mode-line ((t . ((:foreground "blue")
;;                    (:background "black")))))))

;; (after! lsp-rust
;;   (setq lsp-rust-server 'rust-analyzer)
;;   (setq lsp-rust-analyzer-store-path "/Users/jolin/.cargo/bin/rust-analyzer")
;;   (lsp-register-client
;;     ;; (make-lsp-client :new-connection (lsp-tramp-connection "rust-analyzer")
;;     (make-lsp-client :new-connection (lsp-tramp-connection "~/.cargo/bin/rust-analyzer")
;;                      :major-modes '(rustic-mode)
;;                      :remote? t
;;                      :server-id 'rust-analyzer-remote)))

(after! eglot
  :config
  (set-eglot-client! 'rustic-mode '("rust-analyzer"))

  ;; hack to get rust-analyzer in exec-path, dunno how to actually get exec-path to mirror PATH
  (setq exec-path (append exec-path '("/Users/jolin/.cargo/bin")))
  (setq exec-path (append exec-path '("/home/jolin/.cargo/bin"))))

(after! evil-snipe
  (setq evil-snipe-scope 'whole-buffer))

(evil-snipe-def 1 'inclusive "t" "T")
(evil-snipe-def 1 'exclusive "f" "F")

;; (module-load "/Users/jolin/.emacs.d/.local/straight/repos/emacs-zmq/emacs-zmq.dylib")

(defun slack-code-to-emoji (s)
  "Convert slack emoji representation to an actual unicode character"
  (setq result (char-from-name
        (upcase
                (replace-regexp-in-string "_" " " (substring s 1 -1)))))
  (if result (string result) s))

;; help from https://wilkesley.org/~ian/xah/emacs/elisp_command_working_on_string_or_region.html
;; reason for save-match-data: https://stackoverflow.com/questions/4894522/in-emacs-lisp-how-do-i-correctly-use-replace-regexp-in-string
(defun replace-slack-code-with-emoji-in-region ()
  "Doc string..."
  (interactive)
  (let (start end inputStr outputStr)
          (setq start (doom-region-beginning)
                end   (doom-region-end))
          (setq inputStr (buffer-substring-no-properties start end))
          (setq outputStr
                  (replace-regexp-in-string
                   ":[a-z_]+:"
                   (lambda (s) (save-match-data (slack-code-to-emoji s)))
                   inputStr))
          (save-excursion
                  (delete-region start end)
                  (goto-char start)
                  (insert outputStr))))

(setq exec-path (append exec-path '("/Users/jolin/.cargo/bin")))
