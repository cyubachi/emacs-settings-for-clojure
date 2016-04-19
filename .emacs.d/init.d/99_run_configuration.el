(defun exec-lein-ring-server ()
  (interactive)
  (async-shell-command "cd ~/clojre_projects/slack_command_hook; lein ring server"))

(defun exec-lein-deps ()
  (interactive)
  (async-shell-command "cd ~/clojre_projects/slack_command_hook; lein deps"))
