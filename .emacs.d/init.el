(defvar my/favorite-packages
  '(
    magit
    clojure-mode
    cider
    ac-cider
    rainbow-delimiters
    anything
    monokai-theme
    exec-path-from-shell
    ))

(defvar my/favorite-package-urls
  '(
    "http://namazu.org/~tsuchiya/elisp/dabbrev-ja.el"
    "http://homepage3.nifty.com/oatu/emacs/archives/auto-save-buffers.el"
    ))

(defun package-install-from-url (url)
  (interactive "sURL: ")
  (let ((file (and (string-match "\\([a-z0-9-]+\\)\\.el" url) (match-string-no-properties 1 url))))
    (with-current-buffer (url-retrieve-synchronously url)
      (goto-char (point-min))
      (delete-region (point-min) (search-forward "\n\n"))
      (goto-char (point-min))
      (setq info (cond ((condition-case nil (package-buffer-info) (error nil)))
                       ((re-search-forward "[$]Id: .+,v \\([0-9.]+\\) .*[$]" nil t)
                        (vector file nil (concat "[my:package-install-from-url]") (match-string-no-properties 1) ""))
                       (t (vector file nil (concat file "[my:package-install-from-url]") (format-time-string "%Y%m%d") ""))))
      (package-install-from-buffer info 'single)
      (kill-buffer)
      )))

(defun package-url-installed-p (url)
  (interactive "sURL: ")
  (let ((pkg-name (and (string-match "\\([a-z0-9-]+\\)\\.el" url) (match-string-no-properties 1 url))))
    (package-installed-p (intern pkg-name))))

(eval-when-compile
  (require 'cl))

(when (require 'package nil t)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives
               '("marmalade" . "http://marmalade-repo.org/packages/") t)
  (package-initialize)
  (let ((pkgs (loop for pkg in my/favorite-packages
                    unless (package-installed-p pkg)
                    collect pkg)))
    (when pkgs
      ;; check for new packages (package versions)
      (message "%s" "Get latest versions of all packages...")
      (package-refresh-contents)
      (message "%s" " done.")
      (dolist (pkg pkgs)
        (package-install pkg))))
  (let ((urls (loop for url in my/favorite-package-urls
                    unless (package-url-installed-p url)
                    collect url)))
    ))

;; display line number
(global-linum-mode t)

;; load monokai theme
(load-theme 'monokai t)

;; auto-complete setting
(ac-config-default)

;; clojure settings
(require 'clojure-mode)
(require 'cider)
(add-hook 'clojure-mode-hook 'cider-mode)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(require 'ac-cider)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))

;; rainbow-delimiters
(show-paren-mode t)
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(require 'cl-lib)
(require 'color)
(defun rainbow-delimiters-using-stronger-colors ()
  (interactive)
  (cl-loop
   for index from 1 to rainbow-delimiters-max-face-count
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
     (cl-callf color-saturate-name (face-foreground face) 30))))
(add-hook 'emacs-startup-hook 'rainbow-delimiters-using-stronger-colors)

;; reload buffer on F12 key
(global-set-key
 [f12] 'eval-buffer)


;; hide toolbar setting
(tool-bar-mode -1)

;; magit-config
(global-set-key (kbd "C-x g") 'magit-status)

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

;; dirtree setting
;; (require 'dirtree)


;; nodejs-repl setting
;; (require 'nodejs-repl)

;; japanese setting
(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)


;; indent whole buffer
(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))
(global-set-key (kbd "C-c f") 'iwb)

;; javascript indent setting
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(setq js-indent-level 2)
(setq js2-mode-hook
      '(lambda ()
         (setq js2-basic-offset 2)
         (setq tab-width 2)))

;; tab-character disable setting
(setq-default indent-tabs-mode nil)

;; jade mode setting
(require 'jade-mode)

;; gulpjs setting this setting need git clone.
(when (file-exists-p "~/.emacs.d/emacs-gulpjs")
  (add-to-list 'load-path "~/.emacs.d/emacs-gulpjs")
  (require 'gulpjs))

;; screen maximize setting
(set-frame-parameter nil 'fullscreen 'maximized)
