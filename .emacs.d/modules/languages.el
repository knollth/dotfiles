;;; -*- lexical-binding: t; -*-
(setq treesit-language-source-alist
      '((c "https://github.com/tree-sitter/tree-sitter-c")
	(zig "https://github.com/tree-sitter-grammars/tree-sitter-zig")
	(cpp "https://github.com/tree-sitter/tree-sitter-cpp")
	(typst "https://github.com/uben0/tree-sitter-typst")
	(python "https://github.com/tree-sitter/tree-sitter-python")
	(ocaml "https://github.com/tree-sitter/tree-sitter-ocaml" "master" "ocaml/src")
        (ocaml-interface "https://github.com/tree-sitter/tree-sitter-ocaml" "master" "interface/src")
	(janet-simple "https://github.com/sogaiu/tree-sitter-janet-simple")))


(use-package janet-ts-mode
  :vc (:url "https://github.com/sogaiu/janet-ts-mode"
	    :rev :newest))

(defun my/eglot-add-server (mode cmd)
  "Add MODE -> CMD mapping to eglot-server-programs after eglot loads."
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs (cons mode cmd))))

(use-package eglot
  :bind (:map eglot-mode-map
              ("C-c h" . eglot-inlay-hints-mode))
  :hook (eglot-managed-mode . (lambda () (eglot-inlay-hints-mode -1))))  ; default aus

(use-package apheleia
  :ensure t
  :hook ((tuareg-mode . apheleia-mode)
	 (python-ts-mode . apheleia-mode)))

;; -------------------- R/Statistics -----------------------

(use-package ess
  :ensure t
  :mode (("\\.R\\'" . ess-r-mode)
         ("\\.Rmd\\'" . ess-r-mode))
  :custom
  (ess-style 'RStudio)              
  (ess-ask-for-ess-directory nil))  

;; --------------------- Zig ------------------------

(use-package zig-ts-mode
  :vc (:url "https://codeberg.org/meow_king/zig-ts-mode"
	    :rev :newest)
  :init (my/eglot-add-server 'zig-ts-mode '("zls"))  
  :mode "\\.zig\\'"
  :hook (zig-ts-mode . eglot-ensure))

;; -------------------- C/C++ -----------------------

(use-package c-ts-mode
  :init 
  (add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
  (add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))  ; NEU
  :mode (("\\.c\\'" . c-ts-mode) 
         ("\\.h\\'" . c-ts-mode)
         ("\\.cpp\\'" . c++-ts-mode)   ; NEU
         ("\\.hpp\\'" . c++-ts-mode))  ; NEU
  :custom (c-ts-mode-indent-offset 4)
  :hook ((c-ts-mode . eglot-ensure)
         (c++-ts-mode . eglot-ensure)))  ; NEU

;; -------------------- Typst  -----------------------
(defun my/typst-math-p ()
  "Check if point is inside Typst math mode. (for yasnipppet)"
  (when (derived-mode-p 'typst-ts-mode)
    (let ((node (treesit-node-at (point))))
      (while (and node (not (member (treesit-node-type node) 
                                    '("math" "equation"))))
        (setq node (treesit-node-parent node)))
      node)))

(use-package typst-ts-mode
  :vc (:url "https://codeberg.org/meow_king/typst-ts-mode.git")
  :init (my/eglot-add-server 'typst-ts-mode  '("tinymist" "lsp"))
  :mode "\\.typ\\'"
  :hook (typst-ts-mode . eglot-ensure)
  :custom (typst-ts-mode-indent-offset 2))


;; -------------------- OCaml -----------------------
(use-package tuareg
  :ensure t
  :hook ((tuareg-mode . eglot-ensure)
         (tuareg-mode . prettify-symbols-mode))
  :custom (tuareg-default-indent 2))

(use-package utop
  :ensure t
  :custom (utop-command "utop -emacs")
  :hook (tuareg-mode . utop-minor-mode))

;; -------------------- Python -----------------------
(use-package python
  :init
  (add-to-list 'major-mode-remap-alist '(python-mode . python-ts-mode))
  (my/eglot-add-server '(python-mode python-ts-mode)
                       '("basedpyright-langserver" "--stdio"))
  :hook (python-ts-mode . eglot-ensure)
  :custom (python-indent-offset 4))

;; -------------------- Lean4 -----------------------
(use-package nael
  :vc (:lisp-dir "nael"
		 :url "https://codeberg.org/mekeor/nael.git")
  :hook ((nael-mode . eglot-ensure)
	 (nael-mode . abbrev-mode)))

;; -------------------- SQL/PL/SQL -----------------------

(use-package sql
  :custom
  (sql-product 'oracle)
  (sql-connection-alist
   '((oracle-local
      (sql-product 'oracle)
      (sql-user "system")
      (sql-password "yourpassword")
      (sql-database "localhost:1521/FREEPDB1")))))

(use-package sql-indent
  :ensure t
  :hook (sql-mode . (lambda ()
                      (unless (bound-and-true-p org-src-mode)
                        (sqlind-minor-mode 1)))))


;;(use-package plsql
;;  :vc (:url "https://github.com/emacsmirror/plsql")
;;  :mode (("\\.pls\\'" . plsql-mode)
;;         ("\\.plb\\'" . plsql-mode)  
;;         ("\\.pkg\\'" . plsql-mode)
;;         ("\\.pkb\\'" . plsql-mode)))


;------------------------------------------------------------
(provide 'languages)
