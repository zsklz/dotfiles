;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; (setq user-full-name "John Doe"
;;      user-mail-address "john@doe.com")

(setq doom-font "Iosevka-16")

(setq doom-theme 'modus-vivendi)
(setq display-line-numbers-type t)

(setq org-directory "~/Org/")
(setq org-roam-directory (file-truename "~/Org/roam"))

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(add-hook! 'elfeed-search-mode-hook #'elfeed-update)

; org stuff
(after! org
 (add-to-list 'org-modules 'org-habit)
 (setq org-checkbox-hierarchical-statistics nil)
 (setq org-todo-keywords
        '((sequence
           "TODO(t)"
           "NEXT(n)"
           "TICK(T)"
           "|"
           "DONE(d)")))

 (setq org-agenda-files '("~/Org/inbox.org"
                          "~/Org/gtd.org"
                         "~/Org/tickler.org"))

 (setq org-capture-templates '(("i" "[inbox]" entry
                               (file "~/Org/inbox.org")
                               "* %?")))

 (setq org-refile-targets '(("~/Org/gtd.org" :maxlevel . 3)
                           ("~/Org/someday.org" :level . 1)
                           ("~/Org/tickler.org" :maxlevel . 2)))

 (setq-default bookmark-set-fringe-mark nil)
 (setq org-log-done 'time)
 (setq org-archive-location "~/Org/archive/2023-archive.org::datetree/")
 (setq org-archive-save-context-info '(olpath itags ltags))
 (setq org-startup-folded t)
 (setq org-todo-repeat-to-state t)
 (setq org-stuck-projects '("+LEVEL=1+project/-DONE" ("TODO" "NEXT")))
 (setq org-tags-exclude-from-inheritance '("project"))

 (setq org-agenda-custom-commands
      '(("g" "GTD agenda"
         ((agenda ""
                ((org-agenda-span 'day)
                 (org-agenda-start-day "")
                 (org-agenda-prefix-format "  %s%?b%?-12t")
                 (org-agenda-current-time-string "> now <")
                 (org-agenda-skip-scheduled-if-done t)
                 (org-agenda-skip-deadline-if-done t)
                 (org-agenda-skip-timestamp-if-done t)
                 (org-agenda-files '("~/Org/gtd.org" "~/Org/tickler.org"))))
          (todo "NEXT"
                ((org-agenda-overriding-header "\nNext actions:")
                 (org-agenda-prefix-format "  %?b%? e")
                 (org-agenda-files '("~/Org/gtd.org"))))
           (todo "TODO"
                ((org-agenda-overriding-header "\nTasks:")
                 (org-agenda-prefix-format "  %?b%? e")
                 (org-agenda-files '("~/Org/gtd.org"))))
         (stuck ""
                ((org-agenda-overriding-header "\nStuck projects:")
                 (org-agenda-prefix-format "  ")
                 (org-agenda-files '("~/Org/gtd.org"))))
        (tags "inbox"
              ((org-agenda-overriding-header "\nInbox:")
               (org-agenda-prefix-format "  ")
               (org-agenda-files '("~/Org/inbox.org"))))
         (tags "wait"
              ((org-agenda-overriding-header "\nWaiting list:")
               (org-agenda-prefix-format "  ")
               (org-agenda-files '("~/Org/gtd.org"))))
       (tags "CLOSED>=\"<today>\""
                ((org-agenda-overriding-header "\nCompleted today:")
                 (org-agenda-prefix-format "  ")
                 (org-agenda-files '("~/Org/gtd.org" "~/Org/tickler.org")))))
         ((org-agenda-compact-blocks t)))))

 (setq org-tags-column 0)
 (setq org-agenda-breadcrumbs-separator "/")
 (setq org-agenda-dim-blocked-tasks nil))

;; (setq lsp-clients-clangd-args '("-j=3"
;;                                 "--background-index"
;;                                 "--clang-tidy"
;;                                 "--completion-style=detailed"
;;                                 "--header-insertion=never"
;;                                 "--header-insertion-decorators=0"))
;; (after! lsp-clangd (set-lsp-priority! 'clangd 2))

;; elfeed
(defun elfeed-play-with-mpv ()
"Play entry link with mpv."
(interactive)
(let ((entry (if (eq major-mode 'elfeed-show-mode) elfeed-show-entry (elfeed-search-selected :single))))
(message "Opening link with mpv...")
(start-process "elfeed-mpv" nil "mpv"  (elfeed-entry-link entry))))
(map! :map elfeed-search-mode-map :n "m" #'elfeed-play-with-mpv)

(setq compile-command "gcc -Wall -std=c99 -pedantic -o ")
