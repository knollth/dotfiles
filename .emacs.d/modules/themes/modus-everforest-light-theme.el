;;; modus-everforest-light-theme.el --- Everforest Light built on Modus -*- lexical-binding: t -*-

;; Author: Tom
;; Based on Everforest by sainnhe
;; Requires: modus-themes 5.0+

;;; Commentary:
;; Everforest light palette ported to Modus using modus-themes-generate-palette.
;; Place this file in a directory on `custom-theme-load-path'.

;;; Code:

(require 'modus-themes)
(defvar modus-everforest-heading-overrides
  '((fg-heading-1 blue)        ; Level 1
    (fg-heading-2 green)       ; Level 2
    (fg-heading-3 yellow)      ; Level 3
    (fg-heading-4 red)         ; Level 4
    (fg-heading-5 magenta)     ; Level 5
    (fg-heading-6 cyan)        ; Level 6
    (fg-heading-7 red-warmer)  ; Level 7
    (fg-heading-8 fg-dim)))    ; Level 8

(defvar modus-everforest-light-palette
  (modus-themes-generate-palette
   ;; BASE-COLORS
   '((bg-main "#F3EAD3")
     (bg-dim "#E5DFC5")
     (bg-alt "#EAE4CA")
     (fg-main "#5C6A72")
     (fg-dim "#829181")
     (fg-alt "#939F91")
     (red "#F85552")
     (red-warmer "#F57D26")       ; orange
     (red-cooler "#F85552")
     (green "#8DA101")
     (green-warmer "#8DA101")
     (green-cooler "#35A77C")     ; aqua
     (yellow "#DFA000")
     (yellow-warmer "#F57D26")
     (yellow-cooler "#DFA000")
     (blue "#3A94C5")
     (blue-warmer "#3A94C5")
     (blue-cooler "#3A94C5")
     (magenta "#DF69BA")
     (magenta-warmer "#DF69BA")
     (magenta-cooler "#DF69BA")
     (cyan "#35A77C")
     (cyan-warmer "#35A77C")
     (cyan-cooler "#35A77C"))
   nil    ; COOL-OR-WARM-PREFERENCE (nil = auto-detect, light bg → cool)
   nil))  ; CORE-PALETTE (nil = use modus-operandi since bg-main is light)

(modus-themes-theme
 'modus-everforest-light         ; NAME (unquoted symbol)
 'modus-everforest-themes        ; GROUP (unquoted symbol)
 "Everforest light theme built on Modus."
 'light                          ; VARIANT (unquoted symbol)
 'modus-everforest-light-palette ; PALETTE (unquoted symbol)
 nil                            ; OVERRIDES-PALETTE
 'modus-everforest-heading-overrides)                           ; USER-PALETTE

(provide-theme 'modus-everforest-light)
(provide 'modus-everforest-light-theme)
;;; modus-everforest-light-theme.el ends here
