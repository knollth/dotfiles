;; ** themes **
(use-package cherry-blossom-theme)
(use-package ef-themes
  :ensure t
  :init
  (ef-themes-take-over-modus-themes-mode 1)
  :bind
  (("<f9>" . modus-themes-rotate)
   ("C-<f9>" . modus-themes-select)
   ("M-<f9>" . modus-themes-load-random))
  :config
  ;; All customisations here.
  (setq modus-themes-mixed-fonts t)
  (setq modus-themes-italic-constructs t)
  (modus-themes-load-theme 'ef-dream))

;;(use-package solarized-theme)
;;(load-theme 'solarized-dark-high-contrast t)

(provide 'setup-theme)
