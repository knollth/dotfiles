(setq custom-file "~/.emacs.custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq inhibit-startup-screen t)

(repeat-mode 1)

;; UI Basics
(setq ring-bell-function 'ignore)
(menu-bar-mode 0)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(add-to-list 'default-frame-alist '(vertical-scroll-bars . nil))
(add-to-list 'default-frame-alist '(horizontal-scroll-bars . nil))
(add-to-list 'default-frame-alist '(undecorated . t))

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
(require 'languages)
(require 'setup-meow)
(require 'shortcuts)
(require 'setup-theme)
(require 'setup-fonts)
(require 'setup-mail)
(require 'setup-git)

(use-package clipetty
  :ensure t
  :hook (after-init . global-clipetty-mode))

(setq auto-revert-use-notify t)
(setq auto-revert-avoid-polling t)

(use-package vterm
  :ensure t)

(use-package eat
  :ensure t
  :hook (eshell-load . eat-eshell-mode))

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

(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  ;; Show the Embark target at point via Eldoc. You may adjust the
  ;; Eldoc strategy, if you want to see the documentation from
  ;; multiple providers. Beware that using this can be a little
  ;; jarring since the message shown in the minibuffer can be more
  ;; than one line, causing the modeline to move up and down:

  ;; (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  ;; Add Embark to the mouse context menu. Also enable `context-menu-mode'.
  ;; (context-menu-mode 1)
  ;; (add-hook 'context-menu-functions #'embark-context-menu 100)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

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

(use-package tmr
  :ensure t
  :config
  (define-key global-map (kbd "C-c t") #'tmr-prefix-map)
  (setq tmr-sound-file "/usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga"
        tmr-notification-urgency 'normal
        tmr-description-list 'tmr-description-history))


(use-package dashboard
  :demand t
  :ensure t
  :hook (server-after-make-frame . dashboard-open)
  :custom
  (dashboard-banner-logo-title nil)
  (dashboard-startup-banner "~/Pictures/rei_xp.png")
  (dashboard-center-content t)
  (dashboard-vertically-center-content t)  
  (dashboard-image-banner-max-height 260)
  (dashboard-image-banner-max-width 260)
  
  (dashboard-items '((recents   . 8)
                     (projects  . 5)
                     (agenda    . 5)))
  (dashboard-projects-backend 'project-el)
  (dashboard-week-agenda t)
  (dashboard-filter-agenda-entry 'dashboard-no-filter-agenda)
  :config
  (dashboard-setup-startup-hook))

