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

(defcustom my/uni-file-regex "\\.\\(typ\\|pdf\\|org\\|c\\|h\\|py\\|rs\\|ml\\|hs\\|java\\|js\\|ts\\)$"
  "Default regex for `my/uni-jump'.")

(defun my/uni-jump (regex)
  "Jump to a uni folder or file matching REGEX."
  (interactive (list (read-string "File regex: " my/uni-file-regex)))
  (let* ((base (expand-file-name "SS26" (getenv "UNI")))
         (all (directory-files-recursively
               base regex t
               (lambda (d) (not (string-prefix-p "." (file-name-nondirectory d))))))
         (pick (completing-read "Uni: " (mapcar (lambda (p) (file-relative-name p base)) all)))
         (target (expand-file-name pick base)))
    (funcall (if (file-directory-p target) #'dired #'find-file) target)))

(defun my/uni-dirs ()
  "Jump to a uni folder."
  (interactive)
  (let* ((base (expand-file-name "SS26" (getenv "UNI")))
         (dirs (directory-files-recursively
                base "" t
                (lambda (d) (not (string-prefix-p "." (file-name-nondirectory d))))))
         (pick (completing-read "Uni: " (mapcar (lambda (p) (file-relative-name p base)) dirs))))
    (dired (expand-file-name pick base))))

(global-set-key (kbd "C-c u") (lambda () (interactive) (my/uni-jump my/uni-file-regex)))
(global-set-key (kbd "C-c U") #'my/uni-dirs)


(defun my/open-pdf-zathura ()
  "Select PDF via consult, open in Zathura."
  (interactive)
  (let* ((parent (file-name-directory (directory-file-name default-directory)))
         (pdfs (append
                (mapcar (lambda (f) (propertize f 'consult--prefix "current: "))
                        (directory-files default-directory t "\\.pdf\\'" t))
                (mapcar (lambda (f) (propertize f 'consult--prefix "parent:  "))
                        (directory-files parent t "\\.pdf\\'" t))))
         (selected (consult--read pdfs
                                  :prompt "PDF: "
                                  :require-match t
                                  :sort nil
                                  :group (lambda (cand transform)
                                           (if transform cand
                                             (get-text-property 0 'consult--prefix cand)))))
	 )
    (call-process-shell-command
     (format "zathura %s &" (shell-quote-argument selected)) nil 0)))

(keymap-global-set "C-c z" #'my/open-pdf-zathura)
(provide 'shortcuts)
