;;; config.el -*- lexical-binding: t; -*-

(setq user-full-name "Javier Castilla"
      user-mail-address "jcastp@pm.me")

;; working laptop vm
(defvar my-worksystem-p (equal (system-name) "lubuntuwork"))
;; My desktop machine, able to run anything
(defvar my-desktopsystem-p (equal (system-name) "olimpo"))
;; Writing machines, probably we can strip some features
(defvar my-writinglaptop-p
  (or (equal (system-name) "argos") (equal (system-name) "caliope"))
  )

(defvar my-homeenvironment-p (string= (getenv "WORKING") "HOME"))
(defvar my-workenvironment-p (string= (getenv "WORKING") "WORK"))

(global-unset-key (kbd "C-z"))

(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "M-n") 'forward-paragraph)

(global-auto-revert-mode 1)

;; auto refresh dired when file changes
(add-hook! 'dired-mode-hook 'auto-revert-mode)

(setq bookmark-default-file "~/Nextcloud/config/.emacs.d/bookmarks")  ;;define file to use.
(setq bookmark-save-flag 1)  ;save bookmarks to .emacs.bmk after each entry

(setq browse-url-firefox-program "firefox-esr")
(setq browse-url-browser-function 'browse-url-firefox)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(global-set-key (kbd "C-z") #'undo)

;;where do we read the abbrevs from
(setq abbrev-file-name "~/Nextcloud/config/.emacs.d/abbrev_defs")
(setq-default abbrev-mode t)
(setq save-abbrevs 'silent)        ;; save abbrevs when files are saved

(add-hook! 'text-mode-hook 'flyspell-mode)

; inverse video for mispellings
(global-font-lock-mode t)
;;  (custom-set-faces '(flyspell-incorrect ((t (:inverse-video t)))))

; custom location of the dictionary
(setq ispell-personal-dictionary "~/Nextcloud/config/.emacs.d/dict")

; save the dictionary without asking
(setq ispell-silently-savep t)

(use-package! beacon
    ;;:quelpa (beacon :fetcher github :repo "Malabarba/beacon")
    ;;:ensure t
    :config
      (beacon-mode 1)
      (setq beacon-push-mark 35
          beacon-blink-duration 0.5
          beacon-blink-delay 0.5
          beacon-blink-when-focused t
          beacon-color "deep sky blue")
  )
;; (after! beacon
;;   (beacon-mode 1)
;;   (setq beacon-push-mark 35
;;         beacon-blink-duration 0.5
;;         beacon-blink-delay 0.5
;;         beacon-blink-when-focused t
;;         beacon-color "deep sky blue")
;;   )

(use-package guess-language
  ;;:quelpa (guess-language :fetcher github :repo "tmalsburg/guess-language.el")
  ;;:ensure t
  :config
  ;; (setq guess-language-langcodes '((en . ("en_GB" "English"))
  ;;                                  (es . ("es_ES" "Spanish"))))
  (setq guess-language-languages '(en es))
  (setq guess-language-min-paragraph-length 40)
  :hook (text-mode-hook . (lambda () (guess-language-mode 1)))
  )

(electric-pair-mode 1)
;; make electric-pair-mode work on more sets of punctuation signs.
(setq electric-pair-pairs
       '(
         (?\¡ . ?\!)
         (?\¿ . ?\?)
         )
 )

(setq electric-pair-inhibit-predicate
       `(lambda (c)
          (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c)))
)

(add-to-list 'yas-snippet-dirs "/home/jcastp/Nextcloud/config/.emacs.d/snippets/" t)

(setq
  ;; Font used for source code
  ;; doom-font (font-spec :family "JetBrains Mono" :size 14 :weight 'Medium)
  ;; doom-font (font-spec :family "Fira Code" :size 14 :weight 'Medium)
  ;; doom-font (font-spec :family "Hasklig" :size 14 :weight 'Medium)
  ;; doom-font (font-spec :family "Iosevka Fixed" :size 16 :weight 'Medium)
  doom-font (font-spec :family "Hack" :size 14)

  ;; Font used for normal writing
  ;;doom-variable-pitch-font (font-spec :family "Gentium Basic" :size 18)
  ;;doom-variable-pitch-font (font-spec :family "ETBookOT" :size 18)
  ;;doom-variable-pitch-font (font-spec :family "ETBembo" :size 18)
  doom-variable-pitch-font (font-spec :family "EB Garamond 12" :size 18 :weight 'Medium)
  ;; When you want to have a fixed font for the variable one
  ;; doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 16 :weight 'Extralight)
  ;; doom-variable-pitch-font (font-spec :family "Iosevka" :size 16 :weight 'Regular)
  )

(consult-theme 'doom-homage-black)

(global-set-key (kbd "M-+") 'text-scale-increase)
(global-set-key (kbd "M--") 'text-scale-decrease)

(setq-default frame-title-format "%b - (%f)")

(setq display-time-day-and-date t
      display-time-24hr-format t)
(display-time)

;; this is done to open the indirect buffer in another window
;; instead on the main one
(after! org
  (setq org-indirect-buffer-display 'other-window)

  (defun my/org-tree-open-in-right-frame ()
    (interactive)
    (org-tree-to-indirect-buffer)
    (windmove-right)
    )
  (global-set-key (kbd "C-c 8" ) 'my/org-tree-open-in-right-frame)
  )

;;(tab-bar-mode 1)
;; Map the not mapped but useful functions
(global-set-key (kbd "C-x t s") 'tab-list)
(global-set-key (kbd "C-x t a") 'tab-recent)
;; Check if it is worth to enable the tab-bar-history-mode
;; and configure the commands to browse the history

(custom-set-faces!
  '(aw-leading-char-face
    :foreground "white" :background "red"
    :weight bold :height 2.5 :box (:line-width 10 :color "red")))

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(use-package key-chord
    ;;:quelpa (key-chord :fetcher github :repo "emacsorphanage/key-chord")
    ;;:ensure t
    :init
      (key-chord-mode 1)
    :config
      ;; Max time delay between two key presses to be considered a key chord
      (setq key-chord-two-keys-delay 0.1)
      ;; Max time delay between two presses of the same key to be considered a key chord.
      ;; Should normally be a little longer than `key-chord-two-keys-delay'.
      (setq key-chord-one-key-delay 0.2) ; default 0.2
  )
;; (after! key-chord
;;   (key-chord-mode 1)
;;   ;; Max time delay between two key presses to be considered a key chord
;;   (setq key-chord-two-keys-delay 0.1)
;;   ;; Max time delay between two presses of the same key to be considered a key chord.
;;   ;; Should normally be a little longer than `key-chord-two-keys-delay'.
;;   (setq key-chord-one-key-delay 0.2) ; default 0.2
;; )

(key-chord-define-global "ññ" 'eshell)
;;  (key-chord-define-global "kk" 'other-window)
  (key-chord-define-global "hh" 'ace-window)
  (key-chord-define-global "jj" 'avy-goto-char-2)
  (key-chord-define-global "jl" 'avy-goto-line)
;;  (key-chord-define-global "zz" 'undo-tree-visualize)
  ;(key-chord-define-global "ww" 'hydra-move/body)
  ;(key-chord-define-global "yy" 'hydra-buffer-mgmt/body)

;; put the imenu in the position we want to
(setq imenu-list-position 'right)
;; Establish the depth of the entries shown
(setq org-imenu-depth 5)
;; map the keys
(global-unset-key (kbd "M-i"))
(global-set-key (kbd "C-c s I") #'imenu-list-smart-toggle)
;; Once you open imenu, focus on it
(setq imenu-list-focus-after-activation t)

(global-set-key (kbd "C-s") #'consult-line)

(setq org-priority-highest ?A
      org-priority-lowest ?E
      org-priority-faces
      '((?A . 'all-the-icons-red)
        (?B . 'all-the-icons-orange)
        (?C . 'all-the-icons-yellow)
        (?D . 'all-the-icons-green)
        (?E . 'all-the-icons-blue))
      )

(after! org
  ;; Adds a timestamp to the state
  (setq org-log-done 'time)

  ;; Adds a custom note to the state
  (setq org-log-done 'note)

  ;; When the deadline or the schedule date is moved.
  ;; to keep track of how many times I have moved a task to the future.
  (setq org-log-redeadline (quote time))
  (setq org-log-reschedule (quote time))
)

(after! org
(setq org-todo-keywords
      '(
        ;; Status for tasks
        (sequence "TODO(t)" "ONGOING(r!)" "WAITING(w@/!)" "|" "DONE(d!)" "CANCELED(c@/!)")
        ;; Status for writing
        (sequence "TOWRITE(y)" "TOREVIEW(u@/!)" "REDO(i@/!)" "|" "FINISHED(o!)" "PURGE(p@/!)")
        )
      )
)

(after! org
  (setq org-agenda-files '(
                           ;; normal task files
                           "~/Nextcloud/agenda/tasks.org"
                           "~/Nextcloud/agenda/inbox.org"
                           ;; doom config, for the
                           "~/.doom.d/config.org"
                           )
  )
)

(after! org
  (setq org-agenda-skip-scheduled-if-done t)
  (setq org-agenda-skip-deadline-if-done t)
  (setq org-agenda-skip-timestamp-if-done t)
  )

(after! org
  (setq org-agenda-custom-commands
       '(
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;
         ; Custom agenda commands
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;
         ("c" . "My Custom Agendas")

         ;; All the unescheduled tasks
          ("cu" "Unscheduled TODO"
            ((tags-todo "-backlog"
                  ((org-agenda-overriding-header "\nUnscheduled TODO")
                   (org-agenda-skip-function '(org-agenda-skip-entry-if 'timestamp)))))
              nil
           nil)

          ;; All the HIGH priority tasks, no backlog
           ("ch" "high priority tasks"
             (
               (tags-todo "+PRIORITY=\"A\"-backlog"
                  (
                   (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                   (org-agenda-overriding-header "High-priority unfinished tasks:")
                   )

                  )

               )
             )

           ;; All tasks, sorted and grouped
           ("ct" "all tasks, sorted"
             (
              ;; High priority tasks, no backlog
              (
               tags-todo "+PRIORITY=\"A\"-backlog"
                  (
                    (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                    (org-agenda-overriding-header "High-priority unfinished tasks:")
                    (org-agenda-prefix-format " %10c %5e ")

                    )
                  )
              ;; Ongoing tasks that needs effort from my side
              (tags-todo "-backlog-books/ONGOING"
                (
                 (org-agenda-overriding-header "Ongoing tasks:")
                 (org-agenda-prefix-format " %10c %5e ")
                 )
                )

              ;; Tasks scheduled today
              (agenda ""
                   (
                    (org-agenda-time-grid nil)
                    (org-schedule-warning-days 1)        ;; [1]
                    (org-agenda-entry-types '(:scheduled))  ;; [2]
                    (org-agenda-overriding-header "Scheduled today tasks:")
                    (org-agenda-prefix-format " %10c %5e ")
                    )
                   )

              ;; Tasks that are waiting on something
              (tags-todo "-backlog-books/WAITING"
                (
                 (org-agenda-overriding-header "Waiting tasks:")
                 (org-agenda-prefix-format " %10c %5e ")
                 )
                )

              ;; Tasks still not started, that are not high priority
              (tags-todo "-backlog-books-calendar +PRIORITY={B\\|C}/TODO"
                (
                 (org-agenda-overriding-header "TODO tasks:")
                 (org-agenda-prefix-format " %10c %5e ")
                 )
                )

              ;; Calendar tasks
              (tags-todo "calendar"
                (
                 (org-agenda-overriding-header "Calendar tasks:")
                 (org-agenda-prefix-format " %10c %5e ")
                 )
                )

              ;; Stuck tasks and projects
              (stuck ""
                (
                 (org-agenda-overriding-header "Stuck tasks:")
                 (org-agenda-prefix-format " %10c %5e ")
                 )
                )

              ;; end configuration all tasks sorted and grouped
              )
             )

           ;;;;;;;;;;;;
           ;; Time based queries
           ;;;;;;;;;;;;
           ;; 'In a day' tasks
           ("d" "Today"
             (
              (agenda "" ((org-agenda-span 1)
                          (org-agenda-sorting-strategy
                           (quote ((agenda time-up priority-down tag-up) ))
                           )
                           ; this will show tasks with a deadline of 2 days more
                          (org-deadline-warning-days 2)


                          )
                      )
              )
             )

           ; 'In a week' tasks
           ("w" "Week ahead"
              (
               (agenda "" ((org-agenda-span 7)
                           (org-agenda-sorting-strategy
                            (quote ((agenda time-up priority-down tag-up) ))
                            )
                           (org-deadline-warning-days 0)
                           )
                       )
               )
              )

           ;;;;;;;;;;;;;;;;;;;;;;;
           ;; Location/context based queries
           ;;;;;;;;;;;;;;;;;;;;;;;

           ; only shows home tagged entries
           ("h" "At home" tags-todo "+home-backlog"
             (
               (org-agenda-overriding-header "Home")
             )
           )

           ; only shows outside tagged entries
           ("o" "Outside tasks" tags-todo "+outside-backlog"
             (
               (org-agenda-overriding-header "Outside")
             )
           )

           ;;;;;;;;;;;;;;;;
           ; backlog entries
           ("b" "Backlog entries" tags-todo "+backlog-objetivos-calendar"
             (
               (org-agenda-overriding-header "Backlog")
             )
           )

       )
  )
)

(after! org
  (setq org-agenda-span 15)
  (setq org-agenda-start-on-weekday nil)
  )

(setq org-agenda-window-setup 'reorganize-frame)

(after! org
  (setq org-refile-targets '(
                              (nil :maxlevel . 9)
                              (org-agenda-files :maxlevel . 9)
                              ("referencias.org" :maxlevel . 9)
                              ("maybe.org" :maxlevel . 9)
                              ("books.org" :maxlevel . 9)
                              ("~/Nextcloud/escritura/ideas/ideas.org" :maxlevel . 9)

                              )
  )
  (setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
  (setq org-refile-use-outline-path t)                  ; Show full paths for refiling
  )

(after! org
  ;; don't show the "validate" link on org-html exports
  (setq org-html-validation-link nil)
  )

(after! org
  (load "~/Nextcloud/config/.emacs.d/vendor/ox-extra/ox-extra.el")
  (require 'ox-extra)
  (ox-extras-activate '(ignore-headlines))
  )

(after! org
  (require 'ox-md)
  )

(after! org
  (add-to-list 'org-latex-classes
       '("memoir"
                 "\\documentclass[a4paper,17pt,openright,twoside]{memoir}
  \\usepackage{ucs}
  \\usepackage[utf8]{inputenc}
  \\usepackage[spanish]{babel}
  \\usepackage{fontenc}
  \\usepackage{graphicx}

  \% Para poner notas en los márgenes
  \\usepackage{todonotes}

  \% Para tachar palabras
  \\usepackage[normalem]{ulem}

  \\usepackage{hyperref}
  \\usepackage{parskip}
  \\usepackage{fourier}

  \\renewcommand*\\rmdefault{put}

  \\newcommand{\\fin}{\\plainbreak*{3}}

  % command to add edit notes with tiny size
  \\newcommand{\\edit}[1] {\\todo[inline]{#1}}
  \\newcommand{\\adendo}[1] {\\todo[size=\\tiny]{#1}}

  % Chapter style
   \\chapterstyle{dash}

  % How the page is formatted
    \\pagestyle{Ruled}



                 [NO-DEFAULT-PACKAGES]
                 [NO-PACKAGES]"
                 ("\\part{%s}" . "\\part*{%s}")
                 ("\\chapter{%s}" . "\\chapter*{%s}")
                 ("\\section*{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
               )
)

(after! org
  (add-to-list 'org-latex-classes
       '("memoir_draft"
                 "\\documentclass[a4paper,17pt,draft,openright,twoside]{memoir}
  \\usepackage{ucs}
  \\usepackage[utf8]{inputenc}
  \\usepackage[spanish]{babel}
  \\usepackage{fontenc}
  \\usepackage{graphicx}

  \% Para poner notas en los márgenes
  \\usepackage{todonotes}

  \% Para tachar palabras
  \\usepackage[normalem]{ulem}

  \\usepackage{hyperref}
  \\usepackage{parskip}
  \\usepackage{fourier}

  \\renewcommand*\\rmdefault{put}

  \\newcommand{\\fin}{\\plainbreak*{3}}

  \% command to add edit notes with tiny size
  \\newcommand{\\edit}[1] {\\todo[inline]{#1}}
  \\newcommand{\\adendo}[1] {\\todo[size=\\tiny]{#1}}

  \% Chapter style
  \\chapterstyle{dash}

  \% How the page is formatted
  \\pagestyle{Ruled}





                 [NO-DEFAULT-PACKAGES]
                 [NO-PACKAGES]"
                 ("\\part{%s}" . "\\part*{%s}")
                 ("\\chapter{%s}" . "\\chapter*{%s}")
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection*{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection*{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph*{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph*{%s}" . "\\subparagraph*{%s}"))
               )
)

(after! org
  (add-to-list 'org-latex-classes
       '("memoir"
                 "\\documentclass[a4paper,17pt,openright,twoside]{memoir}
  \\usepackage{ucs}
  \\usepackage[utf8]{inputenc}
  \\usepackage[spanish]{babel}
  \\usepackage{fontenc}
  \\usepackage{graphicx}

  \% Para poner notas en los márgenes
  \\usepackage{todonotes}

  \% Para tachar palabras
  \\usepackage[normalem]{ulem}

  \\usepackage{hyperref}
  \\usepackage{parskip}
  \\usepackage{fourier}

  \\renewcommand*\\rmdefault{put}

  \\newcommand{\\fin}{\\plainbreak*{3}}

  % command to add edit notes with tiny size
  \\newcommand{\\edit}[1] {\\todo[inline]{#1}}
  \\newcommand{\\adendo}[1] {\\todo[size=\\tiny]{#1}}

  % Chapter style
   \\chapterstyle{dash}

  % How the page is formatted
    \\pagestyle{Ruled}



                 [NO-DEFAULT-PACKAGES]
                 [NO-PACKAGES]"

                 ("\\chapter{%s}" . "\\chapter*{%s}")
                 ("\\section*{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
               )
)

(after! org
  (add-to-list 'org-latex-classes
       '("memoir_draft"
                 "\\documentclass[a4paper,17pt,draft,openright,twoside]{memoir}
  \\usepackage{ucs}
  \\usepackage[utf8]{inputenc}
  \\usepackage[spanish]{babel}
  \\usepackage{fontenc}
  \\usepackage{graphicx}

  \% Para poner notas en los márgenes
  \\usepackage{todonotes}

  \% Para tachar palabras
  \\usepackage[normalem]{ulem}

  \\usepackage{hyperref}
  \\usepackage{parskip}
  \\usepackage{fourier}

  \\renewcommand*\\rmdefault{put}

  \\newcommand{\\fin}{\\plainbreak*{3}}

  \% command to add edit notes with tiny size
  \\newcommand{\\edit}[1] {\\todo[inline]{#1}}
  \\newcommand{\\adendo}[1] {\\todo[size=\\tiny]{#1}}

  \% Chapter style
  \\chapterstyle{dash}

  \% How the page is formatted
  \\pagestyle{Ruled}





                 [NO-DEFAULT-PACKAGES]
                 [NO-PACKAGES]"

                 ("\\chapter{%s}" . "\\chapter*{%s}")
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection*{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection*{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph*{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph*{%s}" . "\\subparagraph*{%s}"))
               )
)

(after! org
  (add-to-list 'org-latex-classes
       '("reporting"
                 "\\documentclass[a4paper,17pt,openright,twoside]{article}
  \\usepackage{ucs}
  \\usepackage[utf8]{inputenc}
  \\usepackage[spanish]{babel}
  \\usepackage{fontenc}
  \\usepackage{graphicx}

  \% Para poner notas en los márgenes
  \\usepackage{todonotes}

  \% Para tachar palabras
  \\usepackage[normalem]{ulem}

  \\usepackage{hyperref}
  \\usepackage{parskip}
  \\usepackage{fourier}

  \\renewcommand*\\rmdefault{put}

  \\newcommand{\\fin}{\\plainbreak*{3}}

  \% command to add edit notes with tiny size
  \\newcommand{\\edit}[1] {\\todo[inline]{#1}}
  \\newcommand{\\adendo}[1] {\\todo[size=\\tiny]{#1}}




                 [NO-DEFAULT-PACKAGES]
                 [NO-PACKAGES]"
                 ("\\part{%s}" . "\\part*{%s}")
                 ("\\chapter{%s}" . "\\chapter*{%s}")
                 ("\\section*{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
               )
)

(after! org
  (setq org-export-with-smart-quotes t)
  )

(after! org
  (require 'ox-org)
  )

(after! org
  (require 'ox-beamer)
  (require 'ox-latex)
  (setq org-export-allow-bind-keywords t)
  (setq org-latex-listings 'minted)
  (add-to-list 'org-latex-packages-alist '("" "minted"))
  (org-babel-do-load-languages 'org-babel-load-languages '(
     (shell . t)
     (python . t)
     (C . t)
     (ruby . t)
     (js . t)
     (ditaa . t)
     (gnuplot . t)
     )
  )
  (setq org-latex-pdf-process
        '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
  )

(setq org-ditaa-jar-path "/usr/bin/ditaa")

(after! org
  (setq org-capture-templates'(
                               ("i" "Inbox" entry
                                (file+headline "~/Nextcloud/agenda/tasks.org" "Inbox")
                                "* TODO %i%? \nEntered on %U"
                                :empty-lines-after 2)
                               )
        )
)
  ;; (setq org-capture-templates'(
  ;;                              ("t" "My TODO task format." entry
  ;;                               (file+headline "~/Nextcloud/agenda/inbox.org" "Tasks")
  ;;                               "** TODO %i%? %^g \n%U"
  ;;                               :empty-lines-after 1)

  ;;                              ("p" "New project." entry
  ;;                               (file+headline "~/Nextcloud/agenda/tasks.org" "Projects")
  ;;                               "** TODO %? %^g \n%U\n- Objetivo:"
  ;;                               :empty-lines-after 1)

  ;;                              ("c" "New calendar entry." entry
  ;;                               (file+headline "~/Nextcloud/agenda/tasks.org" "Calendar")
  ;;                               "** TODO %i%?\nSCHEDULED: %^t\n"
  ;;                               :empty-lines-after 1)

  ;;                              ;; Writing related things
  ;;                              ("i" "Writing idea." entry
  ;;                               (file+headline "~/Nextcloud/escritura/ideas/ideas.org" "otras")
  ;;                               "** TODO %?\n*** Personajes\n- \n*** Ambientación\n*** Eventos\n"
  ;;                               :empty-lines-after 1)

  ;;                              ("P" "Personaje" entry
  ;;                               (file "~/Nextcloud/escritura/ideas/personajes.org")
  ;;                               "* "
  ;;                               :empty-lines-after 1)

  ;;                              ("h" "Compost heap" item
  ;;                               (file+headline "~/Nextcloud/escritura/ideas/compost_heap.org" "Compost heap")
  ;;                               "%i"
  ;;                               :empty-lines-after 1)

  ;;                              ("r" "Note and misc content." entry
  ;;                               (file+headline "~/Nextcloud/agenda/inbox.org" "Notes")
  ;;                               "** %i%?\n"
  ;;                               :empty-lines-after 1)

  ;;                              ;; books to read
  ;;                              ("b" "Manual book entry" entry (file "~/Nextcloud/agenda/books.org")
  ;;                               "* %^{TITLE}\n:PROPERTIES:\n:ADDED: %<[%Y-%02m-%02d]>\n:END:%^{AUTHOR}p\n%?" :empty-lines 1)

  ;;                              ;; this one adds a book from an URL, *but you have to have the URL already in the kill ring* or it won't work
  ;;                              ("B" "Book with URL" entry (file "~/Nextcloud/agenda/books.org")
  ;;                               "%(let* ((url (substring-no-properties (current-kill 0)))
  ;;                 (details (org-books-get-details url)))
  ;;            (when details (apply #'org-books-format 1 details)))")

  ;; ;;     ("b" "books to read." entry
  ;; ;;       (file+headline "~/Nextcloud
  ;;                             /agenda/books.org" "Books")
  ;;       "* %^{Title}  %^g
  ;;       %i
  ;;       *Author(s):* %^{Author}
  ;;       ")

  ;; linea en tabla
  ;;  ("w" "peso" table-line
  ;;     (file+headline "~/Nextcloud/personal/peso.org" "peso")
  ;;     "|%<%Y/%m/%d>|%i|")

  ;;    )
  ;; )

(after! org
  (setq org-tag-alist '(
                        ;; Contexts based on locations
                        ("work" . ?W) ("home" . ?h)  ("outside" . ?o)
                        ;; Contexts based on tools
                        ("computer" . ?c) ("mobile" . ?m)  ("penpaper" . ?p)
                        ;; Contexts based on activities
                        ("emacs" . ?e)  ("writing" . ?w) ("reading" . ?r)
    )
  )
)

(after! org
  (setq org-hide-emphasis-markers t)
)

(use-package org-appear
  ;;:quelpa (org-appear :type git :host github :repo "awth13/org-appear")
  ;;:ensure t
  :hook (org-mode . org-appear-mode)
  )

(setq org-roam-v2-ack t)
(setq org-roam-directory (file-truename "~/Nextcloud/personal/roam"))

;; ("C-c n l" . org-roam-buffer-toggle)
;; ("C-c n f" . org-roam-node-find)
;; ("C-c n i" . org-roam-node-insert)
;; ("C-c n c" . org-roam-capture)
;; :map org-roam-dailies-map
;; ("Y" . org-roam-dailies-capture-yesterday)
;; ("T" . org-roam-dailies-capture-tomorrow)
;; :bind-keymap
;; ("C-c n d" . org-roam-dailies-map)

;; provide org-roam completion links outside org files.
(setq org-roam-completion-everywhere t)
;; Location of the roam database
(setq org-roam-db-location (file-truename "~/Nextcloud/personal/roam/org-roam.db"))
;; Ensure the keymap is available
;;(require 'org-roam-dailies)
;; org-roam export: https://www.orgroam.com/manual.html#org_002droam_002dexport
;;      (require 'org-roam-export)
;; autosync
(org-roam-db-autosync-mode 1)

(setq org-roam-capture-templates
      '(
        ;; default template
        ("d" "default" plain
         "* TODO ${title}\n%?"
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
         :unnarrowed t)
        ("b" "book notes" plain (file "~/.doom.d/roamtemplates/BookNoteTemplate.org")
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: book")
         :unnarrowed t)
        ("w" "writing idea" plain (file "~/.doom.d/roamtemplates/WritingIdea.org")
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: writing")
         :unnarrowed t)
        ("c" "writing character" plain (file "~/.doom.d/roamtemplates/CharacterIdea.org")
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: writing character")
         :unnarrowed t)
        )
      )

(setq org-roam-node-display-template
   (concat "${title:*} "
           (propertize "${tags:20}" 'face 'org-tag)))

(defun my/org-roam-rg-search ()
  "Search org-roam directory using consult-ripgrep. With live-preview."
  (interactive)
  (let ((consult-ripgrep-command "rg --null --ignore-case --type org --line-buffered --color=always --max-columns=500 --no-heading --line-number . -e ARG OPTS"))
    (consult-ripgrep org-roam-directory)))
(global-set-key (kbd "C-c rr") 'my/org-roam-rg-search)

;; Daily notes for org-roam
;; Directory is relative to org-roam-directory
(setq org-roam-dailies-directory "daily/")

;; Capture template for the dailies
(setq org-roam-dailies-capture-templates
    '(("d" "default" entry
       "* %?"
       :if-new (file+head "%<%Y-%m-%d>.org"
                          "#+title: %<%Y-%m-%d>\n#+filetags: daily\n"))))

(use-package! org-roam-ui
  :after org-roam
  :hook (org-roam . org-roam-ui-mode)
  )

;; Load this only on my personal profile, and not in my work one
  (if my-homeenvironment-p
         (progn



  ;; we want to load these functions if org-roam is present
  (if (not(require 'org-roam nil t))
          ;; if condition
          (message "org-roam not found")
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; else condition

    (setq my/roamtag "roamtag")

    (defun vulpea-buffer-prop-set (name value)
        "Set a file property called NAME to VALUE in buffer file.
          If the property is already set, replace its value."
        (setq name (downcase name))
        (org-with-point-at 1
          (let ((case-fold-search t))
            (if (re-search-forward (concat "^#\\+" name ":\\(.*\\)")
                                   (point-max) t)
                (replace-match (concat "#+" name ": " value) 'fixedcase)
              (while (and (not (eobp))
                          (looking-at "^[#:]"))
                (if (save-excursion (end-of-line) (eobp))
                    (progn
                      (end-of-line)
                      (insert "\n"))
                  (forward-line)
                  (beginning-of-line)))
              (insert "#+" name ": " value "\n")))))

    (defun vulpea-buffer-prop-set-list (name values &optional separators)
      "Set a file property called NAME to VALUES in current buffer.
          VALUES are quoted and combined into single string using
          `combine-and-quote-strings'.
          If SEPARATORS is non-nil, it should be a regular expression
          matching text that separates, but is not part of, the substrings.
          If nil it defaults to `split-string-default-separators', normally
          \"[ \f\t\n\r\v]+\", and OMIT-NULLS is forced to t.
          If the property is already set, replace its value."
      (vulpea-buffer-prop-set
       name (combine-and-quote-strings values separators)))

    (defun vulpea-buffer-tags-set (&rest tags)
      "Set TAGS in current buffer.
            If filetags value is already set, replace it."
      (vulpea-buffer-prop-set "filetags" (string-join tags " ")))

    (defun vulpea-buffer-prop-get (name)
      "Get a buffer property called NAME as a string."
      (org-with-point-at 1
        (when (re-search-forward (concat "^#\\+" name ": \\(.*\\)")
                                 (point-max) t)
          (buffer-substring-no-properties
           (match-beginning 1)
           (match-end 1)))))


    (defun vulpea-buffer-prop-get-list (name &optional separators)
      "Get a buffer property NAME as a list using SEPARATORS.
              If SEPARATORS is non-nil, it should be a regular expression
              matching text that separates, but is not part of, the substrings.
              If nil it defaults to `split-string-default-separators', normally
              \"[ \f\t\n\r\v]+\", and OMIT-NULLS is forced to t."
      (let ((value (vulpea-buffer-prop-get name)))
        (when (and value (not (string-empty-p value)))
          (split-string-and-unquote value separators))))

    (defun vulpea-buffer-tags-get ()
      "Return filetags value in current buffer."
      (vulpea-buffer-prop-get-list "filetags" " "))

    (defun vulpea-buffer-tags-add (tag)
      "Add a TAG to filetags in current buffer."
      (let* ((tags (vulpea-buffer-tags-get))
             (tags (append tags (list tag))))
        (apply #'vulpea-buffer-tags-set tags)))



    (defun vulpea-project-p ()
      "Return non-nil if current buffer has any todo entry.

                  TODO entries marked as done are ignored, meaning the this
                  function returns nil if current buffer contains only completed
                  tasks."
      (seq-find                                 ; (3)
       (lambda (type)
         (eq type 'todo))
       (org-element-map                         ; (2)
           (org-element-parse-buffer 'headline) ; (1)
           'headline
         (lambda (h)
           (org-element-property :todo-type h)))))

    (defun vulpea-project-update-tag ()
      "Update PROJECT tag in the current buffer."
      (when (and (not (active-minibuffer-window))
                 (vulpea-buffer-p))
        (save-excursion
          (goto-char (point-min))
          (let* ((tags (vulpea-buffer-tags-get))
                 (original-tags tags))
            (if (vulpea-project-p)
                (setq tags (cons "roamtag" tags))
              (setq tags (remove "roamtag" tags)))

            ;; cleanup duplicates
            (setq tags (seq-uniq tags))

            ;; update tags if changed
            (when (or (seq-difference tags original-tags)
                      (seq-difference original-tags tags))
              (apply #'vulpea-buffer-tags-set tags))))))

    (defun vulpea-buffer-p ()
      "Return non-nil if the currently visited buffer is a note."
      (and buffer-file-name
           (string-prefix-p
            (expand-file-name (file-name-as-directory org-roam-directory))
            (file-name-directory buffer-file-name))))

    (defun vulpea-project-files ()
      "Return a list of note files containing 'roamtag' tag." ;
      (seq-uniq
       (seq-map
        #'car
        (org-roam-db-query
         [:select [nodes:file]
                  :from tags
                  :left-join nodes
                  :on (= tags:node-id nodes:id)
                  :where (like tag (quote "%\"roamtag\"%"))]))))

    ;; This will overwrite the current agenda files, and we don't want that
    (defun vulpea-agenda-files-update (&rest _)
      "Update the value of `org-agenda-files'."
      (setq org-agenda-files (vulpea-project-files)))

    (defun inject-vulpea-project-files (org-agenda-files)
      (append org-agenda-files (vulpea-project-files)))
    (advice-add 'org-agenda-files :filter-return #'inject-vulpea-project-files)

    (add-hook 'find-file-hook #'vulpea-project-update-tag)
    (add-hook 'before-save-hook #'vulpea-project-update-tag)

    ;; original code that overwrites the agenda files
    ;;  (advice-add 'org-agenda :before #'vulpea-agenda-files-update)
    ;;  (advice-add 'org-todo-list :before #'vulpea-agenda-files-update)
    )
  ))

(global-set-key (kbd "C-c 9") 'wc-mode)
(setq doom-modeline-enable-word-count t)

(global-set-key (kbd "C-c 3") 'org-tracktable-status)
(global-set-key (kbd "C-c 4") 'org-tracktable-write)

(setq +zen-text-scale 2)
(setq writeroom-width 0.1)

;;("C-c r ñ" . org-journal-new-entry)
(setq org-journal-date-prefix "#+TITLE: ")
(setq org-journal-file-format "%Y-%m-%d.org")
(setq org-journal-dir "~/Nextcloud/personal/diario/")
(setq org-journal-date-format "%A, %d %B %Y")
(setq org-journal-encrypt-journal nil)

(defun my/buscarae (palabra)
   "Busca una palabra en la RAE."
   (interactive "s¿Qué palabra quieres buscar? ")
   (eww (concat "https://dle.rae.es/" palabra))
)

(defun my/sinonimo (palabra)
   "Busca una palabra en un diccionario de sinónimos"
   (interactive "s¿Qué palabra quieres buscar? ")
   (eww (concat "https://www.wordreference.com/sinonimos/" palabra))
)

(defun my/translate (palabra)
  "Traduccion de inglés a español"
  (interactive "s¿Qué palabra quieres buscar? ")
  (eww (concat "https://www.deepl.com/translator#en/es/" palabra))
)

(setq elfeed-db-directory "~/Nextcloud/config/.emacs.d/elfeed")
(global-set-key (kbd "C-c m w") 'elfeed)

(setq elfeed-feeds
      '(
        ;; security
        ("https://krebsonsecurity.com/feed/" security)
        ("https://www.schneier.com/feed/atom" security)
        ;; writing
        "https://www.helpingwritersbecomeauthors.com/feed/"
        "http://thewritepractice.com/feed/"
        ;; emacs
        "https://sachachua.com/blog/feed"
        )
      )

(require 'emms-setup)
(emms-all)
(emms-default-players)
;; Depending on the system, the music is one place or another
(if my-desktopsystem-p
    (setq emms-source-file-default-directory "/home/musica") ;; Change to your music folder
  )
(if my-worksystem-p
    (setq emms-source-file-default-directory "/home/jcastp/Música") ;; Change to your music folder
    )

;; fot the tagging of songs
(setq emms-info-functions '(emms-info-tinytag))

;; Keyboard shortcuts
(global-set-key (kbd "<XF86AudioPrev>") 'emms-previous)
(global-set-key (kbd "<XF86AudioNext>") 'emms-next)
(global-set-key (kbd "<XF86AudioPlay>") 'emms-pause)

(global-set-key (kbd "C-c m m") 'emms-browser)

;; This is the list of themes I want to apply and rotate
(defvar my/themes '(
                    ; dark themes
                    doom-homage-black
                    doom-vibrant
                    ; light themes
                    leuven
                    doom-acario-light)
  "Stores the themes we want to change to.
The theme enabled will be the first of the list,
and then it will be pushed to the end of the list.
This way, we rotate the themes."
  )


(defun my/theme-changer()
  "Given a list of themes, it get the first one, applies it and adds it back to the list.

        The result is that we can rotate from a custom list of themes."
  (interactive)
  ;; obtain the first item of the list, extract it, apply it, and put it back to the end of the list
  (setq my/first-theme (car my/themes))
  ;;(message "theme is %s" my/first-theme)
  (setq my/themes
        (nconc (last my/themes) (butlast my/themes)))
                                        ;(disable-theme doom-theme)
                                        ;(enable-theme my/first-theme)
  (consult-theme my/first-theme)
  (message "Applied the theme %s" my/first-theme)
  )

(global-set-key (kbd "C-c 0") 'my/theme-changer)

(defun my/font-changer()
  "Change the variable pitch font when needed and recover it."
  (interactive)
  ;; Here will be the code to change the font
  (variable-pitch-mode)
  )

;; Load this config when using the work computer
(if my-workenvironment-p
       (progn
         (org-babel-load-file "~/.doom.d/emacs-org-init-trabajo.org")
    )
  )
