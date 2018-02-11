(set-language-environment "UTF-8")
                                        ; (setq inhibit-startup-message t) ; Disable startup message
(setq ring-bell-function 'ignore) ; Disable error tone

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ; Smoother scrolling
(setq scroll-step 1) ;; ^

(setq user-full-name "Ahmed Mohamed"
      user-mail-address "ahmed02mohamed@outlook.com")

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

(setq tramp-default-method "ssh")

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq gc-cons-threshold 10000000)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(linum-mode 1)

(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))
(global-set-key (kbd "\C-c \c") 'close-all-buffers)

(setq frame-title-format
      '("" invocation-name ": "(:eval (if (buffer-file-name)
                                          (abbreviate-file-name (buffer-file-name))
                                        "%b"))))

(global-set-key (kbd "C-c f") 'neotree-toggle)
(add-hook 'org-mode-hook
          (lambda () (local-set-key (kbd "C-c C-c") 'org-capture)
            (local-set-key (kbd "C-c d") 'org-drill)))

(setq org-log-done 'time)

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

(setq org-agenda-files (list "~/.config/org/general.org"))

(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-x\C-k" 'kill-some-buffers)

(setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 5)))

(defalias 'yes-or-no-p 'y-or-n-p)

(setq default-tab-width 4)
(setq c-basic-offset 4)
(defun untabify-except-makefiles ()
  "Replace tabs with spaces except in makefiles."
  (unless (derived-mode-p 'makefile-mode)
    (untabify (point-min) (point-max))))

(add-hook 'before-save-hook 'untabify-except-makefiles)
                                        ; (load-file "~/.emacs.d/elcord.el")
(setq base16-distinct-fringe-background nil)

(setq org-capture-templates
 '(("c" "chem" entry
      (file "~/org/notes.org")
      "* <[%^{Name}]> :drill:
    :PROPERTIES:
    :DRILL_CARD_TYPE: twosided
    :END:
*** Name
- %^{Name}
*** Formula
- %^{Formula}" :jump-to-captured t)))
;;--------------------------------------------------------------------------

(package-initialize)
(require 'package)
(setq package-enable-at-startup nil)

(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives
               '("melpa" . "https://melpa.org/packages/") t))

(unless (assoc-default "org" package-archives)
  (add-to-list 'package-archives
               '("org" . "http://orgmode.org/elpa/") t))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; (use-package dash)

                                        ; Try a package without installing it
(use-package try
  :ensure t)

                                        ; Panel that shows possible completions of failed shortcut attempts
(use-package which-key
  :ensure t
  :config (which-key-mode))

;; (use-package gruvbox-theme
;;   :ensure t
;;   :config (defun load-gruvbox-theme (frame)
;;             (select-frame frame)
;;             (load-theme 'gruvbox-dark-medium t))
;;   (if (daemonp)
;;     (add-hook 'after-make-frame-functions #'load-gruvbox-theme)
;;     (load-theme 'gruvbox-dark-medium t)))

;; (set-frame-parameter nil 'background-mode 'light)
;; (use-package github-modern-theme
;;   :ensure t
;;   :config (defun load-github-theme (frame)
;;             (select-frame frame)
;;             (load-theme 'github-modern t))
;;   (if (daemonp)
;;       (add-hook 'after-make-frame-functions #'load-github-theme)
;;     (load-theme 'github-modern t)))

(use-package base16-theme
  :ensure t
  :config
  (load-theme 'base16-default-dark t))
                                        ; Emacs vim mode
(use-package evil
  :init (evil-mode +1)
  :ensure t
  :config (progn
            (evil-set-initial-state 'magit-pop-mode 'emacs)
            (evil-set-initial-state 'magit-blamde-mode 'emacs)
            (evil-set-initial-state 'notmuch-tree-mode 'emacs)
            (evil-set-initial-state 'gnu-apl-mode 'emacs)
            (evil-set-initial-state 'gnu-apl-interactive-mode 'emacs)))

(use-package swiper
  :ensure t
  :bind ("C-s" . swiper))

                                        ; Forces Ivy completion
(use-package counsel
  :ensure t
  :bind
  ("<f1> f" . counsel-describe-function)
  ("<f1> v" . counsel-describe-variable)
  ("<f1> l" . counsel-find-library)
  ("<f2> i" . counsel-info-lookup-symbol)
  ("<f2> u" . counsel-unicode-char)
  ("C-c g" . counsel-git)
  ("C-c j" . counsel-git-grep)
  ("C-c k" . counsel-ag)
  ("C-x l" . counsel-locate))

                                        ; Completion Mechanism
(use-package ivy
  :ensure t
  :config (setq ivy-use-virual-buffers t)
  :bind
  ("C-c C-r" . ivy-resume)
  ("<f6>" . ivy-resume)
  ("C-x b" . ivy-switch-buffer))

(use-package counsel-projectile
  :ensure t)

(use-package page-break-lines
  :ensure t
  :config (turn-on-page-break-lines-mode))

(use-package helm
  :ensure t
  :diminish helm-mode
  :commands helm-mode
  :config
  (helm-mode 1)
  (setq helm-buffers-fuzzy-matching t)
  (setq helm-autoresize-mode t)
  (setq helm-buffer-max-length 100)
  (define-key helm-map (kbd "S-SPC") 'helm-toggle-visible-mark)
  :bind
  ("M-x" . 'helm-M-x)
  ("\C-x\C-f" . 'helm-find-files))

;(global-set-key (kbd "M-x") 'helm-M-x)

(use-package dashboard
  :ensure t
  :config (dashboard-setup-startup-hook))
                                        ; Recent files
(use-package recentf
  :ensure t
  :config
  (setq recentf-max-saved-items 100
        recentf-max-menu-items 15
        recentf-auto-cleanup 'never)
  (recentf-mode 1)
  :bind ("C-x C-r" . recentf-open-files))

(use-package company
  :ensure t
  :defer t
  :init (global-company-mode)
  :config
  (setq company-idle-delay 0.2)
  (setq company-minimum-prefix-length 2)
  (progn
    (bind-key [remap completion-at-point] #'company-complete company-mode-map)
    (setq company-tooltip-align-annotations t
          company-show-numbers t)
    (setq company-dabbrev-downcase nil))
  :diminish company-mode)

(use-package company-quickhelp
  :ensure t
  :defer t
  :init (add-hook 'global-company-mode-hook #'company-quickhelp-mode))

(use-package projectile
  :ensure t
  :commands (projectile-find-file projectile-switch-project)
  :diminish projectile-mode
  :config
  (projectile-global-mode))

                                        ; Auto parenthesis
(use-package smartparens
  :ensure t
  :config
  (progn
    (require 'smartparens-config))
  :bind ("C-x p" . smartparens-mode))

;; Parentheses change color depending on depth
(use-package rainbow-delimiters
  :ensure t
  :defer t
  :init
  (progn
    (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode))
  :bind ("C-x j" . rainbow-delimiters-mode))

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(use-package exec-path-from-shell
  :ensure t
  :config (when (memq window-system '(mac ns x))
            (exec-path-from-shell-initialize)))

(use-package async
  :init (dired-async-mode +1)
  :ensure t
  :config (progn
            (async-bytecomp-package-mode 1)))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package org
  :mode (("\\.org$" . org-mode))
  :ensure org-plus-contrib
  :config (progn
            (add-to-list 'org-modules 'org-drill)
            (setq org-drill-left-cloze-delimiter "<[")
            (setq org-drill-right-cloze-delimiter "]>")
            (setq org-drill-learn-fraction 0.25)))

(use-package org-bullets
  :ensure t
  :config
  (progn
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
    ))

                                        ; Adds clang formatting support
(use-package clang-format
  :ensure t)

                                        ; Adds toml support
(use-package toml-mode
  :ensure t)

(use-package ix
  :ensure t)

(use-package neotree
  :ensure t)

(use-package yaml-mode
  :ensure t)

(use-package latex-preview-pane
  :ensure t)

;; (use-package tuareg
;;  :ensure t)

;; Setup environment variables using opam
;; (dolist (var (car (read-from-string (shell-command-to-string "opam config env --sexp"))))
;;  (setenv (car var) (cadr var)))

;; (use-package merlin
;;  :config
;;  (bind-keys :map merlin-mode-map
;;             ("M-." . merlin-locate)
;;             ("M-," . merlin-pop-stack))
  ;; Start merlin on ocaml files
;;  (add-hook 'tuareg-mode-hook 'merlin-mode t)
;;  (add-hook 'caml-mode-hook 'merlin-mode t)
  ;; Use opam switch to lookup ocamlmerlin binary
;;  (setq merlin-command 'opam)
;;  :ensure t)

;; (use-package utop
;;  :config
;;  (add-hook 'tuareg-mode-hook 'utop-minor-mode)
;;  :ensure t)

;; (use-package ocp-indent
;;  :ensure t)

;; (use-package ox-twbs
;;  :ensure t)

(use-package company-math
  :config
  ;; global activation of the unicode symbol completion
  (add-to-list 'company-backends 'company-math-symbols-unicode)
  ;; local configuration for TeX modes
  (defun my/latex-mode-setup ()
    (setq-local company-backends
                (append '(company-math-symbols-latex company-latex-commands)
                        company-backends)))

  (add-hook 'TeX-mode-hook 'my/latex-mode-setup)
  :ensure t)

(use-package multiple-cursors
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)
         ("C-c C->" . mc/mark-more-like-this-extended))
  :ensure t)

(use-package move-text
  :bind (("<C-M-up>" . move-text-up)
         ("<C-M-down>" . move-text-down))
  :ensure t)

(use-package haskell-mode
  :ensure t)

(use-package hindent
  :ensure t
  :config
  (add-hook 'haskell-mode-hook #'hindent-mode))

(use-package ebib
  :ensure t)

(use-package vlf
  :ensure t
  :config
  (setq vlf-batch-size 10240)
  (setq vlf-application 'dont-ask))

(use-package rtags
  :ensure t
  :config
  (setq rtags-completions-enabled t)
  (eval-after-load 'company
    '(add-to-list
      'company-backends 'company-rtags))
  (setq rtags-autostart-diagnostics t)
  (rtags-enable-standard-keybindings))

(use-package flycheck
  :ensure t
  :config
  (add-hook 'c++-mode-hook 'flycheck-mode)
  (add-hook 'c-mode-hook 'flycheck-mode))

(use-package flycheck-rtags
  :ensure t
  :config
  (defun my-flycheck-rtags-setup ()
    (flycheck-select-checker 'rtags)
    (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
    (setq-local flycheck-check-syntax-automatically nil))
  ;; c-mode-common-hook is also called by c++-mode
  (add-hook 'c-mode-common-hook #'my-flycheck-rtags-setup))

(use-package flycheck-irony
  :ensure t
  :config
  (eval-after-load 'flycheck
    '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup)))

(use-package auto-complete-clang
  :ensure t)

(use-package company-irony
  :ensure t
  :config
  (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
  (setq company-backends (delete 'company-semantic company-backends))
  (eval-after-load 'company
    '(add-to-list
      'company-backends 'company-irony)))

(use-package smart-mode-line-powerline-theme
  :ensure t)

(use-package smart-mode-line
  :ensure t
  :config
  (setq sml/no-confirm-load-theme t)
  (setq sml/theme 'powerline)
  (sml/setup))

(use-package irony
  :ensure t
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)

  (defun my-irony-mode-hook ()
    (define-key irony-mode-map [remap completion-at-point]
      'irony-completion-at-point-async)
    (define-key irony-mode-map [remap complete-symbol]
      'irony-completion-at-point-async))
  (add-hook 'irony-mode-hook 'my-irony-mode-hook)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(use-package company-irony-c-headers
  :ensure t
  :config
  (eval-after-load 'company
    '(add-to-list
      'company-backends 'company-irony))
  (require 'company-irony-c-headers)
  (eval-after-load 'company
    '(add-to-list
      'company-backends '(company-irony-c-headers company-irony))))

(use-package cmake-ide
  :ensure t)

(cmake-ide-setup)

(add-hook 'c++-mode-hook
          (lambda () (local-set-key (kbd "C-c b") #'cmake-ide-compile)))

(require 'ox-latex)
(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))
(add-to-list 'org-latex-classes
             '("article"
               "\\documentclass{article}"
               ("\\section{%s}" . "\\section*{%s}")))

(custom-theme-set-faces
 'base16-default-dark
 `(fringe ((t (:background, (plist-get base16-default-dark-colors :base00))))))

(custom-set-faces
 '(default ((t (:inherit nil :stipple nil :background "#181818" :foreground "#d8d8d8" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 135 :width normal :foundry "unknown" :family "Fira Mono")))))
