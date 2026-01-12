(use-package org
  :ensure t
  :bind (("C-c a" . org-agenda)
	 ("C-c c" . org-capture)
	 ("C-c l" . org-latex-preview))
  ;:hook ((org-mode . org-latex-preview))
  :custom
  (org-directory "~/org")
  (org-agenda-files '("~/org/agenda"))
  (org-preview-latex-default-process 'dvisvgm)
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
  (plist-put org-format-latex-options :scale 0.5)
  ;;(add-hook 'org-mode-hook #'electric-pair-local-mode)
  (setq org-capture-templates
        '(("i" "Inbox/Brainstorm" entry (file "~/org/agenda/inbox.org")
           "* TODO %?\n  :PROPERTIES:\n  :CREATED: %U\n  :END:\n  %i"
	   :empty-lines 1)
          ("w" "Wiki Note" entry (file "~/org/wiki/inbox.org") ; General wiki catch-all
           "* %?\n %i\n %a")))
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
     (shell . t)
     (dot . t)))

  
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
  

(use-package auctex
  :defer t)
(require 'texmathp)

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-node-display-template
   (concat "${title:*} "
	   (propertize "${tags:30}" 'face 'org-tag)))

  (org-roam-capture-templates
	'(("d" "default" plain "%?"
	   :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
			      "#+title: ${title}\n")
	   :unarrowed t)
	  ("m" "math concept" plain
	   "* Definition\n%?\n\n* Examples\n\n* Related\n\n* Sources\n"
	   :target (file+head "math/%<%Y%m%d%H%M%S>-${slug}.org"
			      "#+title: ${title}\n#+filetags: :math:\n#+STARTUP: latexpreview\n")
	   :unarrowed t)
	  
	  ("p" "problem" plain
	   "* Problem\n%?\n\n* Scratch\n\n* Solution\n\n* Source\n"
	   :target (file+head "problems/%<%Y%m%d%H%M%S>-${slug}.org"
			      "#+title: ${title}\n#+filetags: :problem:\n")
	   :unarrowed t)
	  ("s" "source" plain
	   "* Overview\n%?\n\n* Notable Sections\n\n* Problems done\n"
	   :target (file+head "sources/%<%Y%m%d%H%M%S>-${slug}.org"
			      "#+title: ${title}\n#+filetags: :source:\n#+STARTUP: latexpreview\n")
	   :unarrowed t)))
  
  (org-roam-directory (file-truename "~/org/wiki"))
  (org-roam-db-autosync-mode t)
  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n l" . org-roam-buffer-toggle)
         ("C-c n c" . org-roam-capture)
         ("C-c n d" . org-roam-dailies-capture-today))
  :config
  (org-roam-db-autosync-mode 1))

(provide 'setup-org)
