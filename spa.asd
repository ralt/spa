(defpackage #:spa-config (:export #:*base-directory*))
(defparameter spa-config:*base-directory* 
  (make-pathname :name nil :type nil :defaults *load-truename*))

(asdf:defsystem #:spa
  :serial t
  :description "Web project for the SPA (french charity)"
  :author "Florian Margaine <florian@margaine.com>"
  :license "MIT License"
  :defsystem-depends-on (#:closure-template)
  :depends-on (:RESTAS
               :CLOSURE-TEMPLATE
               :POSTMODERN
               :ALEXANDRIA
               :restas-directory-publisher)
  :components ((:closure-template "templates/layout")
               (:closure-template "templates/cat")
               (:closure-template "templates/users")
               (:file "defmodule")
               (:file "spa")
               (:file "cat/db")
               (:file "cat/routes")
               (:file "users/routes")
               (:file "users/db")))
