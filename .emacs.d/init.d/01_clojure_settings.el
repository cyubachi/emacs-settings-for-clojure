(require 'clojure-mode)
(require 'cider)
(require 'company)

(setq company-idle-delay 0)
(setq company-minimum-prefix-length 2)
(setq company-selection-wrap-around t)
;; (require 'ac-cider)

;;; Code:
(add-hook 'clojure-mode-hook 'cider-mode)
(add-hook 'clojure-mode-hook 'company-mode)
;;(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
;;(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'company-mode)
;;(eval-after-load "auto-complete"
;;  '(progn
;;     (add-to-list 'ac-modes 'cider-mode)
;;     (add-to-list 'ac-modes 'cider-repl-mode)))

;; don't display control character on figwheel_server.log
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(add-hook 'fundamental-mode-hook 
          'ansi-color-for-comint-mode-on)

;; dont make "nprepl-message*" buffer
(setq nrepl-log-messages nil)

;; rainbow-delimiters
(show-paren-mode t)
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(require 'cl-lib)
(require 'color)
(require 'flycheck)
(require 'flycheck-pos-tip)

(defun rainbow-delimiters-using-stronger-colors ()
  (interactive)
  (cl-loop
   for index from 1 to rainbow-delimiters-max-face-count
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
     (cl-callf color-saturate-name (face-foreground face) 30))))
(add-hook 'emacs-startup-hook 'rainbow-delimiters-using-stronger-colors)


;; for flycheck-clojure
(eval-after-load 'flycheck '(flycheck-clojure-setup))
(add-hook 'after-init-hook #'global-flycheck-mode)

(eval-after-load 'flycheck
  '(setq flycheck-display-errors-function #'flycheck-pos-tip-error-messages))

;; for cljs repl
(custom-set-variables
  '(cider-inject-dependencies-at-jack-in nil)
  '(cider-lein-parameters "repl :headless")) ;; this is default cider-lein-parameters
(custom-set-faces)

(setq cider-cljs-lein-repl
      "(do (require 'figwheel-sidecar.repl-api)
           (figwheel-sidecar.repl-api/start-figwheel!)
           (figwheel-sidecar.repl-api/cljs-repl))")

(provide '01_clojure_settings)
;;; 01_clojure_settings.el ends here
