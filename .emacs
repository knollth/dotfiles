(setq custom-file "~/.emacs.custom.el")
(setq ring-bell-function 'ignore)

;; remove bloated toolbars and enable line count:
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'visual)
(setq inhibit-startup-screen t)

;; setup packages 
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)


;; setup use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)  ; update package list
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package evil
  :commands (evil-mode evil-local-mode)
  :bind ("C-c e" . evil-mode)
  :init
  (setq evil-want-keybinding nil) ; Recommended if you ever use evil-collection
  :config
  (evil-mode 1))

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
;; load theme

;;(load-theme 'gruber-darker t)
;;(load-theme 'cherry-blossom t)




;;(when (file-exists-p custom-file)
;;  (load-file custom-file))
