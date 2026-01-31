;; -*- lexical-binding: t; -*-
;; setup-modeline.el - Tabbed modeline with modus-themes integration

(setq display-time-default-load-average nil)
(setq display-time-format "%H:%M")
(setq battery-mode-line-format "%p")
(display-time-mode 1)
(display-battery-mode 1)

(defface my/modeline-segment
  '((t :inherit mode-line))
  "Primary modeline segments.")

(defface my/modeline-segment-accent
  '((t :inherit mode-line-emphasis))
  "Accented modeline segments.")

(defface my/modeline-segment-dim
  '((t :inherit shadow))
  "Dimmed modeline segments.")

(defface my/modeline-vc
  '((t :inherit success))
  "VC branch.")

(defface my/modeline-modified
  '((t :inherit warning))
  "Modified indicator.")

(defface my/modeline-eglot
  '((t :inherit success))
  "Eglot indicator.")

;;; Theme Integration

(defun my/modeline-setup-faces ()
  "Setup modeline faces using current modus/ef theme colors."
  (modus-themes-with-colors
    ;; Primäre Segmente (Buffer, Mode)
    (set-face-attribute 'my/modeline-segment nil
                        :background bg-dim
                        :foreground fg-main
                        :box `(:line-width (3 . 1) :color ,bg-dim))
    
    ;; Active/wichtige Segmente  
    (set-face-attribute 'my/modeline-segment-accent nil
                        :background bg-active
                        :foreground fg-main
                        :weight 'semibold
                        :box `(:line-width (3 . 1) :color ,bg-active))
    
    ;; Dim Segmente (Position, Zeit)
    (set-face-attribute 'my/modeline-segment-dim nil
                        :background bg-main
                        :foreground fg-dim
                        :box `(:line-width (3 . 1) :color ,bg-main))
    
    ;; VC Branch
    (set-face-attribute 'my/modeline-vc nil
                        :background bg-blue-subtle
                        :foreground cyan
                        :box `(:line-width (3 . 1) :color ,bg-cyan-subtle))
    
    (set-face-attribute 'my/modeline-modified nil
                        :foreground red-warmer)
    
    (set-face-attribute 'my/modeline-eglot nil
                        :background bg-added-faint
                        :foreground fg-added
                        :box `(:line-width (3 . 1) :color ,bg-green-subtle))))

;;; Segment Helper

(defun my/ml-segment (content &optional face)
  "Wrap CONTENT as modeline segment with optional FACE."
  (let ((f (or face 'my/modeline-segment)))
    (propertize (concat " " content " ") 'face f)))

;;; Segments - alle separat

(defun my/ml-meow ()
  "Meow state."
  (when (bound-and-true-p meow-mode)
    (my/ml-segment (string-trim (meow-indicator)) 'my/modeline-segment-accent)))

(defun my/ml-buffer ()
  "Buffer name with modified/readonly indicator."
  (let* ((mod (cond (buffer-read-only
                     (propertize 'face 'my/modeline-segment-dim))
                    ((buffer-modified-p)
                     (propertize "● " 'face 'my/modeline-modified))
                    (t "")))
         (name (buffer-name)))
    (my/ml-segment (concat mod name))))

(defun my/ml-major-mode ()
  "Major mode, colored if Eglot is active."
  (let ((face (if (bound-and-true-p eglot--managed-mode)
                  'my/modeline-eglot      
                'my/modeline-segment-dim))) 
    (my/ml-segment mode-name face)))

(defun my/ml-vc ()
  "VC branch."
  (when-let* ((backend (vc-backend buffer-file-name))
              (branch (substring-no-properties vc-mode 5)))
    (my/ml-segment (concat " " branch) 'my/modeline-vc)))

(defun my/ml-minor-modes ()
  "Active minor modes."
  (my/ml-segment (concat "(" (format-mode-line minor-mode-alist) " )") 'my/modeline-segment-dim))

(defun my/ml-position ()
  "Cursor position."
  (my/ml-segment "%l:%c" 'my/modeline-segment-dim))

(defun my/ml-battery ()
  "Battery."
  (my/ml-segment (concat battery-mode-line-string "%%") 'my/modeline-segment-dim))

(defun my/ml-time ()
  "Time."
  (my/ml-segment (concat " " display-time-string) 'my/modeline-segment-dim))
(setq-default mode-line-format
	      '((:eval (my/ml-meow))
		(:eval (my/ml-buffer))
		(:eval (my/ml-vc))
		(:eval (my/ml-major-mode))
		(:eval (my/ml-minor-modes))
		mode-line-format-right-align
		(:eval (my/ml-position))
		(:eval (my/ml-battery))
		(:eval (my/ml-time))))

(defun my/modeline-refresh ()
  "Refresh modeline faces after theme change."
  (my/modeline-setup-faces)
  (force-mode-line-update t))

(add-hook 'modus-themes-after-load-theme-hook #'my/modeline-refresh)
(add-hook 'ef-themes-post-load-hook #'my/modeline-refresh)
(add-hook 'after-init-hook #'my/modeline-setup-faces)

(provide 'setup-modeline)
