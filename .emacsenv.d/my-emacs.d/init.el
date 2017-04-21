(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "5dc0ae2d193460de979a463b907b4b2c6d2c9c4657b2e9e66b8898d2592e3de5" "98cc377af705c0f2133bb6d340bf0becd08944a588804ee655809da5d8140de6" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default)))
 '(package-selected-packages
   (quote
    (helm evil-leader evil-easymotion evil-avy jinja2-mode web-mode dashboard rainbow-delimiters ace-window projectile magit flycheck powerline company cider clojure-mode elixir-mode solarized-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;;;; ----------------------------------------------------------------
;;;; INSTALL PACKAGES
;;;; ----------------------------------------------------------------
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages
  '(better-defaults
    ein
    elpy
    flycheck
    material-theme
    py-autopep8
    cider
    solarized-theme
    elixir-mode
    company
    magit
    projectile
    clojure-mode
    ace-window
    rainbow-delimiters
    dashboard
    smex
    ido-vertical-mode
    ido-ubiquitous
    flx
    flx-ido
    all-the-icons
    ag
    web-mode
    jinja2-mode
    evil
    powerline
    powerline-evil
    evil-avy
    evil-easymotion
    evil-leader
    helm))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      my-packages)



;;;; ----------------------------------------------------------------
;;;; BASIC CONFIGURATION
;;;; ----------------------------------------------------------------
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(show-paren-mode 1)
(defalias 'yes-or-no-p 'y-or-n-p)

(set-frame-font "Ubuntu Mono 12" nil t)
(set-frame-size (selected-frame) 86 60)

(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
(ido-ubiquitous-mode 1)
(flx-ido-mode 1)

;;(helm-mode 1)

(projectile-mode)
(setq projectile-indexing-method 'native)
(setq projectile-switch-project-action 'neotree-projectile-action)
(defun neotree-project-dir ()
  "Open NeoTree using the git root."
  (interactive)
  (let ((project-dir (projectile-project-root))
        (file-name (buffer-file-name)))
    (neotree-toggle)
    (if project-dir
        (if (neo-global--window-exists-p)
            (progn
              (neotree-dir project-dir)
              (neotree-find file-name)))
      (message "Could not find git project root."))))
;;(global-set-key [f8] 'neotree-project-dir)

(setq neo-smart-open t)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(global-set-key [f8] 'neotree-toggle)

(unless window-system (setq linum-format "%d "))

(load-theme 'solarized-dark)
;;(load-theme 'solarized-light)
;;(load-theme 'material-light)
;;(load-theme 'material)

(global-set-key "\M- " 'hippie-expand)

(global-set-key (kbd "M-p") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

;;(setq dashboard-banner-logo-title nil)
;;setq dashboard-startup-banner nil)
;;require 'dashboard)
;;dashboard-setup-startup-hook)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c") 'smex)

;;(global-set-key (kbd "C-;") 'avy-goto-char)
;;(global-set-key (kbd "C-'") 'avy-goto-char-2)
;;(global-set-key (kbd "M-g f") 'avy-goto-line)
;;(evilem-default-keybindings "SPC")


;;;; ----------------------------------------------------------------
;;;; EVIL POWERLINE 
;;;; ----------------------------------------------------------------

;;(powerline-evil-center-color-theme)

(powerline-evil-vim-color-theme)

(custom-theme-set-faces 'solarized-dark '(powerline-evil-base-face
               ((t (:foreground "#eee8d5" :inherit mode-line)))
                                          :group powerline))

(custom-theme-set-faces 'solarized-dark '(powerline-evil-normal-face
               ((t (:background "#859900" :inherit powerline-evil-base-face)))
                                          :group powerline))

(custom-theme-set-faces 'solarized-dark '(powerline-evil-insert-face
               ((t (:background "#268bd2" :inherit powerline-evil-base-face)))
                                          :group powerline))

(custom-theme-set-faces 'solarized-dark '(powerline-evil-visual-face
               ((t (:background "#cb4b16" :inherit powerline-evil-base-face)))
                                          :group powerline))

(custom-theme-set-faces 'solarized-dark '(powerline-evil-operator-face
               ((t (:background "#2aa198" :inherit powerline-evil-base-face)))
                                          :group powerline))

(custom-theme-set-faces 'solarized-dark '(powerline-evil-replace-face
               ((t (:background "#dc332f" :inherit powerline-evil-base-face)))
                                          :group powerline))

(custom-theme-set-faces 'solarized-dark '(powerline-evil-motion-face
               ((t (:background "#d33682" :inherit powerline-evil-base-face)))
                                          :group powerline))



;;;; ----------------------------------------------------------------
;;;; EVIL  LEADER
;;;; ----------------------------------------------------------------

(global-evil-leader-mode)

(evil-leader/set-leader "<SPC>")

(evil-leader/set-key
  "e" 'find-file
  "s" 'save-buffer
  "b" 'switch-to-buffer
  "k" 'kill-buffer
  "o" 'ace-window
  "p" 'projectile-find-file
  "x" 'execute-extended-command)

(evil-leader/set-key-for-mode 'emacs-lisp-mode "b" 'byte-compile-file)



;;;; ----------------------------------------------------------------
;;;; EVIL 
;;;; evil-leader, evil-magit,
;;;; evil-surround, evil-org, evil-multiedit, evil-paredit,
;;;; evil-tabs, evil-lisp-mode
;;;; ----------------------------------------------------------------

(evil-mode 1)
(evil-avy-mode)
(evil-set-initial-state 'term-mode 'emacs) 
(evil-set-initial-state 'slime-repl-mode 'emacs) 
(evil-set-initial-state 'lisp-interaction-mode 'emacs) 




;;;; ----------------------------------------------------------------
;;;; COMPANY MODE
;;;;
;;;;   M-n and M-p to select, <return> to complete
;;;;   or <tab> to complete the common part.
;;;;   Search through the completions with C-s, C-r and C-o.
;;;;   Press M-(digit) to quickly complete with one of the first 10 candidates.
;;;;   Type M-x company-complete or M-/ to initiate completion manually.
;;;;   Press <f1> to display the documentation
;;;;   C-w to display source code
;;;;   For more information, type M-x describe-function RET company-mode.
;;;;
;;;; ----------------------------------------------------------------

;;(defun my-company-mode-key-bindings ()
;;  "Modify keymap used in Company Mode."
;;  (local-set-key (kbd "C-?") 'company-complete))

;;(add-hook 'after-init-hook 'global-company-mode)  ;all modes
(eval-after-load "company"
 '(add-to-list 'company-backends 'company-anaconda))



;;;; ----------------------------------------------------------------
;;;; FLYCHECK
;;;;
;;;;   pip install flaske8 and pylint
;;;;   C-c ! n and C-c ! p you can now jump back and forth 
;;;;   C-c ! l to pop up a list of all errors
;;;;
;;;; ----------------------------------------------------------------

;;(add-hook 'after-init-hook #'global-flycheck-mode)



;;;; ----------------------------------------------------------------
;;;; COMMON LISP
;;;; ----------------------------------------------------------------

(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "sbcl")



;;;; ----------------------------------------------------------------
;;;; EMACS LISP
;;;; ----------------------------------------------------------------

(add-hook 'emacs-lisp-mode-hook 'company-mode)
;;(add-hook 'emacs-lisp-mode-hook 'my-company-mode-key-bindings)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)



;;;; ----------------------------------------------------------------
;;;; PYTHON
;;;;
;;;; pip install jedi flake8 importmagic autopep8
;;;;
;;;; ----------------------------------------------------------------

(elpy-enable)
(elpy-use-ipython)
(setq python-shell-interpreter "ipython"
    python-shell-interpreter-args "--simple-prompt -i")

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(add-hook 'elpy-mode-hook 'linum-mode)


;;;; ----------------------------------------------------------------
;;;; WEB DEVELOPMENT
;;;; ----------------------------------------------------------------

(add-to-list 'auto-mode-alist '("\\.jinja2\\'" . jinja2-mode))

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))




;;;; ----------------------------------------------------------------
;;;; TODO:
;;;;     magit, paredit, minimap
;;;;     erlang, elixir, haskell, clojure, c/c++, ruby, lisp
;;;; ----------------------------------------------------------------
