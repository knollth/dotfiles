(unless (package-installed-p 'org-mode)
  (package-vc-install '(org-mode :url "https://code.tecosaur.net/tec/org-mode" :branch "dev")))

(use-package org
  :load-path "~/.emacs.d/elpa/org-mode/lisp/"
  :ensure nil
  :hook (org-mode . org-latex-preview-mode)
  :bind (("C-c a" . org-agenda)
	 ("C-c c" . org-capture)
	 ("C-c l" . org-latex-preview))
  :custom
  (org-edit-src-content-indentation 0)
  (org-export-babel-evaluate nil)
  (org-directory "~/org")
  (org-agenda-files '("~/org/agenda"))
  (org-agenda-include-diary t)
  (org-refile-targets '((org-agenda-files :maxlevel . 1)))
  (org-refile-use-outline-path 'file)
  (org-outline-path-complete-in-steps nil)

   ;; Async latex preview (tecosaur)
  (org-latex-preview-mode-display-live t)
  (org-latex-preview-mode-update-delay 0.3)
  (org-latex-preview-process-precompile t)
  (org-latex-preview-numbered t)
  (org-latex-preview-appearance-options
      '(:foreground default
        :background default
        :zoom 1.3   
        :html-scale 1.0))
  
  :config
  (require 'ox-beamer)
  (setq org-capture-templates
        '(;; Quick inbox for random thoughts
          ("i" "Inbox" entry (file "~/org/agenda/inbox.org")
           "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:"
           :empty-lines 1)

          ;; Log a problem you just worked on (quick entry)
          ("p" "Problem (quick log)" entry
           (file+headline "~/org/agenda/math.org" "Problem Log")
           "* %{state} %^{Problem} %^g\n:PROPERTIES:\n:SOURCE: %^{Source}\n:DATE: %U\n:END:\n%?"
           :empty-lines 1)))
  (setq org-agenda-custom-commands
        '(;; Main dashboard: what's on your plate
          ("d" "Dashboard"
           ((agenda "" ((org-agenda-span 3)
                        (org-agenda-start-on-weekday nil)))
            (todo "STUCK"
                  ((org-agenda-overriding-header "Stuck - Need to revisit")))
            (todo "TODO"
                  ((org-agenda-overriding-header "Inbox")
                   (org-agenda-files '("~/org/agenda/inbox.org"))))))
          ("m" "Math Dashboard"
           ((todo "STUCK"
                  ((org-agenda-overriding-header "Stuck Problems")
                   (org-agenda-files '("~/org/agenda/math.org"))))
            (todo "TODO"
                  ((org-agenda-overriding-header "Problems Queue")
                   (org-agenda-files '("~/org/agenda/math.org"))))
            (tags "CLOSED>=\"<-7d>\""
                  ((org-agenda-overriding-header "Completed This Week")
                   (org-agenda-files '("~/org/agenda/math.org"))))))))
  
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (shell . t)
     (dot . t)
     (sql . t)))

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
  

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/org/wiki"))
  (org-roam-db-autosync-mode t)
  (org-roam-node-display-template
   (concat "${title:*} "
	   (propertize "${tags:30}" 'face 'org-tag)))
  
  (org-roam-capture-templates
   '(("c" "Concept" plain
      "* Definition\n%?\n\n* Key Ideas\n\n* Examples\n\n* See Also\n"
      :target (file+head "${slug}.org"
                         "#+title: ${title}\n#+filetags: :concept:\n")
      :unnarrowed t)
     
     ("s" "Source/Textbook" plain
      "* Overview\n%?\n\n* Chapters\n\n* My Notes\n"
      :target (file+head "sources/${slug}.org"
                         "#+title: ${title}\n#+filetags: :source:\n")
      :unnarrowed t)))
  
  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n l" . org-roam-buffer-toggle)
         ("C-c n c" . org-roam-capture)
         ("C-c n d" . org-roam-dailies-capture-today))
  :config
  (org-roam-db-autosync-mode 1))

(require 'ox-md)

(use-package auctex
  :defer t)

(use-package cdlatex
  :ensure t
  :hook (org-mode . turn-on-org-cdlatex)
  :config
  ;; Add blackboard bold letters (not in CDLaTeX by default)
  (setq cdlatex-math-symbol-alist
        '((?N ("\\mathbb{N}"))
          (?R ("\\mathbb{R}"))
          (?Z ("\\mathbb{Z}"))
          (?Q ("\\mathbb{Q}"))
          (?C ("\\mathbb{C}"))))
  (setq cdlatex-env-alist
        '(("bmat" "\\begin{bmatrix}\n?\n\\end{bmatrix}" nil)
          ("pmat" "\\begin{pmatrix}\n?\n\\end{pmatrix}" nil)
          ("cases" "\\begin{cases}\n?\n\\end{cases}" nil)))
  (setq cdlatex-math-modify-alist
        '((?b "\\mathbf" nil t nil nil)
          (?c "\\mathcal" nil t nil nil)
          (?s "\\mathscr" nil t nil nil))))
 
(provide 'setup-org)
