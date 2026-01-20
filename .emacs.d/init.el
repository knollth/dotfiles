(setq custom-file "~/.emacs.custom.el")
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

(setq inhibit-startup-screen t)

;; UI Basics
(setq ring-bell-function 'ignore)
(menu-bar-mode 0)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq default-frame-alist '((undecorated . t)))

;; Gc Tweaks
(setq gc-cons-threshold (* 150 1024 1024))
(add-function :after after-focus-change-function
  (lambda ()
    (unless (cl-some #'frame-focus-state (frame-list))
      (garbage-collect))))

;; Scrolling
(pixel-scroll-precision-mode 1)
(setq scroll-conservatively 101)
(setq scroll-margin 3)
(setq display-line-numbers-type 'relative)

;;(global-display-line-numbers-mode)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)  
(add-hook 'text-mode-hook #'display-line-numbers-mode)  
(add-hook 'conf-mode-hook #'display-line-numbers-mode)  
(add-hook 'dired-mode-hook #'display-line-numbers-mode)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(setq package-vc-allow-build-commands t)

(require 'use-package)
(setq use-package-always-ensure t)

;; ** Modules ** 
(add-to-list 'load-path "~/.emacs.d/modules")
(require 'setup-org)
(require 'setup-fonts)
(require 'languages)
(require 'setup-meow)
(require 'shortcuts)

(setq auto-revert-use-notify t)
(setq auto-revert-avoid-polling t)

;; ** themes **
;;(use-package cherry-blossom-theme)
;;(use-package ef-themes
;;  :ensure t
;;  :init
;;  (ef-themes-take-over-modus-themes-mode 1)
;;  :bind
;;  (("<f9>" . modus-themes-rotate)
;;   ("C-<f9>" . modus-themes-select)
;;   ("M-<f9>" . modus-themes-load-random))
;;  :config
;;  ;; All customisations here.
;;  (setq modus-themes-mixed-fonts t)
;;  (setq modus-themes-italic-constructs t)
;;  (modus-themes-load-theme 'ef-cherie))

(use-package solarized-theme)
(load-theme 'solarized-dark-high-contrast t)

;; -- Completion
(add-hook 'prog-mode-hook 'electric-pair-mode)

(use-package yasnippet
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-global-mode 1))

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package consult
  :ensure t
  :bind (("C-s" . consult-line)
         ("C-x b" . consult-buffer)
         ("M-y" . consult-yank-pop)))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package marginalia
  :ensure t
  :init (marginalia-mode))

(use-package corfu
  :ensure t
  :custom (corfu-cycle t)            
  :init (global-corfu-mode))

(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :hook (pdf-view-mode . auto-revert-mode)
  :config
  (pdf-tools-install))  ; compiles the epdfinfo server

(add-to-list 'display-buffer-alist
             '("\\.pdf\\'"
               (display-buffer-reuse-window display-buffer-in-direction)
               (direction . right)
               (window-height . 0.5)))

