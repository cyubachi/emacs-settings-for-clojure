(defvar my/favorite-packages
  '(
    magit
    clojure-mode
    cider
    ac-cider
    rainbow-delimiters
    anything
    monokai-theme
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

;; font setting
(add-to-list 'default-frame-alist
             '(font . "DejaVu Sans Mono-10"))

;; screen maximize setting
(set-frame-parameter nil 'fullscreen 'maximized)

;; hide toolbar setting
(tool-bar-mode -1)

;; magit-config
(global-set-key (kbd "C-x g") 'magit-status)

;; anythin setting
(require 'anything)
(setq my-anything-keybind (kbd "C-]"))
(global-set-key my-anything-keybind 'anything-for-files)
(define-key anything-map my-anything-keybind 'abort-recursive-edit)
