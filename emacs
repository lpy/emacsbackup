;;;;       lpy's .emacs file
;      Name: Peiyong Lin
;   Created: 1 January 2012


;;;;auto-to-list
(add-to-list 'load-path "~/.emacs.d/plugins/color-theme-6.6.0")
(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete-1.3.1")
(add-to-list 'load-path "~/.emacs.d/plugins/yas")
(add-to-list 'load-path "~/.emacs.d/plugins/cursor-change")
(add-to-list 'load-path "~/.emacs.d/plugins/header")
(add-to-list 'load-path "~/.emacs.d/plugins")
(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete-clang")
(add-to-list 'load-path "~/.emacs.d/plugins/program_mode/perl-mode/Emacs-PDE/lisp")
(add-to-list 'load-path "~/.emacs.d/plugins/autopair")

;;;;color-theme && high-light
(require 'color-theme)
(color-theme-initialize)
(color-theme-comidia)
(setq color-theme-is-global t)
(global-font-lock-mode t)
;;(require 'hl-line)
;;(global-hl-line-mode t)

;;;;在状态条上显示当前光标所在函数体名称
(which-function-mode)
(setq default-fill-column 88)
(setq max-lisp-eval-depth 1000)
(ido-mode t)
;;;;括号匹配显示
(show-paren-mode t)
(setq show-paren-style 'parentheses)
(setq skeleton-pair t)
;;;;Emacs与外部可以互相复制粘帖
(setq x-select-enable-clipboard t)
;;;;显示行号
(setq column-number-mode t)
(global-linum-mode t)
(setq-default kill-whole-line t)
;;;;去掉那个大大的工具栏  
(tool-bar-mode nil)
;;;;去掉滚动条
(put 'scroll-left 'disabled nil)
(scroll-bar-mode nil)
;;;;光标靠近鼠标指针时，鼠标指针自动让开  
(mouse-avoidance-mode 'animate)
;;;;打开图片显示功能
(auto-image-file-mode t) 
;;;;在标题栏提示文件名称
(setq frame-title-format "%n%F/%b")
;;;;用一个很大的kill ring
(setq kill-ring-max 250)
;;;;默认字体
(set-default-font "Monaco-11")
;;;;关闭启动时的开机画面
(setq inhibit-startup-message t)
;;;;启动窗口大小
(setq default-frame-alist
      '((height . 35) (width . 90) (menu-bar-lines . 20) (tool-bar-lines . 0))) 
;;;;文本模式
;;(setq default-major-mode 'text-mode)
;;(add-hook 'text-mode-hook 'turn-on-auto-fill)
;;;;Time showing
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)
;;;;Don't create the temp file
(setq-default make-backup-files nil)
;;;;关闭自动保存模式
(setq auto-save-mode nil)
;;;;不生成 #filename# 临时文件
(setq auto-save-default nil)
;;;;using 'y' and 'n' to replace 'yes' and 'no'
(fset 'yes-or-no-p 'y-or-n-p)

;;;;Using sdcv
;;(require 'sdcv-mode)
;;(global-set-key (kbd "C-c d") 'sdcv-search)

;;;;redefine[C-k] to kill the current line wherever the cursor it is
(defun kill-current-line ()
 "To kill the current line"
 (interactive)
 (move-beginning-of-line ())
 (kill-line ())
 ;;(previous-line)
 (indent-according-to-mode))
(global-set-key (kbd "C-k") 'kill-current-line)

;;;;重新定义[C-j]实现不需要移动就新建一行
(defun my-new-line-and-indent (arg)
  (interactive "^p")
  (or arg (setq arg 1))
  (let (done)
    (while (not done)
      (let ((newpos
             (save-excursion
               (let ((goal-column 0)
                     (line-move-visual nil))
                 (and (line-move arg t)
                      (not (bobp))
                      (progn
                        (while (and (not (bobp)) (invisible-p (1- (point))))
                          (goto-char (previous-single-char-property-change
                                      (point) 'invisible)))
                        (backward-char 1)))
                 (point)))))
        (goto-char newpos)
        (if (and (> (point) newpos)
                 (eq (preceding-char) ?\n))
            (backward-char 1)
          (if (and (> (point) newpos) (not (eobp))
                   (not (eq (following-char) ?\n)))
             ;;;If we skipped something intangible and now we're not
             ;;;really at eol, keep going.
              (setq arg 1)
            (setq done t))))))
;;  (newline-and-indent))
  (newline)
  (indent-according-to-mode))

(global-set-key (kbd "C-j") 'my-new-line-and-indent)
;;(global-set-key (kbd "C-j") 'newlineandindent)

;;;;cedet
;; (defun c/c++-cedet ()
;;   (require 'cedet)
;;   (require 'semantic-ia)
;;   (global-ede-mode 1)
;;   (semantic-load-enable-excessive-code-helpers)
;;   (semantic-load-enable-semantic-debugging-helpers)
;;   (global-srecode-minor-mode 1)
;;   (semantic-load-enable-minimum-features)
;;   (semantic-load-enable-code-helpers)
;;   (global-set-key (kbd "<f12>") 'semantic-ia-fast-jump))
;; (add-hook 'c-mode-common-hook 'c/c++-cedet)
;; (add-hook 'c++-mode-hook 'c/c++-cedet)


;;;;C-mode的缩进(test)
    (setq default-tab-width 4)
    (setq tab-width 4)
    (setq tab-stop-list ())
    (setq c-basic-offset 4)
    (setq-default indent-tabs-mode nil)
    (loop for x downfrom 40 to 1 do
          (setq tab-stop-list (cons (* x 2) tab-stop-list)))

 (defconst lpy-Cprogramming-style
   '((c-tab-always-indent        . t)
	 (c-comment-only-line-offset . 2)
	 (c-hanging-braces-alist     . ((substatement-open after)
									(brace-list-open)))
	 (c-hanging-colons-alist     . ((member-init-intro before)
									(inher-intro)
									(case-label after)
									(label after)
p									(access-label after)))
	 (c-cleanup-list             . (scope-operator
									empty-defun-braces
									defun-close-semi))
	 (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
									(substatement-open . 0)
									(case-label        . 4)
									(block-open        . 0)
									(knr-argdecl-intro . -)))
	 (c-echo-syntactic-information-p . t)
	 )
   "lpy's C Programming Style")

 ;; offset customizations not in lpy-Cprogramming-style
 (setq c-offsets-alist '((member-init-intro . ++)))

 ;;;;Customizations for all modes in CC Mode.
	(defun my-c-mode-common-hook ()
	  ;; add my personal style and set it for the current buffer
	  (c-add-style "PERSONAL" lpy-Cprogramming-style t)
	  ;; other customizations
	  (setq tab-width 2
			;; this will make sure spaces are used instead of tabs
			indent-tabs-mode nil)
	  ;; we like auto-newline and hungry-delete
	  ;;(c-toggle-auto-hungry-state 1)
	  ;; key bindings for all supported languages.  We can put these in
	  ;; c-mode-base-map because c-mode-map, c++-mode-map, objc-mode-map,
	  ;; java-mode-map, idl-mode-map, and pike-mode-map inherit from it.
	  ;;(define-key c-mode-base-map "/C-m" 'c-context-line-break)
        (define-key c-mode-base-map [(return)] 'newline-and-indent)
        ;;(c-toggle-auto-hungry-state 1)
        ;;(define-key c-mode-base-map [(control \`)] 'hs-toggle-hiding)
	)
(defun my-c++-common-hook ()
  (setq tab-width 4
        indent-tabs-mode nil)
  (setq c-hanging-braces-alist 
	(cons'
   (brace-list-close)
   c-hanging-braces-alist)))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
;;(add-hook 'c-mode-common-hook 'my-c-mode-auto-pair)
(add-hook 'c++-mode-hook 'my-c-mode-common-hook)
;;(add-hook 'c++-mode-hook 'my-c-mode-auto-pair)

;;;;;;;;C/C++ Ending


;;;;Smart Compiler
(require 'smart-compile)
(global-set-key (kbd "<f9>") 'smart-compile)
(defun smart-compile-is-root-dir(try-dir)
  (or
   ;; windows root dir for a driver or Unix root
   (string-match "\\`\\([a-zA-Z]:\\)?/$" try-dir)
   ;; tramp root-dir
   (and (featurep 'tramp)
        (string-match (concat tramp-file-name-regexp ".*:/$") try-dir))))
(defun smart-compile-throw-final-path(try-dir)
  (cond
   ;; tramp root-dir
   ((and (featurep 'tramp)
         (string-match tramp-file-name-regexp try-dir))
    (with-parsed-tramp-file-name try-dir foo
      foo-localname))
   (t try-dir)))

(defun smart-compile-find-make-dir( try-dir)
  "return a directory contain makefile. try-dir is absolute path."
  (if (smart-compile-is-root-dir try-dir)
      nil ;; return nil if failed to find such directory.
    (let ((candidate-make-file-name `("GNUmakefile" "makefile" "Makefile")))
      (or (catch 'break
            (mapc (lambda (f)
                    (if (file-readable-p (concat (file-name-as-directory try-dir) f))
                        (throw 'break (smart-compile-throw-final-path try-dir))))
                  candidate-make-file-name)
            nil)
          (smart-compile-find-make-dir
           (expand-file-name (concat (file-name-as-directory try-dir) "..")))))))

(defun wcy-tramp-compile (arg-cmd)
  "reimplement the remote compile."
  (interactive "scompile:")
  (with-parsed-tramp-file-name default-directory foo
    (let* ((key (format "/plink:%s@%s:" foo-user foo-host))
           (passwd (password-read "PASS:" key))
           (cmd (format "plink %s -l %s -pw %s \"(cd %s ; %s)\""
                        foo-host foo-user
                        passwd
                        (file-name-directory foo-localname)
                        arg-cmd)))
      (password-cache-add key passwd)
      (save-some-buffers nil nil)
      (compile-internal cmd "No more errors")
      ;; Set comint-file-name-prefix in the compilation buffer so
      ;; compilation-parse-errors will find referenced files by ange-ftp.
      (with-current-buffer compilation-last-buffer
        (set (make-local-variable 'comint-file-name-prefix)
             (format "/plink:%s@%s:" foo-user foo-host))))))
(defun smart-compile-test-tramp-compile()
  (or (and (featurep 'tramp)
           (string-match tramp-file-name-regexp (buffer-file-name))
           (progn
             (if (not (featurep 'tramp-util)) (require 'tramp-util))
             'wcy-tramp-compile))
      'compile))
(defun smart-compile-get-local-file-name(file-name)
  (if (and
       (featurep 'tramp)
       (string-match tramp-file-name-regexp file-name))
      (with-parsed-tramp-file-name file-name foo
        foo-localname)
    file-name))
(defun smart-compile ()
  (interactive)
  (let* ((compile-func (smart-compile-test-tramp-compile))
         (dir (smart-compile-find-make-dir (expand-file-name "."))))
    (funcall compile-func
             (if dir
                 (concat "make -C " dir (if (eq compile-func 'tramp-compile) "&" ""))
               (concat
                (cond
                 ((eq major-mode 'c++-mode) "g++ -Wall -g -o ")
                 ((eq major-mode 'c-mode) "gcc -Wall -g -o "))
                (smart-compile-get-local-file-name (file-name-sans-extension (buffer-file-name)))
                " "
                (smart-compile-get-local-file-name (buffer-file-name)))))))


;;;;;;;;Comment
(defadvice comment-or-uncomment-region (before slickcomment activate compile)
  "When called interactively with no active region, toggle comment on current line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
	   (line-beginning-position 2)))))
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)

;; comment-or-uncomment-region-or-line
;; it's almost the same as in textmate.el but I wrote it before I know about
;; textmate.el, in fact that's how I found textmate.el, by googling this
					; function to see if somebody already did that in a better way than me.



;; Original idea from
;; http://www.opensubscriber.com/message/emacs-devel@gnu.org/10971693.html
(defun comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
        If no region is selected and current line is not blank and we are not at the end of the line,
        then comment current line.
        Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(global-set-key (kbd "C-'") 'comment-dwim-line)

;;;;;;;;Comment Ending


;;;; AutoComplete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete-1.3.1/dict")
(require 'auto-complete-yasnippet)
(require 'auto-complete-clang)
(setq ac-clang-flags
      (mapcar (lambda (item)(concat "-I" item))
              (split-string
               "
 /usr/lib/gcc/i686-pc-linux-gnu/4.7.0/../../../../include/c++/4.7.0
 /usr/lib/gcc/i686-pc-linux-gnu/4.7.0/../../../../include/c++/4.7.0/i686-pc-linux-gnu
 /usr/lib/gcc/i686-pc-linux-gnu/4.7.0/../../../../include/c++/4.7.0/backward
 /usr/lib/gcc/i686-pc-linux-gnu/4.7.0/include
 /usr/local/include
 /usr/lib/gcc/i686-pc-linux-gnu/4.7.0/include-fixed
 /usr/include
"
               )))
(setq ac-modes
      (append ac-modes '(org-mode objc-mode jde-mode sql-mode
                                  change-log-mode text-mode
                                  lisp-mode
                                  makefile-gmake-mode makefile-bsdmake-mo
                                  autoconf-mode makefile-automake-mode c-mode c++-mode)))
(setq ac-quick-help-delay 0.2)
 ;;(ac-config-default)
 ;;(require 'auto-complete+)
 ;;(add-hook 'emacs-lisp-mode-hook 'ac+-apply-source-elisp-faces)
 ;;(require 'auto-complete-extension)
 ;;(require 'auto-complete-c)
 (require 'yasnippet)
 (yas/global-mode 1)
 ;(yas/initialize)
 ;(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")

(setq clang-completion-suppress-error 't)

(defun my-c-ac-mode-common-hook()
  (setq ac-auto-start nil)
  (setq ac-expand-on-auto-complete nil)
  (setq ac-quick-help-delay 0.2)
  (define-key c-mode-base-map (kbd "M-/") 'ac-complete-clang)
)

(add-hook 'c-mode-common-hook 'my-c-ac-mode-common-hook)

    ;;(ac-set-trigger-key "TAB")
    ;;(define-key ac-mode-map  [(control tab)] 'auto-complete)
    ;;(define-key ac-mode-map  [(control tab)] 'auto-complete)

(defun my-ac-config ()
      (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
      (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
      ;; (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
      (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
      (add-hook 'css-mode-hook 'ac-css-mode-setup)
      (add-hook 'auto-complete-mode-hook 'ac-common-setup)
      (global-auto-complete-mode t))
(defun my-ac-cc-mode-setup ()
      (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
    ;; ac-source-gtags
(my-ac-config)
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(setq-default ac-sources '(ac-source-words-in-same-mode-buffers))
(add-hook 'emacs-lisp-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-symbols)))
(add-hook 'auto-complete-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-filename)))
(set-face-background 'ac-candidate-face "lightgray")
(set-face-underline 'ac-candidate-face "darkgray")
(set-face-background 'ac-selection-face "steelblue") ;;; 设置比上面截图中更好看的背景颜色
(define-key ac-completing-map "\M-n" 'ac-next)  ;;; 列表中通过按M-n来向下移动
(define-key ac-completing-map "\M-p" 'ac-previous)
(setq ac-auto-start 2)
(setq ac-dwim t)
(define-key ac-mode-map (kbd "TAB") 'auto-complete)

;;;; Auto-Complete Ending


;;;; Cursor-change
(require 'cursor-change)
(cursor-change-mode 't)


;;;; One key Compiler, Shell open, Kill buffer
(defun onekey-compile ()
   "Compile current buffer"
   (interactive)
   (let (filename suffix progname compiler)
     (setq filename (file-name-nondirectory buffer-file-name))
     (setq progname (file-name-sans-extension filename))
     (setq suffix (file-name-extension filename))
     (if (string= suffix "c") (setq compiler (concat "gcc -Wall -g -o " progname " ")))
     (if (or (string= suffix "cc") (string= suffix "cpp")) (setq compiler (concat "g++ -Wall -g -o " progname " ")))
     (if (string= suffix "tex") (setq compiler "latex "))
     (compile (concat compiler filename " -lm"))))

(defun mykillbuffer ()
  (interactive)
  (kill-buffer))

;;(global-set-key (kbd "<f9>") 'onekey-compile)
(global-set-key (kbd "<f8>") 'gdb)
(global-set-key (kbd "C-Q") 'mykillbuffer)

;;;;use auto-file-header 
;; (require 'header)
;; (setq time-stamp-format
;;                           "Last modified by %:u on %04y-%02m-%02d at %02H:%02M:%02S"
;;                           time-stamp-active t
;;                           time-stamp-warn-inactive t)
;; (setq time-stamp-pattern nil)
;; (add-hook 'write-file-hooks 'time-stamp)
;; (global-set-key (kbd "<f2>") 'header)

;;;;Scheme
(global-set-key (kbd "<f3>") 'run-scheme)
(setq scheme-program-name "petite")
(defun scheme-starter
  (split-window-vertically 16)
  (other-window)
  (run-scheme))
(global-set-key (kbd "C-<f3>") 'scheme-starter)


;;;;python-mode
(add-to-list 'load-path "~/.emacs.d/plugins/program_mode/python-mode")
(setq py-install-directory "~/.emacs.d/plugins/program_mode/python-mode")
;;(require 'python-mode)


;;;;Perl
;;; cperl-mode is preferred to perl-mode                                        
;;; "Brevity is the soul of wit" <foo at acm.org>                               
(load "pde-load")
(require 'anything)
(require 'anything-match-plugin)
(require 'anything-config)
(add-hook 'cperl-mode-hook
          (lambda()
            (require 'perl-completion)
            (perl-completion-mode t)))

(add-hook  'cperl-mode-hook
           (lambda ()
             (when (require 'auto-complete nil t) ; no error whatever auto-complete.el is not installed.
               (auto-complete-mode t)
               (make-variable-buffer-local 'ac-sources)
               (setq ac-sources
                     '(ac-source-perl-completion)))))
;; (defalias 'perl-mode 'cperl-mode)
;; (add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(setq auto-mode-alist
      (cons '("\.plx" . cperl-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\.cgi" . cperl-mode) auto-mode-alist))
;; (add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
;; (add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
;; (add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))


;;;;markdown-mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\.markdown" . markdown-mode) auto-mode-alist))


;;;;haskell-mode
(add-to-list 'load-path "~/.emacs.d/plugins/program_mode/haskell-mode")
(require 'haskell-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(setq auto-mode-alist
      (cons '("\.hs" . haskell-mode) auto-mode-alist))


;;;;xcscope
(require 'xcscope)


;;;;ace-jump
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)


;;;;Set my auto header
(require 'auto-header)
(setq header-full-name "Laurent Lin/Peiyong Lin")
(setq header-email-address "pylaurent1314@gmail.com")
(setq header-copyright-notice "CopyRight@lpy  For my Artemis")
(setq header-field-list '(filename
                          blank
                          author
                          copyright
                          blank
                          created
                          modified
                          blank
                          description
                          blank
                          ))
                          
(setq header-update-on-save '(filename
                              modified
                              counter
                              copyright
                              ))



;;;; make script executable after saved
(add-hook 'after-save-hook
        #'(lambda ()
        (and (save-excursion
               (save-restriction
                 (widen)
                 (goto-char (point-min))
                 (save-match-data
                   (looking-at "^#!"))))
             (not (file-executable-p buffer-file-name))
             (shell-command (concat "chmod u+x " buffer-file-name))
             (message
              (concat "Saved as script: " buffer-file-name)))))

;;;; emacs weibo
;;(add-to-list 'load-path "~/.emacs.d/plugins/weibo.emacs/")
;;(require 'weibo)

(setq auto-newline nil)

(require 'tramp)

;;;; Config for Emacs Client with stumpWM
  (add-hook 'after-init-hook 'server-start)
  (setq server-raise-frame t)

  (if window-system
      (add-hook 'server-done-hook
                (lambda () (shell-command "stumpish 'eval (stumpwm::return-es-called-win stumpwm::*es-win*)'"))))


;;;; lisp-mode
(add-to-list 'load-path "~/.emacs.d/plugins/program_mode/lisp-mode/slime")  ; SLIME directory
(add-to-list 'load-path "~/.emacs.d/plugins/program_mode/lisp-mode/slime/contrib")
(setq inferior-lisp-program "/usr/bin/sbcl --noinform") ; Lisp system
(require 'slime)
(slime-setup '(slime-fancy))
(add-hook 'lisp-mode-hook (lambda () (auto-complete-mode t)))
(define-key global-map (kbd "<f2>") 'slime)


(defun my-replace-regexp (replacedstring replacestring)
  (interactive "MReplaced Regexp: \nMReplace Regexp: ")
  (mark-whole-buffer)
  (replace-regexp replacedstring replacestring))

(define-key global-map (kbd "C-x ?") 'my-replace-regexp)


;;;;javascript-mode
(add-to-list 'load-path "~/.emacs.d/plugins/program_mode/js2-mode/")
(add-to-list 'load-path "~/.emacs.d/plugins/program_mode/espresso/")
(autoload 'js2-mode "js2-mode" nil t)
(autoload 'espresso-mode "espresso-mode")
(setq auto-mode-alist
      (cons '("\\.js$" . js2-mode) auto-mode-alist))
;;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(defun my-js2-indent-function ()
  (interactive)
  (save-restriction
    (widen)
    (let* ((inhibit-point-motion-hooks t)
           (parse-status (save-excursion (syntax-ppss (point-at-bol))))
           (offset (- (current-column) (current-indentation)))
           (indentation (espresso--proper-indentation parse-status))
           node)

      (save-excursion
        ;; I like to indent case and labels to half of the tab width
        (back-to-indentation)
        (if (looking-at "case\\s-")
            (setq indentation (+ indentation (/ espresso-indent-level 2))))

        ;; consecutive declarations in a var statement are nice if
        ;; properly aligned, i.e:
        ;;
        ;; var foo = "bar",
        ;;     bar = "foo";
        (setq node (js2-node-at-point))
        (when (and node
                   (= js2-NAME (js2-node-type node))
                   (= js2-VAR (js2-node-type (js2-node-parent node))))
          (setq indentation (+ 4 indentation))))

      (indent-line-to indentation)
      (when (> offset 0) (forward-char offset)))))

(defun my-indent-sexp ()
  (interactive)
  (save-restriction
    (save-excursion
      (widen)
      (let* ((inhibit-point-motion-hooks t)
             (parse-status (syntax-ppss (point)))
             (beg (nth 1 parse-status))
             (end-marker (make-marker))
             (end (progn (goto-char beg) (forward-list) (point)))
             (ovl (make-overlay beg end)))
        (set-marker end-marker end)
        (overlay-put ovl 'face 'highlight)
        (goto-char beg)
        (while (< (point) (marker-position end-marker))
          ;; don't reindent blank lines so we don't set the "buffer
          ;; modified" property for nothing
          (beginning-of-line)
          (unless (looking-at "\\s-*$")
            (indent-according-to-mode))
          (forward-line))
        (run-with-timer 0.5 nil '(lambda(ovl)
                                   (delete-overlay ovl)) ovl)))))

(defun my-js2-mode-hook ()
  (require 'espresso)
  (setq espresso-indent-level 4
        indent-tabs-mode nil
        c-basic-offset 4)
  (setq js2-basic-offset 4)
  (c-toggle-auto-state 0)
  (c-toggle-hungry-state 1)
  (set (make-local-variable 'indent-line-function) 'my-js2-indent-function)
  (define-key js2-mode-map [(meta control |)] 'cperl-lineup)
  (define-key js2-mode-map [(meta control \;)] 
    '(lambda()
       (interactive)
       (insert "/* -----[ ")
       (save-excursion
         (insert " ]----- */"))
       ))
  (define-key js2-mode-map [(return)] 'newline-and-indent)
  (define-key js2-mode-map [(backspace)] 'c-electric-backspace)
  (define-key js2-mode-map [(control d)] 'c-electric-delete-forward)
  (define-key js2-mode-map [(control meta q)] 'my-indent-sexp)
  (if (featurep 'js2-highlight-vars)
    (js2-highlight-vars-mode))
  (message "My JS2 hook"))

(add-hook 'js2-mode-hook 'my-js2-mode-hook)


;;;; erc configuration
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(erc-autojoin-channels-alist (quote (("freenode.net" "#ubuntu-cn"))))
 '(erc-away-nickname "lpy_away")
 '(erc-nick "lpy")
 '(erc-play-sound t)
 '(erc-server "irc.freenode.net")
 '(erc-sound-mode t)
 '(erc-user-full-name "lpy"))

(setq erc-colors-list '("green" "red"
			"dark gray" "dark orange"
			"dark magenta" "maroon"
			"indian red"  "forest green"
			"midnight blue" "dark violet"))

(setq erc-nick-color-alist '(("John" . "blue")
			     ("Bob" . "red")
			     ))

(defun erc-get-color-for-nick (nick)
  "Gets a color for NICK. If NICK is in erc-nick-color-alist, use that color, else hash the nick and use a random color from the pool"
  (or (cdr (assoc nick erc-nick-color-alist))
      (nth
       (mod (string-to-number
	     (substring (md5 (downcase nick)) 0 6) 16)
	    (length erc-colors-list))
       erc-colors-list)))

(defun erc-put-color-on-nick ()
  "Modifies the color of nicks according to erc-get-color-for-nick"
  (save-excursion
    (goto-char (point-min))
    (if (looking-at "<\\([^>]*\\)>")
	(let ((nick (match-string 1)))
	  (put-text-property (match-beginning 1) (match-end 1) 'face
			     (cons 'foreground-color
				   (erc-get-color-for-nick nick)))))))

(add-hook 'erc-insert-modify-hook 'erc-put-color-on-nick)
(global-set-key (kbd "<f6>") 'erc)

;;;; for colorful parentheses
(require 'rainbow-delimiters)
(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'scheme-mode-hook 'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-depth-1-face ((t (:foreground "green"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "gold"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "deep sky blue"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "green yellow"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "dark violet"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "magenta"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "light coral"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "RosyBrown2"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "gray100"))))
 '(rainbow-delimiters-unmatched-face ((t (:foreground "red")))))


;;;;org-mode
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t) 


;;;; autopair-configuration
(require 'autopair)
(autopair-global-mode)

(defun get-output (shell-comm)
  (interactive "sCommand: ")
  (insert (format "%s  ==>  %s" shell-comm (shell-command-to-string shell-comm))))

(defun insert-usaco-header ()
  (interactive)
  (insert (format "/*\nID: pylaure1\nPROG: %s\nLANG: C++\n*/\n" (file-name-sans-extension (file-name-nondirectory buffer-file-name)))))
