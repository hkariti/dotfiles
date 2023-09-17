(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(setq server-name "emacsmux")
(server-start)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")))
(setq help-window-select t)
(use-package vterm
    :ensure t)
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config))

(defun mux-close-tab-hook (w islast)
  (when islast
    (unless (= 1 (length (frame-list))) (delete-frame))
    (switch-to-buffer "*scratch*")
    t))

(defun mux-new-frame-hook (frame)
  (select-frame frame)
  (mux-create))

(defun mux-vterm-exit-hook (a b)
  (kill-buffer)
  (if (= 1 (count-windows))
    (tab-close)
    (delete-window)))

(defun mux-create (&optional name command)
  "Create a new terminal buffer"
  (interactive)
  (let ((vterm-shell (if command
                       (format "%s -c %s" vterm-shell (shell-quote-argument command))
                       vterm-shell))
        (name (or name t)))
      (vterm name)))

(defun mux-split-window-horizontal (&optional name command)
  (interactive)
  (split-window-below)
  (mux-create name command))

(defun mux-split-window-vertical (&optional name command)
  (interactive)
  (split-window-right)
  (mux-create name command))

(defun mux-init-hooks ()
    (add-hook 'vterm-exit-functions 'mux-vterm-exit-hook))
    (add-hook 'after-make-frame-functions 'mux-new-frame-hook)
    (add-hook 'tab-bar-tab-prevent-close-functions 'mux-close-tab-hook)

(defun mux-new-window (&optional name command)
  (interactive)
  (unless (string= (buffer-name) "*scratch*") (tab-new))
  (mux-create name command))

(keymap-global-set "s-S" 'mux-split-window-horizontal)
(keymap-global-set "s-|" 'mux-split-window-vertical)
(keymap-global-set "s-C" 'mux-new-window)

(mux-init-hooks)
(mux-new-window)
