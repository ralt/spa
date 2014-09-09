(in-package #:spa)

(defun status/get-all-for-cat (cat-status-id)
  (mapcar #'(lambda (status)
              (setf (getf status :selected)
                    (= (getf status :id) cat-status-id))
              status)
          (status/get-all)))

(postmodern:defprepared status/get-all
    "SELECT id, name FROM status" :plists)

(postmodern:defprepared-with-names status/create (name)
  ("INSERT INTO status (name) VALUES ($1)" name) :none)
