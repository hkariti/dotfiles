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

(defun mux-kill-buffer-hook ()
  ;(kill-buffer)
  (if (= 1 (count-windows))
    (tab-close)
    (delete-window)))

(defun mux-init-hooks ()
    (put 'vterm-shell 'permanent-local t)
    (put 'vterm-kill-buffer-on-exit 'permanent-local t)
    (add-hook 'kill-buffer-hook 'mux-kill-buffer-hook))
    (add-hook 'after-make-frame-functions 'mux-new-frame-hook)
    (add-hook 'tab-bar-tab-prevent-close-functions 'mux-close-tab-hook)

(defun mux-create (&optional name command remain-on-exit)
  "Create a new terminal buffer in the background"
  (interactive)
  (let* (
         (major-mode 'fundamental-mode)
         (buf (generate-new-buffer vterm-buffer-name)))
    (with-current-buffer buf
      (setq-local vterm-shell (if command (format "%s -c %s" vterm-shell (shell-quote-argument command)) vterm-shell))
      (setq-local vterm-kill-buffer-on-exit (if remain-on-exit nil vterm-kill-buffer-on-exit))
      (vterm-mode)
    )
    buf))

(defun mux-create-and-switch (&optional name command remain-on-exit)
  "Create a new terminal buffer and switch the current window to it"
  (interactive)
  (pop-to-buffer-same-window (mux-create name command remain-on-exit)))

(defun mux-split-window-horizontal (&optional name command remain-on-exit)
  "Create a new terminal buffer in a split below the current window"
  (interactive)
  (split-window nil nil 'above)
  (mux-create-and-switch name command remain-on-exit))

(defun mux-split-window-vertical (&optional name command remain-on-exit)
  "Create a new terminal buffer in a split to the right of the current window"
  (interactive)
  (split-window nil nil 'left)
  (mux-create-and-switch name command remain-on-exit))

(defun mux-new-tab (&optional name command remain-on-exit)
  "Create a new terminal buffer in a new tab"
  (interactive)
  (unless (string= (buffer-name) "*scratch*") (tab-new))
  (mux-create-and-switch name command remain-on-exit))

(keymap-global-set "s-S" 'mux-split-window-horizontal)
(keymap-global-set "s-|" 'mux-split-window-vertical)
(keymap-global-set "s-C" 'mux-new-tab)

(mux-init-hooks)
(mux-new-tab)
