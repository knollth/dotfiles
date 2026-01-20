(setq treesit-language-source-alist
      '((c "https://github.com/tree-sitter/tree-sitter-c")
	(typst "https://github.com/uben0/tree-sitter-typst")
	(python "https://github.com/tree-sitter/tree-sitter-python")
	(julia "https://github.com/tree-sitter/tree-sitter-julia")
	(ocaml "https://github.com/tree-sitter/tree-sitter-ocaml" "master" "ocaml/src")
        (ocaml-interface "https://github.com/tree-sitter/tree-sitter-ocaml" "master" "interface/src")))

(defun my/eglot-add-server (mode cmd)
  "Add MODE -> CMD mapping to eglot-server-programs after eglot loads."
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs (cons mode cmd))))

(use-package apheleia
  :ensure t
  :hook ((tuareg-mode . apheleia-mode)
	 (python-ts-mode . apheleia-mode)))

;; -------------------- C/C++ -----------------------
(use-package c-ts-mode
  ;; for edge-cases where (c-mode) is called
  :init (add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
  :custom (c-ts-mode-indent-offset 2)
  :mode ("\\.c\\'" "\\.h\\'");; theoretically redundant bc of :init
  :hook (c-ts-mode . eglot-ensure))

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

;; -------------------- Julia -----------------------

(use-package julia-ts-mode
  :mode "\\.jl\\'"
  :hook (julia-ts-mode . eglot-ensure)
  :init (my/eglot-add-server
         '(julia-mode julia-ts-mode)
	 '("julia" "--startup-file=no" "--history-file=no" "-e"
           "using LanguageServer; runserver()")))

;; --------------------------------------------------


(provide 'languages)
