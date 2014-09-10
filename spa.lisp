;;;; spa.lisp

(in-package #:spa)

;;; "spa" goes here. Hacks and glory await!

(defmacro with-db (&body body)
  `(postmodern:with-connection '("spa" "spa" "password" "localhost" :pooled-p t)
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

(defun main ()
  (restas:start '#:spa :port 8080))
