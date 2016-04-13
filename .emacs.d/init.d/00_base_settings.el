;; display line number
(global-linum-mode t)

;; load monokai theme
(load-theme 'monokai t)

;; auto-complete setting
(ac-config-default)

;; reload buffer on F12 key
(global-set-key
 [f12] 'eval-buffer)

;; hide toolbar setting
(tool-bar-mode -1)

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

;; tab-character disable setting
(setq-default indent-tabs-mode nil)

;; screen maximize setting
(set-frame-parameter nil 'fullscreen 'maximized)

(add-hook 'set-language-environment-hook
          (lambda ()
            (when (equal "ja_JP.UTF-8" (getenv "LANG"))
              (setq default-process-coding-system '(utf-8 . utf-8))
              (setq default-file-name-coding-system 'utf-8))
            (when (equal "Japanese" current-language-environment)
              (setq default-buffer-file-coding-system 'iso-2022-jp))))

(set-language-environment "Japanese")
(set-default 'buffer-file-coding-system 'utf-8)
