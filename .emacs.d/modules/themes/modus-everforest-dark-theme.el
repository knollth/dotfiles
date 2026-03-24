(require 'modus-themes)

;; 1. Define Overrides for Headings AND Code Syntax
(defvar modus-everforest-overrides
  '((fg-heading-0 fg-main)
    (fg-heading-1 green)
    (fg-heading-2 red)
    (fg-heading-3 magenta)
    (fg-heading-4 red-warmer)
    (fg-heading-5 blue)
    (fg-heading-6 cyan)
    (fg-heading-7 red-warmer)
    (fg-heading-8 fg-dim)

    ;; --- CODE SYNTAX OVERRIDES ---
    ;; This forces "ifs" (keywords) to be red, matching Everforest logic
    (keyword red)           ; "if", "else", "define"
    (builtin magenta)       ; Built-in functions
    (type yellow)           ; Class names, types
    (fnname blue)           ; Function definitions
    (string green)          ; Strings
    (constant magenta-cooler) ; Constants, booleans
    (variable fg-main)      ; Variables
    (comment fg-dim)        ; Comments
    ))

(defvar modus-everforest-dark-palette
  (modus-themes-generate-palette
   ;; BASE-COLORS
   '((bg-main "#272E33")
     (bg-dim "#1E2326")
     (bg-alt "#2E383C")
     (fg-main "#D3C6AA")
     (fg-dim "#9DA9A0")
     (fg-alt "#859289")
     (red "#E67E80")
     (red-warmer "#E69875")
     (red-cooler "#E67E80")
     (green "#A7C080")
     (green-warmer "#A7C080")
     (green-cooler "#83C092")
     (yellow "#DBBC7F")
     (yellow-warmer "#E69875")
     (yellow-cooler "#DBBC7F")
     (blue "#7FBBB3")
     (blue-warmer "#7FBBB3")
     (blue-cooler "#7FBBB3")
     (magenta "#D699B6")
     (magenta-warmer "#D699B6")
     (magenta-cooler "#D699B6")
     (cyan "#83C092")
     (cyan-warmer "#A7C080")
     (cyan-cooler "#7FBBB3")
     ;; FIXED: Added missing '#' to these three lines
     (bg-cyan-subtle "#384B55")
     (bg-blue-subtle "#384B55")
     (bg-green-subtle "#3C4841"))
   'warm  ; COOL-OR-WARM-PREFERENCE
   nil))  ; CORE-PALETTE

(modus-themes-theme
 'modus-everforest-dark          ; 1. NAME
 'modus-everforest-themes        ; 2. FAMILY
 "Everforest dark theme built on Modus."
 'dark                           ; 3. VARIANT
 'modus-everforest-dark-palette  ; 5. CORE-PALETTE
 nil                             ; 6. USER-PALETTE
 'modus-everforest-overrides)    ; 7. OVERRIDES-PALETTE (Enabled!)

(provide-theme 'modus-everforest-dark)
(provide 'modus-everforest-dark-theme)
