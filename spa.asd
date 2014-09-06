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
               :ALEXANDRIA)
  :components ((:closure-template "templates/layout")
               (:closure-template "templates/cat")
               (:file "defmodule")
               (:file "spa")
               (:file "cat/db")
               (:file "cat/routes")))
