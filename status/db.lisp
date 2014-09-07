(in-package #:spa)

(postmodern:defprepared status/get-all
    "SELECT id, name FROM status" :plists)
