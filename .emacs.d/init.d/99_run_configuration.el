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

(defun exec-lein-figwheel ()
  (interactive)
  (async-shell-command (format "cd %s; lein figwheel" ffip-project-root))
  (switch-to-buffer (buffer-name (find-file-noselect (concat ffip-project-root "/figwheel_server.log")))))

(defun exec-lein-compile ()
  (interactive)
  (async-shell-command (format "cd %s; lein clean; lein compile" ffip-project-root)))

;; when a .log file is opened, apply to auto-revert-tail-mode
(add-to-list 'auto-mode-alist '("\\.log$" . auto-revert-tail-mode))

;; the cursor moves to end of file.
;(defun do-end-of-buffer()
;  (when auto-revert-tail-mode
;    (end-of-buffer)))
;(add-hook 'after-revert-hook 'do-end-of-buffer)
;(add-hook 'find-file-hook 'do-end-of-buffer)
