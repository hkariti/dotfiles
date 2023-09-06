(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(setq server-name "emacsmux")
(server-start)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")))
(setq help-window-select t)
(use-package vterm
    :ensure t)
(add-hook 'after-make-frame-functions (lambda (frame) (select-frame frame) (vterm t)))
(add-hook 'tab-bar-tab-prevent-close-functions '(lambda (w islast) (when islast t)))
(add-hook 'vterm-exit-functions '(lambda (a b) (kill-buffer) (if (= 1 (count-windows)) (tab-close) (delete-window))))
(keymap-global-set "s-S" '(lambda () (interactive) (split-window-below) (vterm t)))
(keymap-global-set "s-|" '(lambda () (interactive) (split-window-right) (vterm t)))
(keymap-global-set "s-C" 'mux-new-window)
;(setq initial-major-mode 'vterm-mode)
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config))

(defun mux-new-window ()
  (interactive)
  (unless (string= (buffer-name) "*scratch*") (tab-new))
  (vterm t))

(mux-new-window)
