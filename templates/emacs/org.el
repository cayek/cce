(require 'org)
(require 'org-protocol)

;; startup
(setq org-src-preserve-indentation t)
(setq org-startup-indented t)
(setq org-log-into-drawer t)
(setq org-startup-with-inline-images t)
(setq org-startup-folded t)

(setq org-refile-targets `((nil :maxlevel . 2)
                           (org-agenda-files :maxlevel . 2)))

(setq org-directory "~/org/")
(setq org-default-notes-file "~/org/INBOX.org")

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/org/INBOX.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "respond" entry (file "~/org/INBOX.org")
               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("n" "note" entry (file "~/org/INBOX.org")
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("j" "Journal" entry (file+datetree "~/org/diary.org")
               "* %?\n%U\n" :clock-in t :clock-resume t)
              ("m" "Meeting" entry (file "~/org/INBOX.org")
               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ("p" "Phone call" entry (file "~/org/INBOX.org")
               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
              )))

;; quick key binding
(global-set-key (kbd "<f4>") 'org-capture)

;; Tags with fast selection keys
(setq org-tag-alist (quote ((:startgroup)
                            ;; who is the client/owner ?
                            ("@se" . ?s)
                            ("@kaizen" . ?k)
                            ("@home" . ?h)
                            (:endgroup)
                            )))

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("MEETING" :foreground "forest green" :weight bold)
              ("PHONE" :foreground "forest green" :weight bold))))

(setq org-agenda-files  `("~/org/INBOX.org"
                          "~/org/se.org"
                          "~/org/kaizen.org"
                          "~/org/home.org"
                          "~/mobile-org/inbox.org"
                          ))


;; custom agenda view
;; TODO

;; keybinding
(fset 'buffer_agenda_cmd
      "\C-ca<n")
(defun cayek:buffer_agenda_view ()
  (interactive)
  (execute-kbd-macro (symbol-function 'buffer_agenda_cmd))
  )

(fset 'agenda_cmd
      "\C-can")
(defun cayek:agenda_view ()
  (interactive)
  (execute-kbd-macro (symbol-function 'agenda_cmd))
  )


(global-set-key (kbd "<f9>") 'cayek:agenda_view)
(global-set-key (kbd "<f10>") 'cayek:buffer_agenda_view)

;; Resume clocking task when emacs is restarted
(org-clock-persistence-insinuate)
;;
;; Show lot of clocking history so it's easy to pick items off the C-F11 list
(setq org-clock-history-length 23)
;; Resume clocking task on clock-in if the clock is open
(setq org-clock-in-resume t)
;; Separate drawers for clocking and logs
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
;; Save clock data and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist t)
;; Do not prompt to resume an active clock
(setq org-clock-persist-query-resume nil)
;; Enable auto clock resolution for finding open clocks
(setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
;; Include current clocking task in clock reports
(setq org-clock-report-include-clocking-task t)

;; Agenda clock report parameters
(setq org-agenda-clockreport-parameter-plist
      (quote (:link t :maxlevel 1 :fileskip0 t :compact t :narrow 80)))

(setq org-archive-location "~/org/archive/%s::")

(defun cayek:open_proj_inbox ()
  (interactive)
  (find-file-existing "~/org/INBOX.org")
  )

(defun cayek:open_cce()
  (interactive)
  (find-file-existing "~/projects/sysadmin/cce/cce.org")
  )

(defun cayek:open_diary()
  (interactive)
  (find-file-existing "~/org/diary.org")
  )

;; org files
(global-set-key (kbd "<f1>") 'cayek:open_proj_inbox)
(global-set-key (kbd "<f2>") 'cayek:open_diary)
(global-set-key (kbd "<f3>") 'cayek:open_cce)

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (shell . t)
     (python . t)
     (R . t)
     (dot . t)
     (org . t)
     (makefile . t)
     (emacs-lisp . t)
     (http . t)
     (jupyter . t)
     ))
  )

(defun cayek:org-rifle-diary ()
  (interactive)
  (helm-org-rifle-files '("~/org/diary.org"))
  )

(defun cayek:org-rifle-archive ()
  (interactive)
  (helm-org-rifle-directories "~/org/archive/")
  )

(defun cayek:org-rifle-bookmark ()
  (interactive)
  (helm-org-rifle-files '("~/mobile-org/bookmarks.org"))
  )

;; search
(global-set-key (kbd "<f5>") 'cayek:org-rifle-diary)
(global-set-key (kbd "<f6>") 'helm-org-rifle-agenda-files)
(global-set-key (kbd "<f7>") 'cayek:org-rifle-bookmark)
(global-set-key (kbd "<f8>") 'cayek:org-rifle-archive)

(defvar cayek:topo_proj_template "
:PROPERTIES:
:CREATED:  %U
:EFFORT:   1d
:INCHARGE: cayek
:END:

*Objectives:*

*Actions:*

*Blocking points:*

*Remarks:*

")

;; org projectile
(require 'org-projectile)

(setq org-projectile-projects-file "~/org/projects.org")
(org-projectile-single-file)
(setq  org-projectile-capture-template
       (format "%s%s" "* TODO %?" cayek:topo_proj_template))
(global-set-key (kbd "C-c n p") 'org-projectile-capture-for-current-project)

;; Outgoing email (msmtp + msmtpq)
(setq send-mail-function 'sendmail-send-it
      sendmail-program "/usr/bin/msmtp"
      mail-specify-envelope-from t
      message-sendmail-envelope-from 'header
      mail-envelope-from 'header)
