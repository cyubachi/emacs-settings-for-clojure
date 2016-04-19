;; anythin setting
(require 'anything)
(setq my-anything-keybind (kbd "C-]"))
(global-set-key (kbd "M-]") 'anything-show-kill-ring)
(global-set-key my-anything-keybind 'anything-for-files)
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

(setq run-congiguration-candidates (list-defined-functions-in-file "~/.emacs.d/init.d/99_run_configuration.el"))
(defvar anything-c-source-print-test
  '((name . "Run configuration")
    (candidates . (lambda () run-congiguration-candidates))
    (type . command)))
