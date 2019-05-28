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

;; Show line numbers
(setq display-line-numbers-type 'relative)
(set-face-foreground 'line-number-current-line "yellow")
(global-display-line-numbers-mode 1)
(add-hook 'after-make-frame-functions (lambda (frame) (select-frame frame) (global-display-line-numbers-mode 1)))

;; Show curent column number in mode line
(setq column-number-mode 1)

;; Don't use tabs for indentation
(setq-default indent-tabs-mode nil)

;; Show matching parentheses
(setq show-paren-delay 0)
(show-paren-mode 1)
;; Automatically insert closing parentheses
(electric-pair-mode 1)
;; Check for unbalanced parentheses in Elisp
(add-hook 'emacs-lisp-mode-hook
          (lambda() (add-hook 'after-save-hook 'check-parens nil t)))

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

;; Use Org mode
(use-package org
  :config
  ;; org-agenda
  (setq org-agenda-files (list org-directory))
  ;; org-capture
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  )

;; Use Evil
(use-package evil
  :ensure
  :config
  (evil-mode)
  ;; inform terminal about change of cursor-type
  (add-hook 'pre-command-hook 'send-cursor-type-to-terminal)
  (add-hook 'post-command-hook 'send-cursor-type-to-terminal)
  ;; show absolute line numbers in evil-insert-state
  (add-hook 'evil-insert-state-entry-hook (lambda () (setq-local display-line-numbers 1)))
  (add-hook 'evil-insert-state-exit-hook (lambda() (setq-local display-line-numbers 'relative)))
  ;; do not move cursor backwards when exiting Insert state
  (setq evil-move-cursor-back nil)
  ;; switch to motion state when entering magit-blame-mode and to normal when leaving
  (add-hook 'magit-blame-mode-hook
            (lambda()
              (if (bound-and-true-p magit-blame-mode)
                  (evil-motion-state)
                (evil-normal-state))))
  )

(use-package evil-magit
  :ensure)

(defun send-cursor-type-to-terminal ()
  (unless (display-graphic-p)
    (let ((cursor cursor-type))
      (when (consp cursor) (setq cursor (car cursor)))
      (cond ((eq cursor 'bar) (send-string-to-terminal "\e[6 q"))
            ((eq cursor 'hbar) (send-string-to-terminal "\e[4 q"))
            (t (send-string-to-terminal "\e[2 q")))
      )))

;; Week starts on Monday
(setq calendar-week-start-day 1)

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
