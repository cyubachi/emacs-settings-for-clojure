(defun exec-lein-ring-server ()
  (interactive)
  (async-shell-command (format "cd %s; lein ring server" ffip-project-root)))

(defun exec-lein-deps ()
  (interactive)
  (async-shell-command (format "cd %s; lein deps" ffip-project-root))
