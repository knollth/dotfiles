;;; -*- lexical-binding: t; -*-

(use-package mu4e
  :ensure nil
  :load-path "/usr/share/emacs/site-lisp/mu4e/" ;; Adjust if needed
  :bind ("C-c m" . mu4e)
  
  :custom
  (mu4e-maildir "~/.mail")
  (mu4e-get-mail-command "mbsync -a")
  (mu4e-update-interval 600)             ;; 10 minutes (in seconds)
  (mu4e-attachment-dir "~/Downloads")
  (mu4e-change-filenames-when-moving t)
  (mu4e-context-policy 'pick-first)
  (mu4e-compose-context-policy 'ask-if-none)
  
  (mu4e-headers-date-format "%d.%m.%y")
  (mu4e-use-fancy-chars t)
  (mu4e-headers-fields '((:human-date . 12)
                         (:flags      . 6)
                         (:from       . 22)
                         (:subject    . nil)))

  ;; SMTP Config
  (message-send-mail-function 'smtpmail-send-it)
  (smtpmail-stream-type 'ssl)
  (smtpmail-smtp-server "smtp.migadu.com")
  (smtpmail-smtp-service 465)

  (auth-sources '(password-store))
  
  (mu4e-maildir-shortcuts
   '(("/knollth.dev/mail/Inbox"     . ?m)
     ("/knollth.dev/accounts/Inbox" . ?a)
     ("/thomasknoll.me/mail/Inbox"  . ?p)
     ("/thomasknoll.me/uni/Inbox"   . ?u)))

  :config
  (auth-source-pass-enable)
  (setq mu4e-contexts
        (list
         (make-mu4e-context
          :name "Dev-Mail"
          :match-func (lambda (msg)
                        (when msg
                          (string-prefix-p "/knollth.dev/mail" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address  . "mail@knollth.dev")
                  (user-full-name     . "Thomas Knoll")
                  (smtpmail-smtp-user . "mail@knollth.dev")
                  (mu4e-sent-folder   . "/knollth.dev/mail/Sent")
                  (mu4e-drafts-folder . "/knollth.dev/mail/Drafts")
                  (mu4e-trash-folder  . "/knollth.dev/mail/Trash")
                  (mu4e-refile-folder . "/knollth.dev/mail/Archive")))
	 (make-mu4e-context
          :name "Accounts-Mail"
          :match-func (lambda (msg)
                        (when msg
                          (string-prefix-p "/knollth.dev/mail" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address  . "mail@knollth.dev")
                  (user-full-name     . "Thomas Knoll")
                  (smtpmail-smtp-user . "mail@knollth.dev")
                  (mu4e-sent-folder   . "/knollth.dev/mail/Sent")
                  (mu4e-drafts-folder . "/knollth.dev/mail/Drafts")
                  (mu4e-trash-folder  . "/knollth.dev/mail/Trash")
                  (mu4e-refile-folder . "/knollth.dev/mail/Archive")))
	 )))

(provide 'setup-mail)
