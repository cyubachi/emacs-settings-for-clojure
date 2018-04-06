;; neotree settings.
;; (setq neo-smart-open t)
(setq-default neo-show-hidden-files t)
(setq neo-show-hidden-files t)
(require 'neotree)
;; (setq neo-show-hidden-files t)
(neotree)
(global-set-key [f8] 'neotree-toggle)
;; (neotree-hidden-file-toggle)

;; popwin との共存
(when neo-persist-show
  (add-hook 'popwin:before-popup-hook
            (lambda () (setq neo-persist-show nil)))
  (add-hook 'popwin:after-popup-hook
            (lambda () (setq neo-persist-show t))))
