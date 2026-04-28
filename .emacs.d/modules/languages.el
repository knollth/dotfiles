;;; -*- lexical-binding: t; -*-

(defun my/eglot-add-server (mode cmd)
  "Add MODE -> CMD mapping to eglot-server-programs after eglot loads."
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs (cons mode cmd))))

(use-package eglot
  :straight nil
  :bind (:map eglot-mode-map
              ("C-c h" . eglot-inlay-hints-mode))
  :hook (eglot-managed-mode . (lambda () (eglot-inlay-hints-mode -1))))  ; default aus

;; apheleia does auto-format
(use-package apheleia 
  :hook ((tuareg-mode . apheleia-mode)
	 (python-ts-mode . apheleia-mode)))
;; ------------------ Configuration Languages --------------

(use-package nix-mode
  :mode "\\.nix\\'"
  :hook ((nix-mode . apheleia-mode)))

(use-package kdl-mode)

(use-package yaml-pro
  :mode ("\\.ya?ml\\'" . yaml-ts-mode)
  :hook (yaml-ts-mode . yaml-pro-ts-mode)
  :init
  (add-to-list 'treesit-language-source-alist
               '(yaml "https://github.com/tree-sitter-grammars/tree-sitter-yaml")))

;; -------------------- Janet -----------------------
(use-package janet-ts-mode
  :straight (:host nil :repo "https://github.com/sogaiu/janet-ts-mode")
  :init (add-to-list 'treesit-language-source-alist
		     '(janet-simple "https://github.com/sogaiu/tree-sitter-janet-simple")))


;; -------------------- Java -----------------------
(use-package eglot-java
  :straight (:host github :repo "yveszoundi/eglot-java")
  :hook (java-ts-mode . eglot-java-mode))  ;; eglot-java-mode calls eglot-ensure internally

(use-package java-ts-mode
  :straight nil
  :init
  (add-to-list 'major-mode-remap-alist '(java-mode . java-ts-mode))
  (add-to-list 'treesit-language-source-alist
               '(java "https://github.com/tree-sitter/tree-sitter-java"))
  :mode "\\.java\\'")

;; -------------------- GLSL -----------------------
(use-package glsl-mode
  :mode ("\\.fp\\'" "\\.vp\\'" "\\.frag\\'" "\\.vert\\'"))

;; -------------------- R/Statistics -----------------------

(use-package ess
  :mode (("\\.R\\'" . ess-r-mode)
         ("\\.Rmd\\'" . ess-r-mode))
  :custom
  (ess-style 'RStudio)              
  (ess-ask-for-ess-directory nil))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t))) ; Erlaubt die Ausführung von R-Code

;; --------------------- Zig ------------------------

(use-package zig-ts-mode
  :straight (:host nil :repo "https://codeberg.org/meow_king/zig-ts-mode")
  :init
  (add-to-list 'treesit-language-source-alist '(zig "https://github.com/tree-sitter-grammars/tree-sitter-zig"))
  (my/eglot-add-server 'zig-ts-mode '("zls"))  
  :mode "\\.zig\\'"
  :hook (zig-ts-mode . eglot-ensure))

;; -------------------- C/C++ -----------------------

(use-package c-ts-mode
  :straight nil ;; built-in
  :init
  (add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
  (add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))  
  (add-to-list 'treesit-language-source-alist '(c "https://github.com/tree-sitter/tree-sitter-c"))
  (add-to-list 'treesit-language-source-alist '(cpp "https://github.com/tree-sitter/tree-sitter-cpp"))
  :mode (("\\.c\\'" . c-ts-mode) 
         ("\\.h\\'" . c-ts-mode)
         ("\\.cpp\\'" . c++-ts-mode)   
         ("\\.hpp\\'" . c++-ts-mode))  
  :custom
  (c-ts-mode-indent-offset 8)
  (c-ts-mode-indent-style 'linux)
)


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
  :straight (:host nil :repo "https://codeberg.org/meow_king/typst-ts-mode.git")
  :init
  (my/eglot-add-server 'typst-ts-mode  '("tinymist" "lsp"))
  (add-to-list 'treesit-language-source-alist '(typst "https://github.com/uben0/tree-sitter-typst") )
  :mode "\\.typ\\'"
  :hook (typst-ts-mode . eglot-ensure)
  :custom (typst-ts-mode-indent-offset 2))


;; -------------------- OCaml -----------------------
(use-package tuareg
  :hook ((tuareg-mode . eglot-ensure)
         (tuareg-mode . prettify-symbols-mode))
  :custom (tuareg-default-indent 2))

(use-package utop
  :custom (utop-command "utop -emacs")
  :hook (tuareg-mode . utop-minor-mode))

;; -------------------- Python -----------------------
(use-package python
  :straight nil ;; built-in
  :init
  (add-to-list 'major-mode-remap-alist '(python-mode . python-ts-mode))
  (add-to-list 'treesit-language-source-alist '(python "https://github.com/tree-sitter/tree-sitter-python"))
  (my/eglot-add-server '(python-mode python-ts-mode)
                       '("basedpyright-langserver" "--stdio"))
  :hook (python-ts-mode . eglot-ensure)
  :custom (python-indent-offset 4))

;; -------------------- SQL/PL/SQL -----------------------

(use-package sql
  :straight nil
  :custom
  (sql-product 'oracle)
  (sql-connection-alist
   '((oracle-local
      (sql-product 'oracle)
      (sql-user "system")
      (sql-password "yourpassword")
      (sql-database "localhost:1521/FREEPDB1")))))

(use-package sql-indent
  :hook (sql-mode . (lambda ()
                      (unless (bound-and-true-p org-src-mode)
                        (sqlind-minor-mode 1)))))


;;(use-package plsql
;;  :straight (:host github :repo "emacsmirror/plsql")
;;  :mode (("\\.pls\\'" . plsql-mode)
;;         ("\\.plb\\'" . plsql-mode)  
;;         ("\\.pkg\\'" . plsql-mode)
;;         ("\\.pkb\\'" . plsql-mode)))


;------------------------------------------------------------
(provide 'languages)
