(in-package #:spa)

(defun type/get-all (filters)
  (let ((types (ps-type/get-all)))
    (loop for type in types
         collect (list
                  :id (getf type :id)
                  :name (getf type :name)
                  :selected (type/selected-p type filters)))))

(defun type/selected-p (type filters)
  (some #'(lambda (filter)
            (when (and (stringp filter) (not (string= "" filter)))
              (= (getf type :id) (parse-integer filter :junk-allowed nil))))
        filters))

(postmodern:defprepared ps-type/get-all
    "SELECT id, name FROM type" :plists)

(postmodern:defprepared-with-names type/create (name)
  ("INSERT INTO type (name) VALUES ($1)" name) :none)
