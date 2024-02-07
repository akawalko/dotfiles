(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

;;(menu-bar-mode -1)            ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)

(set-face-attribute 'default nil :height 170)

(load-theme 'wombat)

;; Display line numbers
;; (global-display-line-numbers-mode 1)
(display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;(add-to-list 'load-path "~/.emacs.d/elpa/madhat2r-theme-20170203.30")


;(require 'madhat2r)
;(load-theme 'madhat2r t)

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;(use-package madhat2r
;  (load-theme 'madhat2r t))

;(use-package vertico
;  :ensure t
;  :bind (:map vertico-map
;         ("C-j" . vertico-next)
;         ("C-k" . vertico-previous)
;         ("C-f" . vertico-exit)
;         :map minibuffer-local-map
;         ("M-h" . backward-kill-word))
;  :custom
;  (vertico-cycle t)
;  :init
;  (vertico-mode))

;(use-package savehist
;  :init
;  (savehist-mode))

;(use-package marginalia
;  :after vertico
;  :ensure t
;  :custom
;  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
;  :init
;  (marginalia-mode))

;; Instead Vertico there is more feature rich alternative called Ivy
(use-package ivy
;  :diminish
  :bind (
;         ("C-s" . swiper)
         :map ivy-minibuffer-map
	  ("TAB" . ivy-alt-done)       
          ("C-l" . ivy-alt-done)
          ("C-j" . ivy-next-line)
          ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
          ("C-j" . ivy-next-line)
          ("C-k" . ivy-previous-line)
          ("C-l" . ivy-done)
;         ("C-d" . ivy-switch-buffer-kill)
;         :map ivy-reverse-i-search-map
;         ("C-k" . ivy-previous-line)
;         ("C-d" . ivy-reverse-i-search-kill))
	  )
  :config
  (ivy-mode 1))

(use-package counsel)
;; (keymap-global-set "C-x b" 'counsel-switch-buffer)

(use-package counsel-etags)

(use-package beacon
  :init
  (beacon-mode 1))

(use-package company)
(add-hook 'after-init-hook 'global-company-mode)

(use-package company-statistics)
(add-hook 'after-init-hook 'company-statistics-mode)

(use-package avy)

(global-set-key (kbd "C-:") 'avy-goto-char)

(use-package ace-window
  :bind ("M-p" . ace-window)
  :delight
  :config (ace-window-display-mode 1))

;; maybe try window-numbering

(use-package which-key)

(which-key-mode)

(use-package projectile)

(use-package dashboard
  :preface
  (defun ajk/dashboard-banner ()
    "Set a dashboard banner including information on package initialization
  time and garbage collections."
    (setq dashboard-banner-logo-title
          (format "Emacs ready in %.2f seconds with %d garbage collections."
                  (float-time (time-subtract after-init-time before-init-time)) gcs-done)))
  :config
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 5)
                        (registers . 5)))
  ;;(setq dashboard-banner-logo-title "Welcome to Emacs Dashboard")
  (setq dashboard-banner-logo-title nil)
  ;;(setq dashboard-init-info "I use Emacs, which might be thought of as a thermonuclear word processor.' - Neal Stephenson")
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-center-content t)
  :hook ((after-init     . dashboard-refresh-buffer)
         ;;(dashboard-mode . ajk/dashboard-banner)
	 )
  
  (dashboard-setup-startup-hook)
)

(use-package amx)

(use-package dired
  :ensure nil)

(use-package php-mode)

;;company-php
(setq programming-packages '(lsp-mode yasnippet lsp-treemacs lsp-ui lsp-ivy flycheck company-php ac-php ac-php-core dap-mode phpactor))

(when (cl-find-if-not #'package-installed-p programming-packages)
  (package-refresh-contents)
  (mapc #'package-install programming-packages))

(add-hook 'php-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast

(use-package lsp-mode
  :commands (lsp lsp-deferred)
;;  :hook (lsp-mode . efs/lsp-mode-setup)
  :config
  (setq lsp-clients-php-server-command "/home/arkadiusz/.emacs.d/elpa/phpactor-20221023.608/")
  (setq lsp-phpactor-path "/home/arkadiusz/.emacs.d/elpa/phpactor-20221023.608/phpactor")
  (setq lsp-enabled-clients '(phpactor))
  (setq lsp-disabled-clients '(php-ls iph intelephense serenata))
  (lsp-enable-which-key-integration t)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
)


(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-php)
  (yas-global-mode))

  ;; (add-hook 'php-mode-hook
  ;;           '(lambda ()
  ;;              (auto-complete-mode t)
  ;;              (require 'ac-php)
  ;;              (setq ac-sources '(ac-source-php))
  ;;              (yas-global-mode 1)

  ;;              (define-key php-mode-map (kbd "C-]")
  ;;                'ac-php-find-symbol-at-point)
  ;;              (define-key php-mode-map (kbd "C-t")
  ;;                'ac-php-location-stack-back)))


(use-package lsp-ui
  :ensure t
  :requires flycheck
  :after lsp-mode
  :config
  (setq
   lsp-ui-doc-enable t
   lsp-ui-doc-use-childframe t
   lsp-ui-doc-position 'top
   lsp-ui-doc-include-signature t

   lsp-ui-flycheck-enable t
   lsp-ui-flycheck-list-position 'right
   lsp-ui-flycheck-live-reporting t

   lsp-ui-imenu-enable t

   lsp-ui-peek-enable t
   lsp-ui-peek-list-width 60
   lsp-ui-peek-peek-height 25

   lsp-ui-sideline-enable t
   lsp-ui-sideline-update-mode 'line
   lsp-ui-sideline-show-code-actions t
   lsp-ui-sideline-show-hover nil)

  :bind
  (:map lsp-ui-mode-map
	("C-c C-j" . lsp-ui-peek-find-definitions)
	("C-c i"   . lsp-ui-peek-find-implementation)
	("C-c m"   . lsp-ui-imenu))

  :hook
  (lsp-mode . lsp-ui-mode))


(setq phpactor-executable "/home/arkadiusz/.emacs.d/elpa/phpactor-20221023.608/phpactor")

;; packages to try:
;; - paradox,
;; - mmm-mode
;; - restclient,
;; - js2-mode,
;; - expand-region (works like C-w in PhpStorm)
;; - general
;; - helpful
;; - dashboard
;; - web-mode
;; - yaml-mode
;; - indent-guide
;; - visual-regexp
;; - visual-regexp-steroids.el
;; - evil-leade
;; - zencoding-mode
;; - iedit
;; - deadgrep
;; - switch-window
;; - persp-mode.el or perspective-el
;; - company-quickhelp
;; - emojify
;; - easy-kill
;; - counsel-projectil
;; - multi-web-mode
;; - bm
;; - ws-butler
;; - auto-yasnippet
;; - modalka
;; - rg
;; - company-prescient
;; - ivy-prescient
;; - prescient
;; - string-inflection
;; - symbol-overlay
;; - mark-multiple
;; - yafolding
;; - wrap-region
;; - elmacro
;; - composable
;; - diminish
;; - simpleclip
;; - ethan-wspace
;; - phi-search
;; - swoop
;; - whitespace-clean
;; - ace-isearch
;; - persp-projectile
;; - corral
;; - frames-only-mode
;; - move-text

;; something disabled this, so I reintroduce this symbol/variable
(setq xref-auto-jump-to-first-xref t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ace-window-posframe-mode t nil (ace-window))
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(counsel-etags dashboard emacs-dashboard paradox company-statistics projectile company-php phpactor php-mode ac-php lsp-treemacs lsp-mode yasnippet which-key use-package magit lsp-ui lsp-ivy flycheck dap-mode counsel company beacon amx ac-php-core))
 '(paradox-github-token t)
 '(projectile-mode t nil (projectile)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
