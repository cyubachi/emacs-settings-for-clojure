;; magit-config
(global-set-key (kbd "C-x g") 'magit-status)

(setq magit-display-buffer-function
      (lambda (buffer)
        (display-buffer buffer '(display-buffer-same-window))))
