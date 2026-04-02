(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch))
  :config
  ;; Optional: If you find Magit slow in huge repos, uncomment this:
  ;; (setq magit-refresh-status-buffer nil)
  )

(provide 'setup-git)
