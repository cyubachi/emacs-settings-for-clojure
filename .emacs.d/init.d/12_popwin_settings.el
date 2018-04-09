;; popwin.el
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:popup-window-position 'bottom)
(push '("*Google Translate*") popwin:special-display-config)
(push '("*helm mini*") popwin:special-display-config)
(push '("*helm kill ring*") popwin:special-display-config)
