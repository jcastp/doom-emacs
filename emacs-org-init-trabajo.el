(defvar my-work-dir "/mnt/c/Users/castifrc/OneDrive - adidas/agenda/"
  "My own working directory")

  (disable-theme doom-theme)
  (load-theme 'doom-tomorrow-day t)
  (enable-theme 'doom-tomorrow-day)

  ;; empty the org-agenda-files 
  (setq org-agenda-files '(""))
  ;; And now, populate with the work environment
  ;; This needs to be changed when you change company!!!
  (setq org-agenda-files '("~/Nextcloud/agenda/trabajo/adidas.org"
                           )
  )

;;  (setq org-refile-targets (quote (("adidas.org" :maxlevel . 9))))

  (setq org-refile-targets '(
                            (nil :maxlevel . 9)
                            (org-agenda-files :maxlevel . 9)
                            )
  )

  (setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
  (setq org-refile-use-outline-path t)                  ; Show full paths for refiling

     (setq org-agenda-custom-commands
        '(
          ("c" . "My Custom Agendas")
           ("cu" "Unscheduled TODO"
             ((tags-todo "-backlog-calendar"
                   ((org-agenda-overriding-header "\nUnscheduled TODO")
                    (org-agenda-skip-function '(org-agenda-skip-entry-if 'timestamp)))))
               nil
            nil)

            ("ch" "high priority tasks"
            ((tags "PRIORITY=\"A\""
                   ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                    (org-agenda-overriding-header "High-priority unfinished tasks:")))
              ))


            ("ct" "all tasks, sorted"

            ;; High priority tasks
              ((tags "PRIORITY=\"A\""
                   ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                    (org-agenda-overriding-header "High-priority unfinished tasks:")
                    (org-agenda-prefix-format " %10c %5e ")
                    )
               )

            ;; Incident related tasks
               (tags "incident|CATEGORY=\"Incident\""
                 ((org-agenda-overriding-header "Incident related:")
                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-sorting-strategy '(priority-down effort-up))
                   (org-agenda-prefix-format " %10c %5e ")

                 )
               )
 
           ;; Ongoing tasks that needs effort from my side
               (tags-todo "-backlog-calendar/ONGOING"
                 ((org-agenda-overriding-header "Ongoing tasks:")
                   (org-agenda-prefix-format " %10c %5e ")

                 )
               )


            ;; Tasks that are depending on others
               (tags-todo "-backlog-calendar/WAITING"
                 ((org-agenda-overriding-header "Waiting tasks:")
                   (org-agenda-prefix-format " %10c %5e ")
                 )
               )

            ;; Tasks still not started
               (tags-todo "-backlog-calendar +PRIORITY={B\\|C}/TODO"
                 ((org-agenda-overriding-header "TODO tasks:")
                   (org-agenda-prefix-format " %10c %5e ")
                 )
               )


            ;; Calendar tasks
               (tags-todo "calendar-backlog"
                 ((org-agenda-overriding-header "Calendar tasks:")
                   (org-agenda-prefix-format " %10c %5e ")
                 )
               )

              )
             )
      

             ; Backlog
            ("b" "Backlog entries" tags "backlog"
              (
                (org-agenda-overriding-header "Backlog entries")
              )
            )



            ; 'In a day' tasks
            ("d" "Today"
              ((agenda "" ((org-agenda-span 1)
              (org-agenda-sorting-strategy
              (quote ((agenda time-up priority-down tag-up) )))
              ; this will show tasks with a deadline of 2 days more
              (org-deadline-warning-days 2)

            ))))

         
            ; 'In a week' tasks
            ("w" "Week ahead"
              ((agenda "" ((org-agenda-span 7)
              (org-agenda-sorting-strategy
              (quote ((agenda time-up priority-down tag-up) )))
              (org-deadline-warning-days 0)
                  )
                )
              )
            )


        ; only shows home tagged entries
            ("h" "At home" tags-todo "@home"
              (
                (org-agenda-overriding-header "Home")
              )
            )

       ; only shows outside tagged entries
            ("o" "Outside tasks" tags-todo "@outside"
              (
                (org-agenda-overriding-header "Outside")
              )
            )
        )
   )

  (setq org-tag-alist '(
                      ;; group or team
                        (:startgroup . nil)
                          ("cyberdef" . ?c) ("DataProt" . ?d) ("other" . ?o) ("deloitte" . ?l)
                        (:endgroup . nil)
                      ;; tool or way to get the info
                        (:startgroup . nil)
                          ("Confluence" . ?C) ("Mail" . ?M) ("meeting" . ?m) ("other" . ?o)
                        (:endgroup . nil)
                      ;; other tags
                        ("documentation" . ?D) ("procedures" . ?P)
                        ("knowledge" . ?K) ("training" . ?T)
                        ("incident" . ?I) ("task" . ?t)
    )
  )

  (setq org-todo-keywords
     '(
     ; Status for tasks
          (sequence "TODO(t)" "WAITING(w@/!)" "ONGOING(o@/!)" "|" "DONE(d@/!)" "CANCELED(c@/!)")
      )
)

(setq org-capture-templates'(

                             ("i" "My TODO task format." entry
                              (file+headline "~/Nextcloud/agenda/trabajo/adidas.org" "Tasks")
                              "** TODO %?\n:PROPERTIES:\n:type: task\n:END:\n")

                             ("I" "New incident." entry
                              (file+headline "~/Nextcloud/agenda/trabajo/adidas.org" "Incidents")
                              "** TODO %?")


                             ("b" "Backlog entry." entry
                              (file+headline "~/Nextcloud/agenda/trabajo/adidas_backlog.org" "Backlog")
                              "** TODO %?\n")

                             )
      )

  (find-file "~/Nextcloud/agenda/trabajo/adidas.org")
