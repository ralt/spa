;;;; defmodule.lisp

(restas:define-module #:spa
  (:use #:cl))

(in-package #:spa)

(defparameter *template-directory*
  (merge-pathnames #P"templates/" spa-config:*base-directory*))

(defparameter *static-directory*
  (merge-pathnames #P"static/" spa-config:*base-directory*))

(restas:mount-module -static- (#:restas.directory-publisher)
  (:url "static")
  (restas.directory-publisher:*directory* *static-directory*))
