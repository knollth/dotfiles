;;; -*- lexical-binding: t; -*-


(defun my/inbox    () (interactive) (find-file "/ssh:rpi-cm4:org/agenda/inbox.org"))
(defun my/dired-dots  () (interactive) (dired "~/dotfiles"))
(defun my/dired-emacsd () (interactive) (dired "~/dotfiles/.emacs.d"))
(defun my/dired-org   () (interactive) (dired "~/org"))

(global-set-key (kbd "C-c d") 'my/dired-dots)
(global-set-key (kbd "C-c e") 'my/dired-emacsd)
(global-set-key (kbd "C-c o") 'my/dired-org)

;; --- Uni Folder Navigation

(defvar my/uni-dir (expand-file-name "SS26" (getenv "UNI"))
  "Base directory for uni navigation.")
(defconst my/uni-file-regex
  "\\.\\(typ\\|pdf\\|org\\|c\\|h\\|py\\|rs\\|ml\\|hs\\|java\\|js\\|ts\\)$")

(defun my/uni--pick (regex prompt)
  "completing-read over files/dirs under `my/uni-dir' matching REGEX."
  (let* ((skip (lambda (d) (not (string-prefix-p "." (file-name-nondirectory d)))))
         (hits (directory-files-recursively my/uni-dir regex t skip))
         (pick (completing-read prompt (mapcar (lambda (p) (file-relative-name p my/uni-dir)) hits))))
    (expand-file-name pick my/uni-dir)))

(defun my/uni-jump ()
  "Jump to a uni file."
  (interactive)
  (find-file (my/uni--pick my/uni-file-regex "Uni file: ")))

(defun my/uni-dirs ()
  "Jump to a uni directory."
  (interactive)
  (dired (my/uni--pick "" "Uni dir: ")))

(keymap-global-set "C-c u" #'my/uni-jump)
(keymap-global-set "C-c U" #'my/uni-dirs)


(provide 'shortcuts)
