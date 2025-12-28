(setq custom-file "~/.emacs.custom.el")

(setq ring-bell-function 'ignore)

(setq split-height-threshold nil)
(setq split-width-threshold 0)

;; remove bloated toolbars and enable line count:
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'visual)
(setq inhibit-startup-screen t)

;; * Encryption
(require 'epa-file)
(epa-file-enable)

;; * setup packages 
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; * setup use-package *

(require 'use-package)
(setq use-package-always-ensure t)

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
  (modus-themes-load-theme 'ef-cherie))

;;(load-theme 'gruber-darker t)
;;(load-theme 'cherry-blossom t)

(use-package evil
  :demand t
  :bind ("C-c e" . evil-local-mode)
  :init
  (setq evil-want-keybinding nil)
  (setq evil-default-state 'emacs)
  :config 
  (evil-mode 1))

(use-package org
  :config
  (setq org-startup-with-latex-preview nil)
  (setq org-preview-latex-default-process 'dvisvgm)
  (plist-put org-format-latex-options :scale 0.6)
  (plist-put org-format-latex-options :html-scale 1.0)
  (add-hook 'org-mode-hook #'electric-pair-local-mode)
  ;;(add-hook 'org-mode-hook 'org-cdlatex-mode)
  )

(use-package evil-org
  :after (evil org)
  :hook (org-mode . evil-org-mode)
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package auctex
  :defer t)

(use-package cdlatex
  :hook (org-mode . turn-on-org-cdlatex)
  :bind (:map org-cdlatex-mode-map
	      ("$" . cdlatex-dollar))
  :config
  (setq cdlatex-math-symbol-alist
        '((?. ("\\cdot" "\\dots"))
          (?* ("\\times" "\\otimes"))
          (?< ("\\leq" "\\prec"))
          (?> ("\\geq" "\\succ"))
          (?= ("\\equiv" "\\cong"))
          (?~ ("\\sim" "\\approx"))
          (?- ("\\to" "\\mapsto"))
          (?| ("\\mid" "\\parallel"))))
  
  ;; Add custom environments/commands
  (setq cdlatex-env-alist
        '(("matrix" "\\begin{matrix}\n?\n\\end{matrix}" nil)
          ("cases" "\\begin{cases}\n?\n\\end{cases}" nil)))
  
  (setq cdlatex-command-alist
        '(("vec" "Insert vector" "\\vec{?}" cdlatex-position-cursor nil t nil)
          ("norm" "Insert norm" "\\|?\\|" cdlatex-position-cursor nil t nil))))

(use-package org-fragtog
  :hook (org-mode . org-fragtog-mode))

(use-package yasnippet
  :hook (org-mode . yas-minor-mode)
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-reload-all))
