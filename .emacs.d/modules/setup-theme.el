;; -*- lexical-binding: t; -*-
;;; setup-theme.el — pick a theme, everything else follows

(use-package ef-themes
  :ensure t
  :custom
  (ef-themes-variable-pitch-ui t)
  :init
  (ef-themes-take-over-modus-themes-mode)
  (setq ef-themes-variable-pitch-ui t
      ef-themes-mixed-fonts t)
  :bind
  (("<f9>"   . modus-themes-rotate)
   ("C-<f9>" . modus-themes-select)
   ("M-<f9>" . modus-themes-load-random))
  :config
  (setq modus-themes-mixed-fonts t
        modus-themes-italic-constructs t)
  (modus-themes-load-theme 'ef-frost)
  (require 'setup-modeline))

(defun my/ef-theme-colors ()
  "Browse current ef-theme palette via vertico."
  (interactive)
  (let* ((palette (ef-themes--current-theme-palette))
         (candidates (mapcar (lambda (entry)
                               (format "%-30s %s" (car entry) (cadr entry)))
                             palette)))
    (kill-new
     (car (split-string (completing-read "Color: " candidates nil t))))))

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
