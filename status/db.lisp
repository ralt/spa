(in-package #:spa)

(postmodern:defprepared status/get-all
    "SELECT id, name FROM status" :plists)

(postmodern:defprepared-with-names status/create (name)
  ("INSERT INTO status (name) VALUES ($1)" name) :none)
