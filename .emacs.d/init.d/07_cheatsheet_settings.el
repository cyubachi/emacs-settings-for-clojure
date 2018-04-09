(require 'cheatsheet)
;; cheatsheet
(defun custom-cheatsheet-show ()
  "Create buffer and show cheatsheet."
  (interactive)
  (switch-to-buffer "*cheatsheet*")
  (cheatsheet-mode)
  (erase-buffer)
  (insert (cheatsheet--format))
  (setq buffer-read-only t)
  (beginning-of-buffer))


(cheatsheet-add-group 'Common
                      '(:key "C-x C-c" :description "leave Emacs")
                      '(:key "C-x C-f" :description "find file"))

(cheatsheet-add-group 'Navigation
                      '(:key "C-l" :description "Center the page on point")
                      '(:key "C-v" :description "Move down a page")
                      '(:key "M-v" :description "Move up a page")
                      '(:key "C-M-p" :description "Scroll half a page up")
                      '(:key "C-M-n" :description "Scroll half a page down")
                      '(:key "C-f" :description "Move forward a character")
                      '(:key "C-b" :description "Move backward a character")
                      '(:key "M-f" :description "Move forward a word")
                      '(:key "M-b" :description "Move backward a word")
                      '(:key "C-n" :description "Move to next line")
                      '(:key "C-p" :description "Move to previous line")
                      '(:key "C-a" :description "Move to beginning of line")
                      '(:key "C-e" :description "Move to end of line")
                      '(:key "M-a" :description "Move back to beginning of sentence")
                      '(:key "M-e" :description "Move forward to end of sentence")
                      '(:key "M-<" :description "(META Less-than) Move to beginning of whole text")
                      '(:key "M->" :description "(META Greater-than) Move to end of whole")
                      '(:key "M-g M-g" :description "Go to line"))

(cheatsheet-add-group 'Editing
                      '(:key "<DEL>" :description "Delete the character just before the")
                      '(:key "C-d" :description "Delete the next character after the")
                      '(:key "M-<DEL>" :description "Kill the word immediately before the")
                      '(:key "M-d" :description "Kill the next word after the cursor")
                      '(:key "C-k" :description "Kill from the cursor position to end of line")
                      '(:key "M-k" :description "Kill to the end of the current sentence")
                      '(:key "C-<SPC>" :description "Mark start of region")
                      '(:key "C-w" :description "Kill text in marked region")
                      '(:key "C-y" :description "Yank text to current position")
                      '(:key "M-y" :description "Yank text that was previously killed")
                      '(:key "C-/" :description "Undo")
                      '(:key "C-_" :description "Undo")
                      '(:key "C-x u" :description "Undo")
                      '(:key "C-s" :description "Search forward")
                      '(:key "C-r" :description "Search reverse")
                      '(:key "C-s C-s" :description "Repeat previous search forward")
                      '(:key "C-r C-r" :description "Repeat previous search reverse")
                      '(:key "M-q or M-x fill-paragraph" :description "Reindent paragraph (See http://www.emacswiki.org/emacs/FillParagraph)"))

(cheatsheet-add-group 'Case
                      '(:key "M-l" :description "Convert following word to lower case (downcase-word).")
                      '(:key "M-u" :description "Convert following word to upper case (upcase-word).")
                      '(:key "M-c" :description "Capitalize the following word (capitalize-word).")
                      '(:key "C-x C-l" :description "Convert region to lower case (downcase-region).")
                      '(:key "C-x C-u" :description "Convert region to upper case (upcase-region)."))

(cheatsheet-add-group 'Selecting\ Text
                      '(:key "M-@" :description "word select")
                      '(:key "C-x h" :description "runs the command mark-whole-buffer"))

(cheatsheet-add-group 'Indent
                      '(:key "C-M-\\" :description "runs the command indent-region"))
(cheatsheet-add-group 'Files\ and\ Buffers
                      '(:key "C-x C-b" :description "List buffers")
                      '(:key "C-x C-f" :description "Find file")
                      '(:key "C-x C-s" :description "Save file")
                      '(:key "C-x k" :description "Kill buffer")
                      '(:key "C-x s" :description "Save some buffers")
                      '(:key "C-x C-b" :description "List buffers")
                      '(:key "C-x b" :description "Switch")
                      '(:key "C-x 1" :description "Delete all but one window")
                      '(:key "C-x 2" :description "Open 2nd window")
                      '(:key "C-x o" :description "Switch to 'other' window"))

(cheatsheet-add-group 'Modes
                      '(:key "M-x mode" :description "Switch to major mode, 'mode'")
                      '(:key "C-h m" :description "Read documentation for current major mode"))


(global-set-key (kbd "C-c c") 'custom-cheatsheet-show)

;; original
;; (define-key cheatsheet-mode-map (kbd "C-q") 'kill-buffer-and-window)
;; (define-key cheatsheet-mode-map (kbd "C-q") 'kill-buffer)

(defun cheatsheet-quit-keybind ()
  (local-set-key "q" 'kill-this-buffer))

(add-hook 'cheatsheet-mode-hook  'cheatsheet-quit-keybind)
