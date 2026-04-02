;; Aporetic - Prot's Iosevka build (schmal = mehr Platz)
(set-face-attribute 'default nil 
                    :family "Aporetic Sans Mono"
                    :height 130  ; bei 2x HiDPI evtl. 140
                    :weight 'regular)

;; Variable pitch für org prose (optional)
(set-face-attribute 'variable-pitch nil
                    :family "Aporetic Sans"
                    :height 130)
1234567890
;; Fixed pitch explizit (für org code blocks)
(set-face-attribute 'fixed-pitch nil
                    :family "Aporetic Sans Mono"
                    :height 130)

(use-package ligature
  :config
  ;; Iosevka/Aporetic ligatures
  (ligature-set-ligatures '(prog-mode org-mode)
                          '("->" "->>" "-->" "---" "=>" "==>" "==" "===" 
                            "!=" "!==" "::" ":::" "&&" "||" "|>" "<|"
                            "++" "+++" "<-" "<<-" "<--" "<>" "<!--"
                            ">>" "<<" ">>=" "<<=" "/=" "<=" ">="
                            "#{" "#(" "#_" "#_(" "#?" "#:" "##"
                            "/*" "*/" "/**" "www" "&&" "***"))
  (global-ligature-mode t))

(provide 'setup-fonts)
