(defun my/dired-dots ()
  "Open the dotfiles-directory (~/.emacs.d/) in Dired."
  (interactive)
  (dired "~/dotfiles"))

(global-set-key (kbd "C-c d") 'my/dired-dots)

(defun my/dired-emacsd ()
  "Open the emacs.d directory (~/dotfiles/.emacs.d/) in Dired."
  (interactive)
  (dired "~/dotfiles/.emacs.d"))

(global-set-key (kbd "C-c e") 'my/dired-emacsd)

(defun my/dired-org ()
  "Open the org directory (~/org) in Dired."
  (interactive)
  (dired "~/org"))
(global-set-key (kbd "C-c o") 'my/dired-org)

(defun my/dired-uni ()
  "Open dired in the current semester folder defined by $UNI."
  (interactive)
  (let ((uni-path (getenv "UNI")))
    (if uni-path
        (dired (expand-file-name "WS25-26" uni-path)) 
      (message "Error: $UNI environment variable is not set."))))

(global-set-key (kbd "C-c u") 'my/dired-uni)

(provide 'shortcuts)
