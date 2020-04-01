;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq user-full-name "Mike Mob"
      user-mail-address "mike@tarkus.dev")

;; doom
(setq doom-font (font-spec :family "monospace" :size 14))
(setq doom-theme 'doom-dracula)

;; editor
(setq display-line-numbers-type 'relative
      which-key-idle-delay 0.5)

;; org-mode
(setq org-directory "~/org/")

;; web-mode
(setq-hook! 'web-mode-hook
  web-mode-script-padding 0
  web-mode-style-padding  0)

;; indent-guides
(setq highlight-indent-guides-character ?\|)

;; search shortcuts
(map! :leader "/" #'+default/search-project)

;; dired shortcuts
(map! :n "-" #'dired-jump)
