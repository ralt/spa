(in-package #:spa)

(postmodern:defprepared type/get-all
    "SELECT id, name FROM type" :plists)

(postmodern:defprepared-with-names type/create (name)
  ("INSERT INTO type (name) VALUES ($1)" name) :none)
