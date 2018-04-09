(require 'helm)
(require 'helm-config)
(require 'f)

;; for switch project sources
(defvar emacs-project-dir "~/EmacsProjects")

(setq switch-project-candidates
      (if (file-exists-p emacs-project-dir)
          (loop for x in (directory-files emacs-project-dir nil "^\\([^.]\\|\\.[^.]\\|\\.\\..\\)")
                when (file-directory-p (concat emacs-project-dir "/" x))
                collect x)
        ()))

(if (eq system-type 'windows-nt)
    (setq ffip-find-executable "c:\\\\cygwin64\\\\bin\\\\find"))

(defun switch-project (project-dir-name)
  (setq ffip-project-root (format "%s/%s" emacs-project-dir project-dir-name))
  ;; (neotree-dir ffip-project-root)
  )

(global-set-key (kbd "C-c r") 'find-file-in-project)

(defvar helm-source-switch-project
  '((name . "Switch Project")
    (candidates . (lambda () switch-project-candidates))
    (action . switch-project)))


(defun list-defined-functions-in-file (file)
  (-map 'cadr (s-match-strings-all "defun \\(exec-.*?\\) "
                                   (f-read file))))


(setq run-congiguration-candidates (list-defined-functions-in-file "~/.emacs.d/init.d/99_run_configuration.el"))

(defun run-cmd (fn-name)
  (eval (car (read-from-string (format "(%s)" fn-name)))))

(add-to-list 'display-buffer-alist
  (cons "\\*Async Shell Command\\*.*" (cons #'display-buffer-no-window nil)))


(defvar helm-source-run-configuration
  '((name . "Run configuration")
    (candidates . (lambda () run-congiguration-candidates))
    (action . run-cmd)))

(defun show-cheatsheet (cs)
  (message "%s" cs)
  (custom-cheatsheet-show))

(setq cheatsheet-candidates '("show cheatsheet"))

(defvar helm-source-cheatsheet
  '((name . "Cheatsheet")
    (candidates . (lambda () cheatsheet-candidates))
    (action . show-cheatsheet)))

(defun my-helm ()
  (interactive)
  (helm-mini))


(setq helm-mini-default-sources '(helm-source-buffers-list
                                  helm-source-switch-project
                                  helm-source-run-configuration
                                  helm-source-cheatsheet
                                  helm-source-recentf))

(setq my-helm-keybind (kbd "C-]"))
(global-set-key my-helm-keybind 'my-helm)
(define-key helm-map my-helm-keybind 'abort-recursive-edit)
(global-set-key (kbd "M-]") 'helm-show-kill-ring)
