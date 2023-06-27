;;; +proof-mode.el -*- lexical-binding: t; -*-

;; If inside executed region, jump to next unexecuted statement
;; then execute. If outside executed region, execute up to point
(defun proof-assert-dwim ()
  (interactive)
  (if (< (proof-queue-or-locked-end) (point))
      (if (eq ?. (char-after))
          ;; We're outside the executed region and on top of a dot
          (proof-assert-until-point)
        ;; Jump to end of current statement, then execute.
        ;; TODO: use regex to ignore periods in comments
        (evil-snipe-t 1 ".")
        (proof-assert-until-point))
    ;; We're inside the executed region. Jump to end,
    ;; then find next statement to execute
    (goto-char (proof-queue-or-locked-end))
    (evil-snipe-t 1 ".")
    (proof-assert-until-point)))

(map! :map coq-mode-map
      ;; :localleader "`" nil
      :localleader
      "RET" 'proof-assert-dwim)
