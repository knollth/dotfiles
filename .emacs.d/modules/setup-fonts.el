;; set fonts
(set-face-attribute 'default nil 
                    :font "Hasklig" 
                    :height 120 
                    :weight 'normal)

(use-package ligature
  :ensure t
  :config
  ;; Enable all Hasklig ligatures for common modes
  (ligature-set-ligatures '(prog-mode org-mode)
                          '("&&" "***" "*>" "\\\\" "||" "|>" "::" "==" "===" "==>" "=>" 
                            "->>" "->"
                            "=<<" "!!" ">>" ">>=" ">>-" ">-" "-<" "-<<" "<-"
                            "<=" "<==" "<=>" "<$>" "<$" "<*>" "<*" "<>" "++" "/=" "---" "-~" 
                            "~>" "=<" "|||"))
  ;; Global mode enables it everywhere
  (global-ligature-mode t))

(provide 'setup-fonts)

"->"
