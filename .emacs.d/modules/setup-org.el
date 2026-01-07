(use-package org
  :ensure t
  :bind (("C-c a" . org-agenda)
	 ("C-c c" . org-capture))
  :custom
  (org-directory "~/org")
  (org-agenda-files '("~/org/agenda"))
  (org-preview-latex-default-process 'dvisvgm)
  (org-startup-with-latex-preview nil)
  (org-src-fontify-natively t)
  (org-src-tab-acts-natively t)
  (org-src-preserve-indentation t)
  (org-edit-src-content-indentation 0)
  ;; Allow refiling to the top level of any file in your agenda list
  (org-refile-targets '((org-agenda-files :maxlevel . 1)))
  ;; Make the refile prompt show the filename (e.g., "projects.org/Tasks")
  (org-refile-use-outline-path 'file)
  ;; Allow completing the full path in one go rather than step-by-step
  (org-outline-path-complete-in-steps nil)
  
  :config
  ;; === Formatting ===
  (plist-put org-format-latex-options :scale 0.5)
  (add-hook 'org-mode-hook #'electric-pair-local-mode)
  ;; === Org Capture Templates ===
  (setq org-capture-templates
        '(("i" "Inbox/Brainstorm" entry (file "~/org/agenda/inbox.org")
           "* TODO %?\n  :PROPERTIES:\n  :CREATED: %U\n  :END:\n  %i"
	   :empty-lines 1)
          ("w" "Wiki Note" entry (file "~/org/wiki/inbox.org") ; General wiki catch-all
           "* %?\n %i\n %a")))
  ;; === Custom Agenda Views ===
  (setq org-agenda-custom-commands
        '(("d" "Dashboard"
           ((agenda "" ((org-agenda-span 7))) ; Weekly view
            (todo "TODO" 
                  ((org-agenda-overriding-header "Inbox/Brainstorming")
                   (org-agenda-files '("~/org/agenda/inbox.org"))))))))
  ;; === Babel Setup ===
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (shell . t)))

  
  ;; Wolfram Logic: Moved here to ensure 'org-src-lang-modes' exists
  (add-to-list 'org-src-lang-modes '("wolfram" . wolfram))
  (defun org-babel-execute:wolfram (body _params)
    (org-babel-eval (format "wolframscript -code %s" (shell-quote-argument body)) ""))
  
  (add-hook 'org-babel-after-execute-hook #'org-display-inline-images)
  
  
  (setq org-babel-python-command "python3")
  
  ;; == Babel Defaults ==
  (setq org-babel-default-header-args
        '((:session . "none")
          (:results . "replace")
          (:exports . "code")
          (:cache . "no")
          (:noweb . "no")
          (:hlines . "no")
          (:tangle . "no")))
  
  (setq org-babel-default-header-args:emacs-lisp
        '((:results . "value"))))
  

;;(use-package auctex
;;  :defer t)

(use-package org-roam
  :ensure t
  :init
  ;; This is required for Org-roam V2
  (setq org-roam-v2-ack t)
  :custom
  ;; The absolute path to your wiki folder
  (org-roam-directory (file-truename "~/org/wiki"))
  ;; Set this to nil if you don't want the database to sync on every save (for performance)
  (org-roam-db-autosync-mode t)
  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n l" . org-roam-buffer-toggle)
         ("C-c n c" . org-roam-capture)
         ("C-c n d" . org-roam-dailies-capture-today))
  :config
  (unless (file-exists-p org-roam-directory)
    (make-directory org-roam-directory t))
  

  (org-roam-db-autosync-mode 1))

(provide 'setup-org)
