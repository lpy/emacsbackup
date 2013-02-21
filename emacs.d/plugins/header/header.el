;;    In the Cynthia's name, pray with my soul
;;    Time-stamp: <Last modified by lpy on 2012-10-06 at 19:14:44>
;;    Author             : PeiYong Lin
;;    Email              : pylaurent1314@gmail.com
;;    File-name          : header.el
;;    Encoding           : -*- utf-8 -*-
;;    Description        : 
;;    Created On         : 2012/10/06 19:11:54

(defun header ()
   "This function is to add my own header comments in the file"
      (interactive)
	  (setq filename (file-name-nondirectory buffer-file-name))
	  (setq progname (file-name-sans-extension filename))
	  (setq suffix (file-name-extension filename))
	  (if (string= suffix "py")
        (insert "#!/usr/bin/env python\n"))
	  (if (string= suffix "py")
		  (insert "#    In the Cynthia's name, pray with my soul \n")
      (insert "/*    In the Cynthia's name, pray with my soul \n"))
	  (insert "#    Time-stamp: < >")
	  (insert "\n")
      (insert "#    Author             : PeiYong Lin\n")
	  (insert "#    Email              : pylaurent1314@gmail.com\n")
      (insert "#    File-name          : " filename "\n")
      (insert "#    Encoding           : -*- utf-8 -*-\n")
      (insert "#    Description        : \n")
      (insert "#    Created On         : " (format-time-string "%Y/%m/%d %H:%M:%S" (current-time))"\n")
      (if (string= suffix "py")
          (insert "#"))
      (insert "*****************************************************************/\n"))

(provide 'header)
