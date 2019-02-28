;; Disable creation of backup~ files
(setq make-backup-files nil)
;; Disable creation of #autosave# files
(setq auto-save-default nil)

;; Disable menu bar
(menu-bar-mode -1)

;; Save history
(savehist-mode 1)

;; Enable mouse
(xterm-mouse-mode 1)

;; Show tab characters and trailing spaces
(require 'whitespace)
(setq whitespace-style '(face tabs trailing))
(global-whitespace-mode 1)

;; Show matching parentheses
(setq show-paren-delay 0)
(show-paren-mode 1)

;; Highlight line in Dired mode
(add-hook 'dired-mode-hook 'hl-line-mode)

;; Decompile class files
(defun javap ()
  (erase-buffer)
  (call-process "javap" nil t nil "-v" "-p" buffer-file-name)
  (set-buffer-modified-p nil)
  (setq buffer-read-only t))

(add-hook 'find-file-hook
          (lambda ()
            (if (string= "class" (file-name-extension buffer-file-name))
                (javap))))
