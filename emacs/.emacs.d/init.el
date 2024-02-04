(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

;;(menu-bar-mode -1)            ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)

(set-face-attribute 'default nil :height 180)

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

(use-package beacon
  :init
  (beacon-mode 1))

(use-package company)

(add-hook 'after-init-hook 'global-company-mode)

(use-package avy)

(global-set-key (kbd "C-:") 'avy-goto-char)

(use-package which-key)

(which-key-mode)

(use-package amx)

(use-package dired
  :ensure nil)

(use-package php-mode)
