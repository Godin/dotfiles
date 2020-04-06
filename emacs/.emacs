(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(setq package-archive-priorities
      '(("melpa-stable" . 1)))

(package-initialize)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

;; Save interactive customizations in separate file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

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

;; Don't use tabs for indentation by default
(setq-default indent-tabs-mode nil)

(setq-default tab-width 4)

(setq js-indent-level 2)

(defun toggle-indentation-style ()
  (interactive)
  (setq indent-tabs-mode (if (eq indent-tabs-mode t) nil t))
  (message "Indenting using %s" (if (eq indent-tabs-mode t) "tabs" "spaces"))
  )

(defun infer-indent-tabs-mode ()
  (let ((space-count (how-many "^  " (point-min) (point-max)))
        (tab-count (how-many "^\t" (point-min) (point-max))))
    (if (> space-count tab-count) (setq indent-tabs-mode nil))
    (if (> tab-count space-count) (setq indent-tabs-mode t)))
  )
(add-hook 'prog-mode-hook 'infer-indent-tabs-mode)

;; Show matching parentheses
(setq show-paren-delay 0)
(show-paren-mode 1)
;; Automatically insert closing parentheses
(electric-pair-mode 1)
;; Check for unbalanced parentheses in Elisp
(add-hook 'emacs-lisp-mode-hook
          (lambda() (add-hook 'after-save-hook 'check-parens nil t)))

;; Highlight TODOs
(defun highlight-todos ()
  (font-lock-add-keywords nil '(("\\<\\(FIXME\\|TODO\\|WIP\\)" 1 '(:background "red") t))))
(add-hook 'prog-mode-hook 'highlight-todos)
(add-hook 'nxml-mode-hook 'highlight-todos)

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
  ;; Show local branches in status
  (magit-add-section-hook 'magit-status-sections-hook 'magit-insert-local-branches :appent t)
  ;; Use same colors as in Git
  (setq magit-diff-highlight-hunk-body nil)
  (set-face-attribute 'magit-diff-added nil :foreground "green" :background 'unspecified)
  (set-face-attribute 'magit-diff-removed nil :foreground "red" :background 'unspecified)
  (set-face-attribute 'diff-added nil :foreground "green" :background 'unspecified)
  (set-face-attribute 'diff-removed nil :foreground "red" :background 'unspecified)
  (set-face-attribute 'diff-refine-added nil :foreground "black" :background "green")
  (set-face-attribute 'diff-refine-removed nil :foreground "black" :background "red")
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

;; Email client
(use-package wl
  :ensure wanderlust
  :config
  (setq
   wl-folder-desktop-name "Emails"
   wl-summary-width nil
   wl-message-ignored-field-list '("^.*:")
   wl-message-visible-field-list '("^From:" "^To:" "^Cc:" "^Bcc:" "^Subject:")
   )
  (add-hook 'wl-folder-mode-hook 'evil-emacs-state)
  (add-to-list 'evil-emacs-state-modes 'wl-summary-mode)
  (add-hook
   'wl-summary-mode-hook
   '(lambda ()
      (hl-line-mode t)
      (local-set-key "j" 'wl-summary-next)
      (local-set-key "k" 'wl-summary-prev)
      (local-set-key "D"
                     (lambda () (interactive) (wl-thread-delete t)))
;;                     'wl-thread-delete)
      ))
  )

;; Syntax highlighting for CMake files
(use-package cmake-mode
  :ensure)

;; Don't indent members of C++ namespaces
(add-hook 'c++-mode-hook
          (lambda ()
            (c-set-offset 'innamespace 0)
            ))

;; Syntax highlighting for Gradle Groovy scripts
(use-package groovy-mode
  :ensure)

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
