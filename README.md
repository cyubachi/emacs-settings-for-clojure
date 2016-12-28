Emacs Clojure settings.
====

Overview

## Description

This project is under construction.

These setting files summarize plugins and config which are useful to write Clojure and ClojureScript.

This setting files use plugins as follows.

* init-loader
* magit
* clojure-mode
* cider
* company
* rainbow-delimiters
* anything
* monokai-theme
* exec-path-from-shell
* tabbar
* neotree
* switch-window
* f
* find-file-in-project
* window-purpose
* flycheck-clojure
* flycheck-pos-tip

## Demo

## Requirement

Maybe Emacs version 24.5.1 higher (test only version 24.5.1 on Ubuntu)

## Usage

Please refer each of the document, how to use of installed plugins.

#### cusotom key bind

* `C-]` toggle anything buffer
* `M-]` show kill ring buffer
* `C-c f` indent file
* `C-c r` search file
* `C-c ;` comment or uncomment region
* `C-x g` exec magit-status
* `f8` exec toggle-neotree
* `f12` exec eval-buffer

#### window state

If workgroups mode is enabled, emacs window state is automatically saved in `~/workgroups`.
When you boot emacs in the next time, the window state is automatically restored to the state that was saved last time.

#### leiningen profile

This settings set the `cider-lein-parameters` as `with-profile +dev repl :headless`.
If you want to custom this parameter, you can create a setting file that named like `10_custom_settings.el`,
and write setting like as follow.

```
(custom-set-variables
  '(cider-lein-parameters "repl :headless")) ;; this is default cider-lein-parameters
(custom-set-faces)
```

#### 

## Install

```
cd /path/to/setting-files
git clone https://github.com/cyubachi/emacs-settings-for-clojure.git
ln -s /path/to/setting-files/.emacs.d ~/.emacs.d
```

## Contribution

## Licence

[MIT](https://github.com/tcnksm/tool/blob/master/LICENCE)

## Author

[cyubachi](https://github.com/cyubachi)