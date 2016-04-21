;; anythin setting
(require 'anything)
(require 'anything-config)
(require 'f)

;; for switch project sources
(defvar emacs-project-dir "~/EmacsProjects")

(setq switch-project-candidates
      (if (file-exists-p emacs-project-dir)
          (loop for x in (split-string (shell-command-to-string (format "cd %s && ls -1F | egrep [/@] | sed 's|[/@]||g'" emacs-project-dir)) "\n")
                unless (s-blank? x)
                collect x)
        ()))

(defun switch-project (project-dir-name)
  (setq ffip-project-root (format "%s/%s" emacs-project-dir project-dir-name))
  (neotree-dir ffip-project-root))

(defvar anything-c-source-switch-project
  '((name . "Switch Project")
    (candidates . (lambda () switch-project-candidates))
    (action . switch-project)))


(defun list-defined-functions-in-file (file)
  (-map 'cadr (s-match-strings-all "defun \\(exec-.*?\\) "
                                   (f-read file))))

(setq run-congiguration-candidates (list-defined-functions-in-file "~/.emacs.d/init.d/99_run_configuration.el"))
(defvar anything-c-source-run-configuration
  '((name . "Run configuration")
    (candidates . (lambda () run-congiguration-candidates))
    (type . command)))

(defun my-anything ()
  (interactive)
  (anything-other-buffer
   '(anything-c-source-buffers-list
     anything-c-source-run-configuration
     anything-c-source-switch-project
     anything-c-source-recentf
     anything-c-source-files-in-current-dir+)
   "*anything*"))

(setq my-anything-keybind (kbd "C-]"))
(global-set-key (kbd "M-]") 'anything-show-kill-ring)
(global-set-key my-anything-keybind 'my-anything)
(define-key anything-map my-anything-keybind 'abort-recursive-edit)

;; sticky buffer mode setting
(defvar sticky-buffer-previous-header-line-format)
(define-minor-mode sticky-buffer-mode
  "Make the current window always display this buffer."
  nil " sticky" nil
  (if sticky-buffer-mode
      (progn
        (set (make-local-variable 'sticky-buffer-previous-header-line-format)
             header-line-format)
        (set-window-dedicated-p (selected-window) sticky-buffer-mode))
    (set-window-dedicated-p (selected-window) sticky-buffer-mode)
    (setq header-line-format sticky-buffer-previous-header-line-format)))

(require 'anything-startup)
(anything-complete-shell-history-setup-key (kbd "C-o"))

;; (remove-if 'filter-project-dir (split-string (shell-command-to-string "ls -F ~/clojure-projects | grep /") "\n"))
