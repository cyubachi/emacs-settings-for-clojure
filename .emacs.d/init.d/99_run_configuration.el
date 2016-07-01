(defun exec-lein-ring-server-prod ()
  (interactive)
  (async-shell-command (format "cd %s; lein with-profile prod ring server" ffip-project-root)))

(defun exec-lein-ring-server ()
  (interactive)
  (async-shell-command (format "cd %s; lein ring server" ffip-project-root)))

(defun exec-lein-deps ()
  (interactive)
  (async-shell-command (format "cd %s; lein deps" ffip-project-root)))

(defun exec-lein-cljsbuild ()
  (interactive)
  (async-shell-command (format "cd %s; lein cljsbuild auto" ffip-project-root)))
