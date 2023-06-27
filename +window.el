;;; +window.el -*- lexical-binding: t; -*-

(setq doom-window-resize-rate-coarse 5)
(setq doom-window-resize-rate-fine 1)

;; https://codingstruggles.com/emacs/resizing-windows-doom-emacs.html#:~:text=Sometimes%20guessing%20the%20correct%20size,be%20repeated%20for%20each%20step.&text=Now%20we%20can%20just%20press,to%20resize%20the%20current%20window.; sync' after modifying this file!
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
