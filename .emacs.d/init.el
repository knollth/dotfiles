(setq custom-file "~/.emacs.custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq inhibit-startup-screen t)
(repeat-mode 1)

(setq tramp-use-connection-share nil)

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

(setq auto-revert-avoid-polling t)

;; Straight bootstrap and Package Definitions

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(use-package project :demand t)

;; ** Modules ** 
(add-to-list 'load-path "~/.emacs.d/modules")
(require 'setup-meow)
(require 'completion)
(require 'setup-org)
(require 'shortcuts)
(require 'setup-theme)
(require 'setup-fonts)
(require 'setup-mail)
(require 'setup-git)
(require 'languages)

(use-package substitute
  :ensure t
  :config
  (setq substitute-fixed-letter-case t)
  (add-hook 'substitute-post-replace-functions #'substitute-report-operation)
  (define-key global-map (kbd "C-c s") #'substitute-prefix-map))


(use-package clipetty
  ;; allows copypasting when using emacs in terminal mode
  :ensure t
  :hook (after-init . global-clipetty-mode))

(use-package ghostel
  :ensure t)

(use-package tmr
  :config
  (define-key global-map (kbd "C-c t") #'tmr-prefix-map)
  (setq tmr-sound-file "/usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga"
        tmr-notification-urgency 'normal
        tmr-description-list 'tmr-description-history))

(use-package denote
  :straight (:type git :host github :repo "protesilaos/denote")
  :custom
  (denote-directory (expand-file-name "~/Notes")))

(use-package consult-denote
  :straight (:type git :host github :repo "protesilaos/consult-denote")
  :bind ("C-c n f" . consult-denote-find) 
  :config
  (consult-denote-mode 1))

(use-package enlight ;; dashboard
  :init
  (setopt initial-buffer-choice #'enlight)
  :custom
  (enlight-content
   (concat
    ;;(propertize "MENU" 'face 'highlight)
    "\n"
    (enlight-menu
     '(("Org Mode"
	("Org-Agenda (current day)" (org-agenda nil "a") "a")
	("Inbox" (find-file "/ssh:rpi-cm4:org/agenda/inbox.org") "i"))
       ("Uni"
	("uni-jump" (my/uni-jump my/uni-file-regex) "u")
	("uni-dirs" (my/uni-dirs) "d"))
       ("Other"
	("Projects" project-switch-project "p")))))))
