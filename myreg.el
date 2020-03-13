;; register like utility

(defvar myreg--repository (a-list ))

(defun myreg--register (tag s)
  (setq myreg--repository
	(a-assoc myreg--repository tag s)))

(setq myreg-buff (generate-new-buffer "myreg"))

(defun myreg--display-content (s)
  (with-current-buffer myreg-buff
    (erase-buffer)
    (insert s)
    (beginning-of-buffer))
  (switch-to-buffer-other-window myreg-buff))

(defun myreg-view ()
  (interactive)
  (if myreg--repository
      (mylet [res (ido-completing-read
		   "select register: "
		   (a-keys myreg--repository))]
	     (myreg--display-content (a-get myreg--repository res)))
    (error "no register")))

(defun myreg-insert-region ()
  (interactive)
  (if (region-active-p)
      (mylet [s (buffer-substring-no-properties
		 (region-beginning)
		 (region-end))
		tag (read-string "insert to:" )]
	     (myreg--register tag s)
	     (message (format "%s was registered." s)))
    (error "no region is active.")))

(defun myreg--kill-string ()
  "Returns the content of the last kill as string."
  (with-temp-buffer
    (yank)
    (buffer-string)))

(defun myreg-insert-kill ()
  (interactive)
  (mylet [s (myreg--kill-string)
	    tag (read-string "insert to:" )]
	 (myreg--register tag s)
	 (message (format "%s was registered." s))))

(defun myreg-clear-all()
  (interactive)
  (setq myreg--repository nil))










