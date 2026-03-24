;; -*- lexical-binding: t; -*-
;;; setup-modeline.el — tabbed modeline, colored by the active theme
;;;
;;; Faces are empty shells; ml/setup-faces paints them from the
;;; current modus/ef palette.  Two hooks keep them in sync:
;;;   • modus-themes-after-load-theme-hook  (rotate / select / toggle)
;;;   • enable-theme-functions              (any load-theme call, Emacs 29+)

;;; ── Faces (roles only, no colors) ──────────────────────────

(defface ml/default  '((t nil)) "Normal segment.")
(defface ml/accent   '((t nil)) "Active/state segment.")
(defface ml/dim      '((t nil)) "Background info.")
(defface ml/modified '((t nil)) "Unsaved buffer.")
(defface ml/vc       '((t nil)) "Version control.")

;;; ── Paint from palette ─────────────────────────────────────

(defun ml/box (color)
  "Tab-shaped box spec for COLOR."
  `(:line-width (3 . 1) :color ,color))

(defun ml/setup-faces (&rest _)
  "Paint modeline faces from the active theme's palette.
Accepts &rest so it works as an `enable-theme-functions' hook."
  (modus-themes-with-colors
    (set-face-attribute 'ml/default  nil :background bg-dim        :foreground fg-main :box (ml/box bg-dim))
    (set-face-attribute 'ml/accent   nil :background bg-active     :foreground fg-main :box (ml/box bg-active))
    (set-face-attribute 'ml/dim      nil :background bg-main       :foreground fg-dim  :box (ml/box bg-main))
    (set-face-attribute 'ml/modified nil :background bg-main       :foreground red     :box (ml/box bg-main))
    (set-face-attribute 'ml/vc       nil :background bg-cyan-subtle :foreground cyan   :box (ml/box bg-cyan-subtle))))

;;; ── Segments ───────────────────────────────────────────────

(defun ml/seg (text &optional face)
  "Wrap TEXT with FACE (default ml/default)."
  (propertize (format " %s " text) 'face (or face 'ml/default)))

(defun ml/meow ()
  (when (bound-and-true-p meow-mode)
    (ml/seg (string-trim (meow-indicator)) 'ml/accent)))

(defun ml/buffer ()
  (let ((mod (cond (buffer-read-only "◊ ")
                   ((buffer-modified-p)
                    (propertize "● " 'face 'ml/modified))
                   (t ""))))
    (ml/seg (concat mod (buffer-name)))))

(defun ml/major-mode ()
  (ml/seg (format-mode-line mode-name)
          (if (bound-and-true-p eglot--managed-mode) 'ml/vc 'ml/dim)))

(defun ml/vc ()
  (when-let* ((file buffer-file-name)
              (backend (vc-backend file))
              (branch (substring-no-properties vc-mode 5)))
    (ml/seg (concat " " branch) 'ml/vc)))

(defun ml/position () (ml/seg "%l:%c" 'ml/dim))

;;; ── Time & battery ─────────────────────────────────────────

(setq display-time-default-load-average nil
      display-time-format "%H:%M"
      battery-mode-line-format "%p")
(display-time-mode 1)
(display-battery-mode 1)

(defun ml/battery () (ml/seg (concat battery-mode-line-string "%%") 'ml/dim))
(defun ml/time ()    (ml/seg display-time-string 'ml/dim))

;;; ── Assemble ───────────────────────────────────────────────

(setq-default mode-line-format
              '((:eval (ml/meow))
                (:eval (ml/buffer))
                (:eval (ml/vc))
                (:eval (ml/major-mode))
                mode-line-format-right-align
                (:eval (ml/position))
                (:eval (ml/battery))
                (:eval (ml/time))))

;;; ── Hooks ──────────────────────────────────────────────────
;; Both hooks so it works whether the theme switch comes from
;; modus-themes-rotate / ef-themes or a raw (load-theme ...).

(add-hook 'modus-themes-after-load-theme-hook #'ml/setup-faces)
(add-hook 'enable-theme-functions #'ml/setup-faces)   ; Emacs 29+
(ml/setup-faces)

(provide 'setup-modeline)
