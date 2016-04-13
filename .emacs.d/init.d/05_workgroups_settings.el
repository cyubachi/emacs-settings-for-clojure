(add-to-list 'load-path "~/workgroups/workgroups.el")
(setq wg-prefix-key (kbd "C-c w"))
(require 'workgroups)
(wg-load "~/workgroups/wg01")
(add-hook 'auto-save-hook
          (lambda ()
            (wg-update-all-workgroups)
            (wg-save "~/workgroups/wg01")))
(add-hook 'kill-emacs-hook
          (lambda ()
            (wg-update-all-workgroups)
            (wg-save "~/workgroups/wg01")))


(workgroups-mode 1)
(require 'switch-window)
(select-window (third (switch-window--list)))

(defun display-main-window (buffer alist)
  (window--display-buffer buffer (second (switch-window--list)) 'reuse))
(defun display-third-window (buffer alist)
  (select-window (nth 2 (switch-window--list)))
  (window--display-buffer buffer (nth 2 (switch-window--list)) 'reuse))
(defun display-forth-window (buffer alist)
  (select-window (nth 3 (switch-window--list)))
  (window--display-buffer buffer (nth 3 (switch-window--list)) 'reuse))

(setq inhibit-startup-screen t)
(setq display-buffer-alist
      '(("*anything.*?*" . (display-forth-window . nil))
        ("*cider.*?*" . (display-forth-window . nil))
        ("*eshell.*?*" . (display-third-window . nil))))

(eshell)
