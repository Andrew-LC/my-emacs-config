(setq gc-cons-threshold (* 50 1000 1000))

(defun zig-run-current-file ()
  "Execute `zig run` command on the current file."
  (interactive)
  (let* ((file-name (buffer-file-name))
         (command (format "zig run %s" file-name)))
    (async-shell-command command)))

(setq package-enable-at-startup nil)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


(straight-use-package 'use-package)

(cd "c://Users//Andrew")
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tooltip-mode -1)
(tool-bar-mode -1)
(setq set-fringe-mode 0)
(menu-bar-mode -1)
(column-number-mode)
(setq visible-bell 1)
(electric-pair-mode 1)
(setq use-dialog-box nil)
(setq use-short-answers t)
(setq confirm-nonexistent-file-or-buffer nil)

(global-display-line-numbers-mode t)
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook
                dired-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(set-face-attribute 'default nil :font "MonoLisa Nerd Font Mono" :height 115)

(set-frame-parameter (selected-frame) 'alpha '(98 . 98))
(add-to-list 'default-frame-alist '(alpha . (95 . 95)))

(use-package dashboard
    :straight t
    :ensure t
    :init
    (setq dashboard-center-content t)
    (setq dashboard-startup-banner "~/.emacs.d/emacs.png")
    (setq dashboard-set-heading-icons t)
    (setq dashboard-set-file-icons t)
    (setq dashboard-set-navigator t)
    (setq dashboard-items '(( recents . 5)(agenda . 5)))
    :config
    (dashboard-setup-startup-hook))

(use-package doom-themes
  :straight t
  :ensure t
  :config
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-tomorrow-night t)

  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

(use-package doom-modeline 
    :straight t
    :config (doom-modeline-mode 1))

  (use-package all-the-icons
    :straight t
    :if (display-graphic-p))

(use-package hl-line
   :straight t
   :config
   (hl-line-mode t))

(use-package highlight-indentation
    :straight t)

(use-package dired-sort-menu
    :straight t)

(add-hook 'dired-load-hook
        (lambda () (dired-sort-menu-toggle-dirs-first)))

(use-package treemacs
 :straight t
 :ensure t
 :defer t
 :config
 (progn
    (setq treemacs-collapse-dirs  (if treemacs-python-executable 3 0)
     treemacs-show-cursor   nil
    treemacs-show-hidden-files t
    )

   (treemacs-follow-mode t)
   (treemacs-filewatch-mode t)
   (treemacs-fringe-indicator-mode 'always)
  )
)

(use-package evil
    :straight t
    :init
    (setq evil-want-integration t)
    :config
    (evil-mode 1)
    (evil-set-initial-state 'messages-buffer-mode 'normal)
    (evil-set-initial-state 'dashboard-mode 'normal))

(use-package general
  :straight t
  :after evil
  :config
  (general-create-definer onepiece/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (onepiece/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(load-theme :which-key "choose theme")
    "i" '(lambda () (interactive) (find-file (expand-file-name "~/.emacs.d/init.org")))
    "d" '(lambda () (interactive) (find-file "C:/Users/Andrew/Documents/orgnotes/temp/organize_later.org"))
    "eb" '(eval-buffer :which-key "Evaluate Buffer")
    "v" '(split-window-right :which-key "Split Window Vertically")
    "." '(find-file :which-key "Search files")
    "b" '(consult-buffer :which-key "Buffer Switch")
    "o" '(lambda () (interactive) (split-window-below) (other-window 1) (dired-jump))
    "kb" '(kill-buffer :which-key "Kill Buffer")
    "pf" '(projectile-find-file :which-key "Find file using projectile")
    "f" '(consult-line :which-key "Search line")
    "z" '(lambda () (zig-run-current-file) :which-key "Execute the current zig file")
    "tv" '(treemacs :which-key "treemacs view")
    "j" '(emmet-expand-line :which-key "Emmet Expand")))

(use-package vertico
  :straight t
  :ensure t
  :bind (:map vertico-map
         ("C-j" . vertico-next)
         ("C-k" . vertico-previous)
         ("C-f" . vertico-exit)
         :map minibuffer-local-map
         ("M-h" . backward-kill-word))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package savehist
  :straight t
  :init
  (savehist-mode))

(use-package marginalia
  :straight t
  :after vertico
  :ensure t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(use-package orderless
  :straight t
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package consult
  :straight t
  :after vertico)

(use-package projectile
  :straight t
  :defer t
  :config
  (setq projectile-project-search-path '("~/Documents/projects/" "~/work/" ("~/github" . 1))))

(straight-use-package 'posframe)
(add-to-list 'load-path "~/.emacs.d/straight/build/posframe")

(use-package markdown-mode 
    :straight t)

(use-package yasnippet 
    :straight t
    :config
    (yas-global-mode 1))

  (use-package yasnippet-snippets
    :straight t)

(add-to-list 'load-path "~/.emacs.d/lsp-bridge")

(require 'lsp-bridge)
(global-lsp-bridge-mode)
(setq lsp-bridge-enable-diagnostics t)
(setq lsp-bridge-enable-hover-diagnostic t)
(setq lsp-bridge-org-babel-lang-list t)
(setq lsp-bridge-enable-auto-format-code t)

(use-package flycheck
    :straight t :config (global-flycheck-mode))

(use-package typescript-mode
   :straight t
   :mode "\\.tsx\\'"
   :config
   (setq typescript-indent-level 2))

 (use-package tide
   :straight t
   :ensure t
   :after (typescript-mode  flycheck)
   :hook ((typescript-mode . tide-setup)
          (typescript-mode . tide-hl-identifier-mode)
          (before-save . tide-format-before-save)))

 (defun setup-tide-mode ()
   (interactive)
   (tide-setup)
   (flycheck-mode +1)
   (setq flycheck-check-syntax-automatically '(save mode-enabled))
   (eldoc-mode +1)
   (tide-hl-identifier-mode +1))

 (use-package web-mode
  :straight t
  :config
  (setq web-mode-markup-indent-offset 2))

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)

(use-package zig-mode
  :straight t
  :mode "\\.zig\\'")

(defun efs/org-font-setup ()
    ;; Replace list hyphen with dot
    (font-lock-add-keywords 'org-mode
                            '(("^ *\\([-]\\) "
                               (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) ">"))))))

    ;; Set faces for heading levels
    (dolist (face '((org-level-1 . 1.5)
                    (org-level-2 . 1)
                    (org-level-3 . 1.15)
                    (org-level-4 . 1.0)
                    (org-level-5 . 1.1)
                    (org-level-6 . 1.1)
                    (org-level-7 . 1.1)
                    (org-level-8 . 1.1)))
      (set-face-attribute (car face) nil :font "MonoLisa Nerd Font Mono" :weight 'medium :height 140))

    (setq
     org-insert-heading-respect-content t
     org-tags-column 0))

(defun efs/org-mode-setup ()
       (set-fringe-mode 1)
       (setq org-hide-emphasis-markers t)
       (visual-line-mode 1)
       (org-indent-mode 1)
       (org-modern-mode 1))
  
      (straight-use-package 'org)

    (use-package org
        :straight t
        :hook (org-mode . efs/org-mode-setup)
        :config
        (setq org-default-notes-files (concat org-directory "c://Users//Andrew//Documents//orgnotes//tasks.org"))
            (efs/org-font-setup))

(use-package org-modern
    :straight t)

(use-package org-bullets
    :straight t
    :hook (org-mode . org-bullets-mode))

(use-package olivetti
 :straight t
 :hook (org-mode . olivetti-mode)
 :init
 (setq olivetti-set-width 85))

(with-eval-after-load 'org
     (org-babel-do-load-languages
         'org-babel-load-languages
         '((emacs-lisp . t)
         (python . t)))

    (push '("conf-unix" . conf-unix) org-src-lang-modes))

  
;; Automatically tangle our Emacs.org config file when we save it
  (defun efs/org-babel-tangle-config ()
    (when (string-equal (file-name-directory (buffer-file-name))
                        (expand-file-name user-emacs-directory))
      ;; Dynamic scoping to the rescue
      (let ((org-confirm-babel-evaluate nil))
        (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

(use-package emacsql
  :straight t)

(use-package emacsql-sqlite
  :straight t)

(use-package dash
  :straight t)

(use-package magit
  :straight t)

(use-package magit-section
  :straight t)

(use-package s
  :straight t)

(use-package f
  :straight t)

(use-package org-roam
   :straight t
   :ensure t
   :custom
   (org-roam-directory (file-truename "c://Users//Andrew//Documents//orgnotes"))
   :bind (("C-c n l" . org-roam-buffer-toggle)
          ("C-c n f" . org-roam-node-find)
          ("C-c n g" . org-roam-graph)
          ("C-c n i" . org-roam-node-insert)
          ("C-c n c" . org-roam-capture)
          ;; Dailies
          ("C-c n j" . org-roam-dailies-capture-today))
   :config
   ;; If you're using a vertical completion framework, you might want a more informative completion interface
   (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
   (org-roam-db-autosync-mode)
   ;; If using org-roam-protocol
   (require 'org-roam-protocol))

(use-package org-roam-ui
  :straight
    (:host github :repo "org-roam/org-roam-ui" :branch "main" :files ("*.el" "out"))
    :after org-roam
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))
