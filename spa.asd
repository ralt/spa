(defpackage #:spa-config (:export #:*base-directory*))
(defparameter spa-config:*base-directory* #P"/home/florian/quicklisp/local-projects/spa/")

(asdf:defsystem #:spa
  :serial t
  :description "Web project for the SPA (french charity)"
  :author "Florian Margaine <florian@margaine.com>"
  :license "MIT License"
  :defsystem-depends-on (#:closure-template)
  :depends-on (:RESTAS
               :CLOSURE-TEMPLATE
               :POSTMODERN
               :LOCAL-TIME
               :CL-PASS
               :CL-JSON
               :restas-directory-publisher)
  :components ((:file "defmodule")
               ;; Must be before the templates
               (:file "cat/print-directives")
               (:closure-template "templates/layout")
               (:closure-template "templates/status")
               (:closure-template "templates/type")
               (:closure-template "templates/users")
               (:closure-template "templates/history")
               (:closure-template "templates/cat")
               (:file "spa")
               (:file "cat/db")
               (:file "cat/routes")
               (:file "users/db")
               (:file "users/routes")
               (:file "users/checker")
               (:file "status/db")
               (:file "status/routes")
               (:file "type/db")
               (:file "type/routes")
               (:file "history/db")
               (:file "history/routes")))
