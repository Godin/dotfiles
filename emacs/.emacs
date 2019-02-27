; Disable creation of backup~ files
(setq make-backup-files nil)
; Disable creation of #autosave# files
(setq auto-save-default nil)

; Save history
(savehist-mode 1)

; Enable mouse
(xterm-mouse-mode 1)

; Decompile class files
(defun javap ()
  (erase-buffer)
  (call-process "javap" nil t nil "-v" "-p" buffer-file-name)
  (set-buffer-modified-p nil)
  (setq buffer-read-only t))

(add-hook 'find-file-hook
          (lambda ()
            (if (string= "class" (file-name-extension buffer-file-name))
                (javap))))
