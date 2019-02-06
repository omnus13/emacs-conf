
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(require 'package)


;(require 'server)
;(setq server-use-tcp t
;      server-host "192.168.1.116"
;      server-socket-dir "~/.emacs.d/server")
;(unless (server-running-p)
;    (server-start))


; '(default ((t (:foreground "white" :background "black" ))) t)
;(set-face-attribute 'default nil :font "monospace 10" )
;:family "courier"
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:foundry "adobe" :foreground "white" :background "black" :slant normal :weight normal :height 120 :width normal))))
 '(diff-added ((t (:background "#003000"))))
 '(diff-hunk-header ((t (:background "blue"))))
 '(diff-removed ((t (:background "#300000"))))
 '(font-lock-comment-face ((t (:foreground "green"))))
 '(font-lock-doc-face ((t (:foreground "green2"))))
 '(font-lock-function-name-face ((t (:foreground "gold"))))
 '(font-lock-keyword-face ((t (:foreground "red"))))
 '(font-lock-preprocessor-face ((t (:foreground "yellow"))))
 '(font-lock-string-face ((t (:foreground "cyan"))))
 '(font-lock-type-face ((t (:foreground "green3"))))
 '(font-lock-variable-name-face ((t (:foreground "aquamarine"))))
 '(font-lock-warning-face ((t (:foreground "#Ea0" :bold t))))
 '(isearch ((t (:background "cornflowerblue"))))
 '(region ((t (:background "#444444"))))
 '(show-paren-match ((t (:background "#444464"))))
 '(show-paren-mismatch ((t (:background "#600000")))))

(set-cursor-color "white")
(set-mouse-color "white")

(tool-bar-mode -1)
(setq inhibit-splash-screen t)

;; Prevent the annoying beep on errors
(setq visible-bell t)

(blink-cursor-mode -1)
(delete-selection-mode 1)

;; Speedbar settings
(setq speedbar-default-position 'left)
(setq speedbar-frame-parameters '((minibuffer . nil)
                                  (width . 20)
                                  (border-width . 0)
                                  (menu-bar-lines . 0)
                                  (tool-bar-lines . 0)
                                  (unsplittable . t)
                                  (left-fringe . 0)
                                  (left . 0)
                                  ))

; Do not create back-up files
(setq make-backup-files nil)

; Clean-up trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

; I hate tabs!
(setq-default indent-tabs-mode nil)

(setq show-paren-style 'expression)
(setq show-paren-delay 0)
(show-paren-mode)


(setq c-basic-offset 4)

(column-number-mode t)
(line-number-mode t)

(set-default 'fill-column 80)

(global-hi-lock-mode 1)

(ido-mode t)
(icomplete-mode t)
(ido-everywhere 1)

(fset 'yes-or-no-p 'y-or-n-p)

(setq global-mark-ring-max 1000)

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed 1) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

; display stuff
(save-excursion
  (switch-to-buffer "*scratch*")
  (insert ";;")
  (newline)
  (insert ";; Welcome h4x0r !!!")
  (newline)
  (insert ";;")
  (newline))

(setenv "PAGER" "cat")

; patches the call at server.el:1237
(defun server-create-window-system-frame-hook(orig-fun &rest args)
  (let (
        (expected-display (car-safe args))
        (frame-display (frame-parameter (selected-frame) 'display))
        (other-arguments (cdr-safe args))
        )
;  (message "Create server params: %S, frame params: %S" args frame-display)
;  (message "CAR %S is iq %S" expected-display (string-equal (car-safe args) "localhost:current"))
;  (message "CDR %S" other-arguments)
;  (message "REJOIN %S" (cons frame-display other-arguments))
  (if (null frame-display)
      (if (string-equal expected-display "localhost:current")
          (apply orig-fun (cons (getenv "DISPLAY") other-arguments))
        (apply orig-fun args)
        )

    (if (string-equal expected-display "localhost:current")
        (apply orig-fun (cons frame-display other-arguments))
      (apply orig-fun args)
      )
    )
  )

  )

(advice-add 'server-create-window-system-frame :around #'server-create-window-system-frame-hook)


(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(setq CONFIGURATION-PATH (expand-file-name "~/.emacs.d/lisp"))
(setq load-path (cons (expand-file-name "~/.emacs.d/lisp/jss-master") load-path))
(setq load-path (cons CONFIGURATION-PATH load-path))

(require 'cl) ; required for defun*

(global-set-key [(control x) (control c)] (defun dont-kill-emacs() (interactive) (message "Use C-x c to leave")))
;(global-set-key [(control x) (c)] 'save-buffers-kill-emacs)
(global-set-key [(control x) (c)] 'delete-frame)
;(global-set-key [(control a)] 'mark-whole-buffer)
;(global-set-key [(control b)] 'ido-switch-buffer)
;(global-set-key [(control f)] 'find-file)
;(global-set-key [(control o)] 'ido-switch-buffer-other-window)
(global-set-key [(control z)] 'undo)
(global-set-key [f9] 'compile)

(require 'grep)
(global-set-key [(control f9)] (defun my-grep() (interactive) (rgrep (grep-read-regexp) "*" default-directory nil)))
(global-set-key [f4] 'next-error)
(global-set-key [(shift f4)] 'previous-error)
(global-set-key [f1] 'manual-entry)
(global-set-key [(shift f1)] 'info)
;(global-set-key [(meta right)] 'previous-buffer)
;(global-set-key [(meta left)]  'next-buffer)
;(global-set-key  "\M-`" 'speedbar-get-focus)
(global-set-key [(control f10)] 'start-kbd-macro)
(global-set-key [(meta f10)] 'end-kbd-macro)
(global-set-key [f11] 'kmacro-name-last-macro)
(global-set-key [f12] 'kmacro-call-macro)
(global-set-key [(control f11)] 'name-last-kbd-macro)
(global-set-key [(meta f11)] 'edit-named-kbd-macro)
(global-set-key [(control f12)] 'call-last-kbd-macro)
(global-set-key [(meta f12)] 'edit-last-kbd-macro)
(global-set-key [(control meta b)] 'toggle-truncate-lines)
(global-set-key [(meta g)] 'goto-line)
(global-set-key [f6] (defun last-buffer() (interactive) (switch-to-buffer (other-buffer))))
(global-set-key [(control tab)] (defun next-buff() (interactive) (other-window 1)))
(global-set-key (kbd "C-S-<iso-lefttab>") (defun prev-buffer() (interactive) (other-window -1)))
(global-set-key [(pause)] 'kill-this-buffer)
(global-set-key [(scroll-lock)] 'kill-this-buffer)
;(global-set-key [f8] 'gud-gdb)


(global-set-key [(meta left)] 'backward-sexp)
(global-set-key [(meta right)] 'forward-sexp)
(global-set-key [(meta shift left)] 'backward-sexp-mark)
(global-set-key [(meta shift right)] 'forward-sexp-mark)

;(global-set-key [(control meta left)] 'next-buffer)
;(global-set-key [(control meta right)] 'previous-buffer)

(require 'redo+)
(global-set-key [(control z)] 'undo)
(global-set-key [(control y)] 'redo)


(require 'comint) ; to set comint-output-filter-functions
(define-key comint-mode-map [C-up] 'comint-previous-matching-input-from-input)
(define-key comint-mode-map [C-down] 'comint-next-matching-input-from-input)
(setq comint-password-prompt-regexp
      (concat comint-password-prompt-regexp
              "\\|^Password for \\\\'.*\\\\':\\s *\\'"))
(setq comint-password-prompt-regexp
      (concat comint-password-prompt-regexp
              "\\|^.*\\\\' password:\\s *\\'"))
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'comint-output-filter-functions 'ansi-color-process-output)
(add-hook 'gdb-mode-hook 'ansi-color-for-comint-mode-on)


(require 'shell-ext) ; for f2 to create a new shell window
(global-set-key [(f2)] 'shell)
(global-set-key [(meta \\)] 'shell-change-to-current-dir)
(global-set-key [(control f2)] 'new-shell)
(global-set-key [(meta f2)] 'shell-command-on-region-inplace)

(require 'column-marker)
;(require 'commenting) ; adds my-comment-region, which allows commenting only one line
;(global-set-key [(meta \3)] 'my-comment-region)
;(global-set-key [(meta \4)] 'my-uncomment-region)


(defun my-comment-or-uncomment-region ()
  (interactive)
  (let ((beg (if mark-active (region-beginning) (point-at-bol)))
	(end (if mark-active (region-end) (point-at-eol))))
    (comment-or-uncomment-region beg end 1)))
(global-set-key (kbd "C-/") 'my-comment-or-uncomment-region)

(defun gud-gdb-marker-filter-hook(orig-fun &rest args)
  (let (
        (res (apply orig-fun args))
        )
    (ansi-color-process-output res)
    )
)
(advice-add 'gud-gdb-marker-filter :around #'gud-gdb-marker-filter-hook)




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(frame-background-mode (quote dark))
 '(package-selected-packages
   (quote
    (neotree smex flx-ido pungi bash-completion perspeen multiple-cursors magit-gerrit web-beautify json-mode websocket js-comint web-mode python python-x pyimport elpy bind-key company-web company-irony-c-headers python-mode jedi company-jedi android-mode anaconda-mode company-shell company magit hydra exwm xelb)))
 '(safe-local-variable-values
   (quote
    ((eval progn
           (semantic-mode)
           (setq-local gud-gdb-history
                       (list
                        (concat
                         (file-name-as-directory
                          (locate-dominating-file default-directory dir-locals-file))
                         "src/build/android/adb_gdb_chrome_public " "\"--gdb=/opt/gdb/bin/arm-linux-androideabi-gdb\" " "\"--gdbserver=/home/ubuntu/android/ndk/android-ndk-r10e/prebuilt/android-arm/gdbserver/gdbserver\" " "--interpreter=mi --fullname \"--su-prefix=su -c\" " "--output-directory=out/Default --force  --noautoload " "--no-pull-libs --sandboxed \"--start=http://127.0.0.1:8000/\"")
                        (concat
                         (file-name-as-directory
                          (locate-dominating-file default-directory dir-locals-file))
                         "src/build/android/adb_gdb_chrome_public " "\"--gdb=/opt/gdb/bin/arm-linux-androideabi-gdb\" " "\"--gdbserver=/home/ubuntu/android/ndk/android-ndk-r10e/prebuilt/android-arm/gdbserver/gdbserver\" " "--interpreter=mi --fullname \"--su-prefix=su -c\" " "--output-directory=out/Default --force " "--pull-libs --sandboxed \"--start=http://127.0.0.1:8000/\"")))
           (setq-local compile-command
                       (concat "cd "
                               (file-name-as-directory
                                (locate-dominating-file default-directory dir-locals-file))
                               "src ; " "ninja -C out/Default chrome_public_apk")))
     (eval progn
           (setq-local gud-gdb-history
                       (list
                        (concat
                         (file-name-as-directory
                          (locate-dominating-file default-directory dir-locals-file))
                         "src/build/android/adb_gdb_chrome_public " "\"--gdb=/opt/gdb/bin/arm-linux-androideabi-gdb\" " "\"--gdbserver=/home/ubuntu/android/ndk/android-ndk-r10e/prebuilt/android-arm/gdbserver/gdbserver\" " "--interpreter=mi --fullname \"--su-prefix=su -c\" " "--output-directory=out/Default --force  --noautoload " "--no-pull-libs --sandboxed \"--start=http://127.0.0.1:8000/\"")
                        (concat
                         (file-name-as-directory
                          (locate-dominating-file default-directory dir-locals-file))
                         "src/build/android/adb_gdb_chrome_public " "\"--gdb=/opt/gdb/bin/arm-linux-androideabi-gdb\" " "\"--gdbserver=/home/ubuntu/android/ndk/android-ndk-r10e/prebuilt/android-arm/gdbserver/gdbserver\" " "--interpreter=mi --fullname \"--su-prefix=su -c\" " "--output-directory=out/Default --force " "--pull-libs --sandboxed \"--start=http://127.0.0.1:8000/\"")))
           (setq-local compile-command
                       (concat "cd "
                               (file-name-as-directory
                                (locate-dominating-file default-directory dir-locals-file))
                               "src ; " "ninja -C out/Default chrome_public_apk"))))))
 '(show-paren-mode t)
 '(tool-bar-mode nil))



;(defadvice show-paren-function
;      (after show-matching-paren-offscreen activate)
;      "If the matching paren is offscreen, show the matching line in the
;        echo area. Has no effect if the character before point is not of
;        the syntax class ')'."
;      (interactive)
;      (let* ((cb (char-before (point)))
;             (matching-text (and cb
;                                 (char-equal (char-syntax cb) ?\) )
;                                 (blink-matching-open))))
;        (when matching-text (message matching-text))))

;(setq gdb-command-name "lispgdb")


(defun* mystoppedfun(res)
    ;(message "STOPPED %S" res)
;    (message (format "gdb-thread-num %S gdb-frame-number %S gud running %S, gdb update gud running %S gdb show run p %S gdb show stop %S #running %S #stopped %S" gdb-thread-number gdb-frame-number gud-running (gdb-update-gud-running) (gdb-show-run-p) (gdb-show-stop-p) gdb-running-threads-count gdb-stopped-threads-count))

    (gud-refresh)
    (condition-case nil
    (let (
        (my-frame (bindat-get-field res 'frame))
        )
;            (message "frame %S" my-frame)
            (condition-case nil
                (let(
                    (file (bindat-get-field my-frame 'fullname))
                    (line-number (bindat-get-field my-frame 'line))
                    )
;                        (message "file %S" file)
;                        (message "line is %S" line-number)

                        (let (
                            (my-buffer (find-file-noselect file))
                            )
;                                (message "buffer is %S" my-buffer)
                                (let (
                                    (my-window (display-buffer my-buffer))
                                    )
;                                        (message "window is %S" my-window)
                                        (with-selected-window my-window
                                            (goto-line (string-to-number line-number))
;                                            (message "went to line")
;                                            (set-window-point my-window cur-point)
                                            (winstack-push my-window t)
                                        )

                                )
                        )
                )
            )
    )
    (error nil))
;    (message "done stop handler")

    )

(setq gdb-stopped-functions '(mystoppedfun))

;(let (
;      (gpob (gdb-get-buffer-create 'gdb-partial-output-buffer))
;      )
;  (with-current-buffer gpob
;    (buffer-disable-undo gpob)
;    )
;  )


;(defun goto-def()
;    (interactive)
;    ;(call-interactively 'ami-cscope-at-point)
;)

(defun winstack-goto-def-and-push()
  (interactive)
    (semantic-symref-symbol (symbol-at-point))
    (winstack-push)
)





;;; make these keys behave like normal browser
;(define-key xwidget-webkit-mode-map [mouse-4] 'xwidget-webkit-scroll-down)
;(define-key xwidget-webkit-mode-map [mouse-5] 'xwidget-webkit-scroll-up)
;(define-key xwidget-webkit-mode-map (kbd "<up>") 'xwidget-webkit-scroll-down)
;(define-key xwidget-webkit-mode-map (kbd "<down>") 'xwidget-webkit-scroll-up)
;(define-key xwidget-webkit-mode-map (kbd "M-w") 'xwidget-webkit-copy-selection-as-kill)
;(define-key xwidget-webkit-mode-map (kbd "C-c") 'xwidget-webkit-copy-selection-as-kill)

;; adapt webkit according to window configuration chagne automatically
;; without this hook, every time you change your window configuration,
;; you must press 'a' to adapt webkit content to new window size
(add-hook 'window-configuration-change-hook (lambda ()
               (when (equal major-mode 'xwidget-webkit-mode)
                 (xwidget-webkit-adjust-size-dispatch))))


;;; by default, xwidget reuses previous xwidget window,
;;; thus overriding your current website, unless a prefix argument
;;; is supplied
;;;
;;; This function always opens a new website in a new window
;(defun xwidget-browse-url-no-reuse (url &optional sessoin)
;  (interactive (progn
;                 (require 'browse-url)
;                 (browse-url-interactive-arg "xwidget-webkit URL: "
;                                             )))
;  (xwidget-webkit-browse-url url t))

;; make xwidget default browser
(setq browse-url-browser-function (lambda (url session)
                    (other-window 1)
                    (xwidget-webkit-browse-url url)))





(with-eval-after-load 'magit-mode (define-key magit-mode-map [(control tab)] 'other-window))
;(add-hook 'after-init-hook 'global-company-mode)
;(global-set-key [(tab)] 'company-complete)

;(global-set-key [(f2)] 'gud-break)

(require 'completion-epc) ; required for frida completion
(require 'ahg) ; for mercurial source control, like magit
;(global-set-key [(meta h)] 'ahg-status)
(global-set-key [(meta h)] 'magit-status)

;(require 'ascope)
;(global-set-key [(meta f9)] 'ascope-find-this-text-stringy)
;(global-set-key [(control f3)] 'ascope-find-global-definition)
;(global-set-key [(control f4)] 'ascope-find-this-symbol)
; (global-set-key [(control f5)] 'ascope-find-functions-calling-this-function)
; (global-set-key [(control f6)] 'ascope-find-called-functions)
; (global-set-key [(control f7)] 'ascope-find-files-including-file)
; (global-set-key [(control f8)] 'ascope-find-all-symbol-assignments)
;(ascope-init "/home/ubuntu/sources/chromium/")

(require 'jss) ; remote js debugger
(require 'winstack)
(require 'simple)
(defun push-mark-hook(orig-fun &rest args)
  (progn
    (apply orig-fun args)
    (when (not (minibufferp)) (winstack-push))))
(advice-add 'push-mark :around #'push-mark-hook)

; combine-after-change-calls

(global-set-key [(control meta left)] 'winstack-pop)
(global-set-key [(control meta right)] 'winstack-next)

;(global-set-key (kbd "<kp-add>") 'winstack-next)
;(global-set-key (kbd "<S-return>") 'winstack-goto-def-and-push)
;(global-set-key (kbd "<kp-subtract>")      'winstack-pop)

(require 'lk-file-search)

;(require 'webkit)

(require 'python-mode)
; switch to the interpreter after executing code
(setq py-split-window-on-execute nil)
(setq py-switch-buffers-on-execute-p nil)
; don't split windows
(py-split-window-on-execute-off)
; try to automagically figure out indentation
;(setq py-smart-indentation t)

(put 'erase-buffer 'disabled nil)


(defun buffer-mode (buffer-or-string)
  "Returns the major mode associated with a buffer."
  (with-current-buffer buffer-or-string
     major-mode))

(defun get-buffers-with-major-mode (find-major-mode)
  "Get a list of buffers in which minor-mode is active"
  (interactive)
  (let ((major-mode-buffers))
    (dolist (buf (buffer-list) major-mode-buffers)
      (with-current-buffer buf
        (when (eq major-mode find-major-mode)
          (push buf major-mode-buffers))))))

(defun new-python() (interactive) (switch-to-buffer (python)))
(defun old-python() (interactive)
       (let (
             (pyb (car (get-buffers-with-major-mode 'py-python-shell-mode)))
             )
         (if (eq pyb nil)
             (new-python)
           (switch-to-buffer pyb))))
(global-set-key [(control p)] 'old-python)
(global-set-key [(control shift p)] 'new-python)

(defun track-shell-directory/procfs ()
  (shell-dirtrack-mode 0)
  (add-hook 'comint-preoutput-filter-functions
            (lambda (str)
              (prog1 str
                (when (string-match comint-prompt-regexp str)
                  (cd (file-symlink-p
                       (format "/proc/%s/cwd" (process-id
                                               (get-buffer-process
                                                (current-buffer)))))))))
            nil t))

(add-hook 'shell-mode-hook 'track-shell-directory/procfs)

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)


;(require 'perspeen)
;(setq perspeen-keymap-prefix (kbd "C-c C-'"))
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)                 ; optional
(global-set-key [(control meta j)] 'jedi:goto-definition)


(require 'bash-completion)
(bash-completion-setup)


(require 'flx-ido)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(global-set-key (kbd "C-e") 'neotree-toggle)
