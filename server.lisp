(ql:quickload :hunchentoot)
(ql:quickload "ironclad")
(ql:quickload :flexi-streams)
(ql:quickload :cl-csv)
(ql:quickload :cl-json)

(setf path "/home/liquidcat/proj/PATA-Server/")

(defconstant *day-names*
           '("Monday" "Tuesday" "Wednesday"
	         "Thursday" "Friday" "Saturday"
	     "Sunday"))

(defun timestamp ()
  "returns current timestamp according to the server"
  (multiple-value-bind
           (second minute hour day month year day-of-week dst-p tz)
    	   (get-decoded-time)
           (format nil "~2,'0d:~2,'0d:~2,'0d ~d/~2,'0d/~d"
	    	 hour
	    	 minute
	    	 second
	    	 day
	    	 month
	    	 year)))

(defvar *server* (make-instance 'hunchentoot:easy-acceptor :port 4242))

;; (hunchentoot:define-easy-handler (say-yo :uri "/uploadAttendance") (absent)
;;   (setf (hunchentoot:content-type*) "text/plain")
;;   (with-open-file (stream (concatenate 'string path "attendance")
;; 			  :direction :output
;; 			  :if-exists :append
;; 			  :if-does-not-exist :create)
;;     (format stream "[~a]:~a~%" (timestamp) absent))
;;   (format nil "done"))

;; (defun attempt-login (user pass)
;;   "Checks the credentials and returns the entry of fields as a
;; list."
;;   (let ((result))
;;     (loop for cred in (cl-csv:read-csv #P"logins")
;; 	do (print (car cred))
;; 	do (print (cadr cred))
;; 	do (if (and (string= (cadr cred) pass) (string= (car cred) user))    
;; 	       (setf result cred)))
;;     result))

;; (hunchentoot:define-easy-handler (login :uri "/login") (user pass)
;;   (setf (hunchentoot:content-type*) "text/plain")
;;   (let ((credentials (attempt-login user pass)))
;;     (if credentials
;; 	(format nil "{ \"status\": \"success\", \"isFaculty\": ~a, \"id\": \"~a\" }"
;; 		(if (caddr credentials) "true" "false")
;; 		(caddr credentials)) ;json format
;; 	(format nil "{ \"status\": \"failure\", \"isFaculty\": ~a, \"id\": \"\" }"
;; 		(if (caddr credentials) "true" "false")))))   ;json format


;; (hunchentoot:define-easy-handler (get-schedule :uri "/getSchedule") (user pass scope)
;;   (setf (hunchentoot:content-type*) "text/plain")
;;   (let ((credentials (attempt-login user pass))
;; 	(split-scope (split-sequence:split-sequence #\, scope))) ;splits the input at commas
;;     (if (caddr credentials)		;only faculty will have id
;; 	(format nil
;; 		(cl-json:encode-json-alist-to-string
;; 		 (query-timetable (cons (caddr credentials) split-scope)
;; 				  *timetable*)))
;; 	(format nil "no schedule found"))))

;; (defun hash-string (string)
;;   "returns the SHA256 hash of STRING as a string"
;;   (ironclad:byte-array-to-hex-string
;;    (ironclad:digest-sequence :sha256
;; 			     (flexi-streams:string-to-octets string))))

;; (defun add-login (user pass &key (faculty nil) (id nil))
;;   "hashes and stores the password in the login file"
;;   (with-open-file (stream (concatenate 'string path "logins")
;; 			  :direction :output
;; 			  :if-exists :append
;; 			  :if-does-not-exist :create)
;;     (let ((pass-hash (hash-string pass)))
;;       (if faculty
;; 	  (format stream "~a,~a,~a~%" user pass-hash id)
;; 	  (format stream "~a,~a~%" user pass-hash)))))

;(hunchentoot:start *server*)
