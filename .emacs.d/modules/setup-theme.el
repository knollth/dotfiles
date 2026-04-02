;; -*- lexical-binding: t; -*-
;;; setup-theme.el — pick a theme, everything else follows

(use-package modus-themes :ensure t)

(use-package ef-themes
  :after modus-themes
  :custom
  (ef-themes-variable-pitch-ui t)
  (ef-themes-mixed-fonts t)
  :init
  (modus-themes-include-derivatives-mode 1)
  :config
  (require 'setup-modeline))

(use-package darkman
  :after ef-themes
  :config
  (setq darkman-themes '(:light ef-frost :dark ef-owl))
  (darkman-mode 1))


(defun my/pick-theme-color ()
  "Browse current theme palette in vertico with color swatches."
  (interactive)
  (let* ((palette (modus-themes-get-theme-palette nil t t))
         (resolve (lambda (val)
                    "Chase aliases until we hit a hex string or nil."
                    (let ((seen nil))
                      (while (and val (symbolp val) (not (memq val seen)))
                        (push val seen)
                        (setq val (cadr (assq val palette))))
                      (and (stringp val) (string-prefix-p "#" val) val))))
         (candidates
          (mapcar (lambda (entry)
                    (let* ((name (symbol-name (car entry)))
                           (val (cadr entry))
                           (hex (if (and (stringp val) (string-prefix-p "#" val))
                                    val
                                  (funcall resolve val)))
                           (swatch (if hex
                                       (propertize "████" 'face `(:foreground ,hex))
                                     "    ")))
                      (cons (format "%s %-30s %s" swatch name
                                    (if hex hex (or val "")))
                            (or hex (format "%s" (or val ""))))))
                  palette))
         (choice (completing-read "Palette: " candidates nil t)))
    (kill-new (cdr (assoc choice candidates)))
    (message "Copied: %s" (cdr (assoc choice candidates)))))


(provide 'setup-theme)
