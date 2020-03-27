;;; init.el --- Initialization file for Exmacs
;;; Commentary: Emacs Startup File --- initialization for Emacs

;;; Code:

(global-linum-mode t)
;(set-face-background 'linum "light grey")

(setq initial-frame-alist '((top . 30) (left . 30)
 			    (width . 91) (height . 30)))

(setq default-frame-alist '((top . 30) (left . 30)
 			    (width . 91) (height . 30)))

(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-13"))

; shell mode hook
(setq ansi-color-names-vector ; better contrast colors
      ["black" "red4" "green4" "yellow4"
       "blue3" "magenta4" "cyan4" "white"])
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)

(add-hook 'shell-mode-hook
     '(lambda () (toggle-truncate-lines 1)))
(setq comint-prompt-read-only t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setenv "PS1" "[\\W] \\$ ")
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(setq exec-path (cons "/usr/local/bin" exec-path))

(setq select-enable-primary t)
(setq select-enable-clipboard t)

(fset 'yes-or-no-p 'y-or-n-p)
(setq frame-title-format
      '((:eval (user-real-login-name))
	"=>"
	(:eval (buffer-file-name))))

(setq display-time-mail-string "")
(setq display-time-interval 1)
(setq display-time-format "%Y-%m-%d %H:%M:%S")
(display-time-mode)

; print current opened file
(defun print_file_name()
  "Print current file buffer name."
  (interactive)
  (message "File: %s" buffer-file-name)
  )

(global-set-key (kbd "C-c n") 'print_file_name)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)

(package-initialize)

(load-theme 'solarized-dark t)
(setq debug-on-error t)

;; parenth
(show-paren-mode t)
(electric-pair-mode t)
(setq show-paren-style 'parentheses)

;; sr-speedbar
(setq sr-speedbar-default-width 30)
(setq sr-speedbar-max-width 40)
(setq sr-speedbar-right-side nil)
(global-set-key (kbd "s-s") 'sr-speedbar-toggle)

(global-auto-revert-mode 1)

;; on Mac
;(setenv "LD_LIBRARY_PATH" (concat "/Library/Developer/CommandLineTools/usr/lib" (getenv "LD_LIBRARY_PATH")))

;; flycheck
(require 'flycheck)
;;(global-flycheck-mode)

;; projectile
(require 'projectile)
(projectile-mode)
(global-set-key (kbd "C-c f o") 'projectile-find-other-file)

;; company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay .2)
(setq company-minimum-prefix-length 2)

;; setup irony
(defun setup_irony()
  "Set up irony."
  (progn
    (message "Seting up irony...")
    ;; irony
    (require 'irony)
    ;; If irony server was never installed, install it.
    (unless (irony--find-server-executable) (call-interactively #'irony-install-server))
    (add-hook 'c++-mode-hook 'irony-mode)
    (add-hook 'c-mode-hook 'irony-mode)
    ;; Use compilation database first, clang_complete as fallback.
    (setq-default irony-cdb-compilation-databases '(irony-cdb-libclang
						    irony-cdb-clang-complete))
    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

    ;; use irony with company to get code completion.
    (require 'company-irony)
    (eval-after-load 'company '(add-to-list 'company-backends 'company-irony))

    ;; use irony with flycheck to get real-time syntax checking.
    (require 'flycheck-irony)
    (eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

    ;; Eldoc shows argument list of the function you are currently writing in the echo area.
    (require 'irony-eldoc)
    (add-hook 'irony-mode-hook #'irony-eldoc)))


;; setup Rtags
(defun setup_rtags ()
  "Set up rtags."
  (progn
    (message "Seting up Rtags ...")
    ;; RTags
    (require 'rtags)
    (unless (rtags-executable-find "rc") (error "Binary rc is not installed!"))
    (unless (rtags-executable-find "rdm") (error "Binary rdm is not installed!"))

    (add-hook 'c-mode-hook 'rtags-start-process-unless-running)
    (add-hook 'c++-mode-hook 'rtags-start-process-unless-running)

    (define-key c-mode-base-map (kbd "M-.") 'rtags-find-symbol-at-point)
    (define-key c-mode-base-map (kbd "M-[") 'rtags-find-symbol)
    (define-key c-mode-base-map (kbd "M-,") 'rtags-find-references-at-point)
    (define-key c-mode-base-map (kbd "M-]") 'rtags-find-references)
    (define-key c-mode-base-map (kbd "M-?") 'rtags-display-summary)
    (rtags-enable-standard-keybindings)
    ;; Shutdown rdm when leaving emacs.
    (add-hook 'kill-emacs-hook 'rtags-quit-rdm)

    ;; Use rtags for auto-completion.
    (require 'company-rtags)
    (setq rtags-autostart-diagnostics t)
    (rtags-diagnostics)
    (setq rtags-completions-enabled t)
    (push 'company-rtags company-backends)

    ;; Live code checking.
    (require 'flycheck-rtags)

    ;; ensure that we use only rtags checking
    ;; https://github.com/Andersbakken/rtags#optional-1
    (defun setup-flycheck-rtags ()
      (flycheck-select-checker 'rtags)
      (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
      (setq-local flycheck-check-syntax-automatically nil)
      (rtags-set-periodic-reparse-timeout 2.0)  ;; Run flycheck 2 seconds after being idle.
      )
    (add-hook 'c-mode-hook #'setup-flycheck-rtags)
    (add-hook 'c++-mode-hook #'setup-flycheck-rtags)))

;;(setup_irony)
(setup_rtags)

;; (window-numbering-mode)
;; (require 'smex)
;; (smex-initialize)

(setq ecb-tip-of-the-day nil)
(setq stack-trace-on-error t)
(autoload 'speedbar-frame-mode "speedbar" "Popup a speedbar frame" t)
(autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t)

;; (require 'ecb-autoloads)
;; (require 'cflow-mode)

;; active yasnippet
(require 'yasnippet)
(yas-global-mode 1)

(setq-default mode-line-format
                '("%e"
                  mode-line-mule-info
                  mode-line-modified
                  " "
                  mode-line-position
                  (vc-mode vc-mode)
		  " "
                  mode-line-modes
                  (which-func-mode ("" which-func-format))
		  (global-mode-string ("" global-mode-string))
		  " "
		  ;(:eval (buffer-file-name))
		  "%-"
		  ))

(setq make-backup-files nil)
(setq auto-save-mode nil)
(setq auto-save-default nil)
(setq inhibit-startup-message t)
(setq column-number-mode t)
(blink-cursor-mode nil)
(setq imenu-list-position 'left)

(setq server-use-tcp t)
(setq server-port 9998)

(put 'downcase-region 'disabled nil)

(desktop-save-mode 1)
(setq desktop-dirname "~/.emacs.d")

;; tabs
(defun how-many-region (begin end regexp &optional interactive)
  "Print number of non-trivial matche for REGEXP in region.
Non-interactive arguments are BEGIN END Regexp."
  (interactive "r\nsHow many matches for (regexp): \np")
  (let ((count 0) opoint)
    (save-excursion
      (setq end (or end (point-max)))
      (goto-char (or begin (point)))
      (while (and (< (setq opoint (point)) end)
                  (re-search-forward regexp end t))
        (if (= opoint (point))
            (forward-char 1)
          (setq count (1+ count))))
      (if interactive (message "%d occurrences" count))
      count)))

(defun infer-indentation-style ()
  "If our source file use tabs, we use tabs, if spaces spaces."
  "and if neither, we use the current indent-tabs-mode."
  (let ((space-count (how-many-region (point-min) (point-max) "^  "))
        (tab-count (how-many-region (point-min) (point-max) "^\t")))
    (if (> space-count tab-count) (setq indent-tabs-mode nil))
    (if (> tab-count space-count) (setq indent-tabs-mode t))))

(setq-default tab-width 8)
;; smart tabs mode set
(setq-default indent-tabs-mode nil)
(add-hook 'c-mode-hook
          (lambda ()
            (infer-indentation-style)))

(add-hook 'c++-mode-hook
          (lambda ()
            (infer-indentation-style)))

;; tab-stop-list
(setq tab-stop-list (number-sequence 4 120 4))

;; ggtags
;; (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             (when (derived-mode-p 'c-mode 'c++-mode)
;;               (ggtags-mode 1))))

;; astyle
(defun astyle-code()
  "Use astyle command tools to format c/c++ code."
  (interactive)
  (message "Use astyle(k&r) to format code ...")
  (call-process-shell-command (format "astyle --style=kr -n %s" buffer-file-name) nil "astyle-output" t)
  (revert-buffer t t)
  )

(defun astyle-code-dir(dir)
  "Use astyle command tools to format c/c++ code under DIR."
  (interactive "DDirectory to format: ")
  (if dir
      (progn
        (message "Use astyle(k&r) to format code under %S ..." dir)
        (if (string-prefix-p "~/" dir)
            (progn
              (setq dir (concat (getenv "HOME") "/" (substring dir 2)))
              )
          )
        (if (string-suffix-p "/" dir)
            (setq dir (substring dir 0 -1))
            )
        (call-process-shell-command (format "astyle --style=kr -n -R \"%s/*.c\" \"%s/*.cpp\" \"%s/*.h\""  dir dir dir)
                                    nil "astyle-output" t)
        ))
  (revert-buffer t t)
  )

(global-set-key (kbd "C-c C-f") 'astyle-code)
(global-set-key (kbd "C-c p") 'astyle-code-dir)
;; (require 'ecb)
(defun custom_ecb ()
"Set my custom ecb configure."
(interactive)
(progn

  (defecb-window-dedicator ecb-set-cscope-buffer " *ECB cscope-buf*"
    "create ecb cscope buffer"
    (switch-to-buffer "*cscope*"))

  ;; a simple ecb-layout
  (ecb-layout-define "my-ecb-layout" left nil
		     (ecb-set-methods-buffer)
		     (ecb-split-ver 0.5 t)
		     (other-window 1)
		     (ecb-set-sources-buffer)
		     (other-window 1)
					;(ecb-set-cscope-buffer)
					;(ecb-split-ver 0.2 t)
		     (select-window (next-window)))

  (setq ecb-show-sources-in-directories-buffer "my-ecb-layout")
  ))

(defvar cmd nil nil)
(defvar cflow-buf nil nil)
(defvar cflow-buf-name nil nil)

(defun get-cflow (function-name)
  "Get call graph of input function FUNCTION-NAME."
  (interactive
   ;(list (car (senator-jump-interactive "Function name:" nil nil nil))))
   "sFunction name:\n")
  (message function-name)
  (setq cmd (format "cflow -b --main=%s %s" function-name buffer-file-name))
  (setq cflow-buf-name (format "** cflow-%s:%s **"
			       (file-name-nondirectory buffer-file-name)
			       function-name))
  (setq cflow-buf (get-buffer-create cflow-buf-name))
  (set-buffer cflow-buf)
  (setq buffer-read-only nil)
  (erase-buffer)
  (insert (shell-command-to-string cmd))
  (pop-to-buffer cflow-buf)
  (goto-char (point-min))
  (cflow-mode)
)

(defvar ecb-flag nil nil)

(defun start-ecb()
  "Start ecb."
  (interactive)
  (if (not ecb-flag)
      (progn
	;;(setq ecb-layout-name "my-ecb-layout")
	(setq ecb-windows-width 0.25)
	(ecb-activate)
	(setq ecb-flag "started"))
      nil))

(defun stop-ecb()
  "Stop ecb."
  (interactive)
  (if ecb-flag
      (progn
	(ecb-deactivate)
	(setq ecb-flag nil))
      nil))

(add-hook 'python-mode-hook
	  (lambda ()
	    (setq python-indent 4)
		))

(prefer-coding-system 'utf-8)

(c-add-style "qemu"
	     '((c-basic-offset . 4)
	      (c-comment-only-line-offset . 0)
	      (c-hanging-braces-alist
	       (brace-list-open)
	       (brace-entry-open)
	       (substatement-open after)
	       (block-close . c-snug-do-while)
	       (arglist-cont-nonempty))
	      (c-cleanup-list brace-else-brace)
	      (c-offsets-alist
	       (statement-block-intro . +)
	       (knr-argdecl-intro . 0)
	       (substatement-open . 0)
	       (substatement-label . 0)
	       (label . 0)
	       (statement-cont . +))))

(defun qemu-c-mode()
  "C mode with qemu develop style."
  (interactive)
  (setq indent-tabs-mode nil)
  (setq c-indent-level 4)
  (setq c-basic-offset 4))

(add-hook 'c++-mode-hook
	  (lambda ()
	    (c-set-style "stroustrup")
))

(add-hook 'c-mode-hook
	  (lambda ()
            (if buffer-file-name
                (if (string-match-p ".*/qemu[^/]*/.*\\.[ch]" buffer-file-name)
                    (qemu-c-mode)
                  (if (string-match-p ".*/\\(kernel\\|linux\\)[^/]*/.*\\.[Sch]" buffer-file-name)
                      (c-set-style "linux")
                    (c-set-style "stroustrup"))))))

; maximum screen
(defun full-screen()
  "Maximum current screen."
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32 '(2 "_NET_WM_STATE_FULLSCREEN" 0))
  (if ecb-flag
      (progn
	(stop-ecb)
	(start-ecb))
      nil))

(defun max-horizon()
  "Maximum size horizon."
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))
(defun max-vertical()
  "Maximum size vertical."
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))

(defun max-size()
  "Maximun size."
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (if ecb-flag
      (progn
	(stop-ecb)
	(start-ecb))
      nil))

;; easy copy functions
(defun copy-line (&optional arg)
  "Save current line into Kill-Ring without mark the ARG lines."
  (interactive "P")
  (let ((beg (line-beginning-position))
	(end (line-end-position arg)))
    (copy-region-as-kill beg end)))

(defun copy-word (&optional arg)
  "Copy ARG words at point."
  (interactive "P")
  (let ((beg (progn (if (looking-back "[0-9a-zA-Z]" 1)
			(backward-word 1))
		    (point)))
	(end (progn (forward-word arg) (point))))
    (copy-region-as-kill beg end)))

(defun copy-paragraph (&optional arg)
  "Copy ARG paragraphes at point."
  (interactive "P")
  (let ((beg (progn (backward-paragraph 1) (point)))
	(end (progn (forward-paragraph arg) (point))))
    (copy-region-as-kill beg end)))

(defun set-region (cmd)
  "Select a region by line number like ed and execute CMD."
  (interactive "sInput: ")
  (let* ((act (substring cmd (string-match "s" cmd)))
         (addr "")
	 (beg ".")
	 (end "."))
    ;; has address
    (if (not (string-prefix-p act cmd))
        (progn
          (setq addr (substring cmd 0 (string-match "s" cmd)))
          (if (not (string-match "^[ \t]+$" addr))
              (progn
                (setq addr (split-string addr ","))
                (setq beg (nth 0 addr))
                (setq end (nth 1 addr))
                (message "addr = %s, beg = %s, end = %s" addr beg end)
                ))))
    ;; strip spaces
    (setq beg (string-trim beg))
    (setq end (string-trim end))

    (if (not (and (string-match-p "[0-9]+\\|[.]" beg)
		  (string-match-p "[0-9]+\\|[.$]" end)))
	(message "Invalid prefix address!")
      (progn
	(if (not (string-equal beg "."))
	    (forward-line (string-to-number beg))
	  )
	(setq beg (point))

	; dtermine the end
	(if (string-equal end "$")
	    (setq end (point-max))
          (progn
	    (if (not (string-equal end "."))
	        (forward-line (string-to-number end))
              )
	    (end-of-line)
	    (setq end (point))))
	 (list beg end act)
         ))))

(defun replace-region (src target start end)
  "Relace text SRC with TARGET in specified region START to END."
  (goto-char start)
  (let ((count 0))
    (while (re-search-forward src end t)
      (replace-match target t t nil)
      (setq count (+ count 1))
      )
    (message "(vim like): Replace %d ocurrences" count)
    ))

(defun vim-replace-region ()
  "Replace a region like vim."
  (interactive)
  (let* ((cmd-list (call-interactively 'set-region))
	 (beg (nth 0 cmd-list))
	 (end (nth 1 cmd-list))
	 (act (nth 2 cmd-list)))
    (message "cmd=%s" cmd-list)
    (if (not (string-match-p "^s[,@/].+[,@/].*[,@/]" act))
        (message "Replace operation not supported! Are you vimer?")
                                        ; start parse the atc
      (let* ((sep (substring act 1 2))
             (src (nth 1 (split-string act sep)))
	     (target (nth 2 (split-string act sep))))
        (replace-region src target beg end)
        ))))

(defun insert-changelog ()
  "Insert change log to rpm spec file."
  (interactive)
  (progn
    (forward-line)
    (insert (concat "* " (format-time-string "%a %b %d %Y") " xiaoqiang.zhao <zxq_yx_007@163.com> - ")
    )))

(defun insert-CR ()
  "Insert copy right information at begining of c/c++ file."
  (interactive)
  (let ((copyinfo " * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>")
	(file-type (last (split-string buffer-file-name "\\."))))
    (forward-line 1)
    (insert
     (concat "/*\n * Copyright (C) "  (format-time-string "%Y")
	     " hitmoon <zxq_yx_007@163.com> \n *\n"
	     copyinfo
	     "\n *\n */\n"))))

(defun mark-end-of-line ()
  "Mark a line."
  (interactive)
  (progn
    (move-beginning-of-line 1)
    (set-mark-command nil)
    (move-end-of-line 1)
    (message "mark this line!")
    ))

(defun only-new-lines ()
  "Modify line ends with space or tab with only '\n'."
  (interactive)
  (progn
    (goto-char (point-min))
    (while (re-search-forward "\\(\t\\| \\)+$" nil t)
      (replace-match "" t t nil nil)
      (forward-char 1))
    (message "newlines is now clean for git diff!")))

;; cursor move
(global-set-key (kbd "M-n") 'search-forward)
(global-set-key (kbd "M-p") 'search-backward)

;; key bindings
(global-set-key (kbd "C-c c c") 'insert-changelog)
(global-set-key [f8] 'compile)
(global-set-key (kbd "C-c c l") 'copy-line)
(global-set-key (kbd "C-c c w") 'copy-word)
(global-set-key (kbd "C-c c p") 'copy-paragraph)
(global-set-key (kbd "C-c k l") 'kill-whole-line)
(global-set-key (kbd "C-c k p") 'kill-paragraph)
(global-set-key (kbd "C-c c v") 'vim-replace-region)
(global-set-key (kbd "C-c c u") 'uncomment-region)
(global-set-key (kbd "C-c c r") 'comment-region)
(global-set-key (kbd "C-c c n") 'only-new-lines)
(global-set-key (kbd "C-c r") 'insert-CR)
(global-set-key (kbd "C-'") 'mark-end-of-sentence)
(global-set-key (kbd "C-;") 'mark-end-of-line)

;; full screen
(global-set-key (kbd "C-c k f") 'full-screen)
(global-set-key (kbd "C-c k m") 'max-size)

;; ecb
(global-set-key (kbd "C-c e s") 'start-ecb)
(global-set-key (kbd "C-c e q") 'stop-ecb)
(global-set-key (kbd "C-c c m") 'ecb-goto-window-methods)
(global-set-key (kbd "C-c c h") 'ecb-goto-window-history)
(global-set-key (kbd "C-c c e") 'ecb-goto-window-edit1)
(global-set-key (kbd "C-c c d") 'ecb-goto-window-directories)
(global-set-key (kbd "C-c c s") 'ecb-goto-window-sources)

;; cflow
(global-set-key (kbd "C-c c f") 'get-cflow)

;; imenu-list
(global-set-key (kbd "C-.") 'imenu-list-minor-mode)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(ecb-show-sources-in-directories-buffer (quote ("left7" "left13" "left14" "left15")))
 '(package-selected-packages
   (quote
    (projectile flycheck rust-mode ggtags yasnippet srefactor imenu-list imenu+ gtags flymake-shell flymake-python-pyflakes flymake-cppcheck flymake ecb company-irony-c-headers company-irony color-theme))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(provide 'init.el)

;;; init.el ends here
