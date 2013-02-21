;;;; Time-stamp: <20/1/2012 23:42:12> 
;;;; using from ahei on http://code.google.com/p/dea/source/browse/trunk/my-lisps/auto-complete-c.el?r=769

(require 'auto-complete)

(defvar ac-c-sources
  '(ac-source-c-keywords))
;;;ac-define-dictionary-source
;;;ac-source-keywords
(setq ac-user-dictionary '("and" "bool" "do" "export" "goto" "return" "struct" "try" "xor" "break" "const" "double" "extern" "if" "short" "switch" "typedef" "xor_eq" "asm" "case" "false" "inline" "not" "signed" "typeid" "void" "auto" "catch" "continue" "else" "float" "int" "not_eq" "public" "sizeof" "this" "typename" "volatile""bitand" "char" "default" "enum" "for" "long" "operator" "register" "static" "union" "wchar_t" "bitor" "delete" "explicit" "mutable" "or" "true" "unsigned" "while"))

(defun ac-c-setup ()
  (setq ac-sources (append ac-c-sources ac-sources)))

(defun ac-c-init ()
  (add-hook 'c-mode-hook 'ac-c-setup))

(provide 'auto-complete-c)