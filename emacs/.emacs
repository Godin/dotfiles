(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

;; Disable creation of backup~ files
(setq make-backup-files nil)
;; Disable creation of #autosave# files
(setq auto-save-default nil)

;; Disable menu bar
(menu-bar-mode -1)

;; Save history
(savehist-mode 1)

;; Save cursor position
(save-place-mode 1)

;; Enable mouse
(xterm-mouse-mode 1)
;; Enable mouse in emacsclient
(add-hook 'after-make-frame-functions (lambda(frame) (xterm-mouse-mode 1)))

;; Show tab characters and trailing spaces
(require 'whitespace)
(setq whitespace-style '(face tabs trailing))
(global-whitespace-mode 1)

;; Don't use tabs in Emacs Lisp
(add-hook 'emacs-lisp-mode-hook
          (lambda()
            (setq indent-tabs-mode nil)))

;; Show matching parentheses
(setq show-paren-delay 0)
(show-paren-mode 1)
;; Check for unbalanced parentheses
(add-hook 'after-save-hook 'check-parens)

;; Highlight line in Dired mode
(add-hook 'dired-mode-hook 'hl-line-mode)
;; Show human readable sizes
(setq dired-listing-switches "-lah")

;; Use Magit
(use-package magit
  :ensure
  :config
  ;; Show word-granularity differences within all diff hunks
  (setq magit-diff-refine-hunk 'all)
  )

;; Use files from default org-directory for org-agenda
(use-package org
  :config
  (setq org-agenda-files (list org-directory))
  )

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
