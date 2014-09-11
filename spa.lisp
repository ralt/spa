;;;; spa.lisp

(in-package #:spa)

;;; "spa" goes here. Hacks and glory await!

(defvar *db-host*)
(defvar *db-name*)
(defvar *db-user*)
(defvar *db-pass*)

(defmacro with-db (&body body)
  `(postmodern:with-connection (list *db-name* *db-user* *db-pass* *db-host* :pooled-p t)
     ,@body))

;; Use this function to do DB calls
;; fn is a defprepared-with-names function.
(defmacro db (fn &rest args)
  `(with-db
     (,fn ,@args)))

(defmacro concat (&body body)
  `(concatenate 'string ,@body))

(restas:define-route home ("")
  (spa.layout:main
   (list
    :title "SPA"
    :body "Frontpage")))

(defun main (args)
  (declare (ignore args))
  (set-config)
  (restas:start '#:spa :port 8080))

(defun set-config ()
  (let ((config (cl-json:decode-json-from-string (read-file))))
    (setf *db-host* (find-property config :dbhost))
    (setf *db-name* (find-property config :dbname))
    (setf *db-user* (find-property config :dbuser))
    (setf *db-pass* (find-property config :dbpass))))

(defun find-property (data prop)
  (mapcar #'(lambda (i)
              (when (eq (car i) prop)
                (return-from find-property (cdr i))))
          data))

(defun read-file ()
  (with-open-file (s "config.json")
    (let ((data (make-string (file-length s))))
      (read-sequence data s)
      data)))
